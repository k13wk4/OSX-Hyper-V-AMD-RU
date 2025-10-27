## @file
# Скрипт конвертации EFI VHDX для Hyper-V
#
# Copyright (c)2023-2025, Cory Bennett. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

param (
 [string]$pwd = "$((Get-Item "$PSScriptRoot\..").FullName)",
 # Аргументы скрипта
 [string]$path = "$($pwd)\EFI",
 [string]$dest = "$($pwd)\EFI.vhdx"
)
$ErrorActionPreference = 'Stop'

# Запрос прав администратора
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
 Start-Process powershell.exe -Verb RunAs -ArgumentList ("-NoExit -noprofile -file `"{0}`" -elevated -pwd `"$pwd`" -name `"$name`" -version $version -cpu $cpu -ram $ram -size $size -outdir `"$outdir`"" -f ($myinvocation.MyCommand.Definition));
 exit;
}

# Предупреждение, если функция Microsoft-Hyper-V не включена
if (-not (Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -ErrorAction SilentlyContinue).State -eq 'Enabled') {
 Write-Warning "Функция Microsoft-Hyper-V не включена. " +
 "Пожалуйста, включите её в компонентах Windows перед созданием VM."
}


# Создаём и монтируем новый EFI.vhdx диск
Write-Host "Создание и монтирование EFI VHDX диска по пути $dest..."
$efiDisk = New-VHD -Path "$dest" -Dynamic -SizeBytes5GB |
 Mount-VHD -Passthru |
 Initialize-Disk -PartitionStyle "GPT" -Confirm:$false -Passthru |
 New-Partition -AssignDriveLetter -UseMaximumSize |
 Format-Volume -FileSystem "FAT32" -NewFileSystemLabel "EFI" -Confirm:$false -Force

# Копируем папку EFI на VHDX диск
Copy-Item -Path "$path" -Recurse -Destination "$($efiDisk.DriveLetter):\EFI"

# Копируем директорию Scripts (для post-install скриптов)
$scriptsDir = "$pwd\Scripts"
if (Test-Path -Path $scriptsDir) {
 # Копируем только shell-скрипты (.sh) для post-install
 $postInstallScripts = Get-ChildItem -Path $scriptsDir -Filter "*.sh" -Recurse
 if ($postInstallScripts) {
 # Создаём папку Scripts на VHDX диске
 New-Item -Path "$($efiDisk.DriveLetter):\Scripts" -ItemType Directory -Force | Out-Null

 # Копируем каждый скрипт в Scripts на VHDX диске
 Write-Host "Копирование post-install скриптов в $($efiDisk.DriveLetter):\Scripts"
 foreach ($script in $postInstallScripts) {
 $destinationPath = "$($efiDisk.DriveLetter):\Scripts\$($script.Name)"
 Copy-Item -Path $script.FullName -Destination $destinationPath -Force
 Write-Host "Скопирован скрипт: $($script.Name) в $destinationPath"
 }
 }
} else {
 Write-Host "Директория Scripts не найдена по пути $scriptsDir. Пропуск копирования."
}

# Копируем директорию Tools (для post-install демонов)
$toolsDir = "$pwd\Tools"
if (Test-Path -Path $toolsDir) {
 Copy-Item -Path $toolsDir -Recurse -Destination "$($efiDisk.DriveLetter):\Tools"
 Write-Host "Скопирована директория Tools в $($efiDisk.DriveLetter):\Tools"
} else {
 Write-Host "Директория Tools не найдена по пути $toolsDir. Пропуск копирования."
}

# Копируем образ восстановления macOS, если он есть
$recoveryImage = "com.apple.recovery.boot"
if (Test-Path -Path "$($pwd)\$recoveryImage") {
 Write-Host "Копирование образа восстановления macOS на EFI диск..."
 Copy-Item -Path "$($pwd)\$recoveryImage" -Recurse -Destination "$($efiDisk.DriveLetter):\$recoveryImage"
}

# Отмонтируем VHDX диск
Write-Host "Отмонтирование EFI VHDX диска..."
Dismount-VHD -Path "$dest" | Out-Null

Write-Host "Оптимизация EFI VHDX диска..."

# Оптимизируем VHDX (сжатие)
Mount-VHD -Path "$dest" -ReadOnly | Out-Null
Optimize-VHD -Path "$dest" -Mode Full
Dismount-VHD -Path "$dest" | Out-Null

# Сжимаем VHDX до минимального размера
Resize-VHD -Path "$dest" -ToMinimumSize

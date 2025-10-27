## @file
# Скрипт создания виртуальной машины Hyper-V
#
# Copyright (c)2023-2025, Cory Bennett. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

param (
 [string]$pwd = "$((Get-Item "$PSScriptRoot\..").FullName)",
 # Аргументы скрипта
 [string]$name = "macOS",
 [string]$version = "latest",
 [int]$cpu =2,
 [int]$ram =8, # Размер в ГБ
 [int]$size =50, #
 [string]$outdir = "$env:USERPROFILE\Documents\Hyper-V"
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

# Проверка существования каталога $outdir\$name (и не пустой ли он)
if ((Test-Path -Path "$outdir\$name") -and (Get-ChildItem -Path "$outdir\$name").Count -gt0) {
 Write-Host "Виртуальная машина '$name' уже существует в '$outdir'. Выберите другое имя или удалите существующую." 
 exit1
}


# Создаём новую виртуальную машину
Write-Host "Создаём виртуальную машину '$name'..."
New-VM -Generation2 -Name "$name" -path "$outdir" -NoVHD | Out-Null

# Настраиваем сетевой адаптер на использование Default Switch
Write-Host "Настройка сетевого адаптера для VM '$name'..."
$networkAdapter = Get-VMNetworkAdapter -VMName "$name"
Connect-VMNetworkAdapter -VMName "$name" -Name "$($networkAdapter.name)" -SwitchName "Default Switch"

# Создаём EFI диск
Write-Host "Создаём EFI диск для VM '$name'..."
$efiVHD = "$outdir\$name\EFI.vhdx"
& "$PSScriptRoot\create-macos-recovery.ps1" -version $version
& "$PSScriptRoot\convert-efi-disk.ps1" -dest $efiVHD
Add-VMHardDiskDrive -VMName "$name" -Path "$efiVHD" -ControllerType SCSI
$efiDisk = Get-VMHardDiskDrive -VMName "$name"

# Создаём диск для macOS
$macOSVHD = "$outdir\$name\$name.vhdx"
Write-Host "Создаём диск macOS для VM '$name'..."
New-VHD -Path "$macOSVHD" -SizeBytes $($size *1GB) |
 Mount-VHD -Passthru |
 Initialize-Disk -PartitionStyle "GPT" -Confirm:$false -Passthru |
 New-Partition -AssignDriveLetter -UseMaximumSize |
 Format-Volume -FileSystem "exFAT" -NewFileSystemLabel "macOS" -Confirm:$false -Force
Dismount-DiskImage -ImagePath "$macOSVHD" | Out-Null

# Добавляем диск macOS в VM
Write-Host "Добавляем macOS диск в VM '$name'..."
Add-VMHardDiskDrive -VMName "$name" -Path "$macOSVHD" -ControllerType SCSI

# Конфигурируем VM
Write-Host "Конфигурация VM '$name'..."
Set-VM `
 -Name "$name" `
 -ProcessorCount $cpu `
 -MemoryStartupBytes $($ram*1GB) `
 -AutomaticCheckpointsEnabled $false
Set-VMFirmware -VMName "$name" `
 -EnableSecureBoot Off `
 -FirstBootDevice $efiDisk

# Ожидание ввода пользователя для показа ошибок
Write-Host "`nВиртуальная машина '$name' успешно создана в $outdir\$name.`n"

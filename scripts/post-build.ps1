## @file
# Скрипт post-build для EFI проекта OSX Hyper-V
#
# Copyright (c)2023-2025, Cory Bennett. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

[CmdletBinding(PositionalBinding=$false)]
param (
 [string]$pwd = "$((Get-Item "$PSScriptRoot\..").FullName)",
)

$buildDir = "$pwd\dist"
if (-not (Test-Path $buildDir)) {
 throw (`
 "Не удалось найти директорию сборки OCE-Build. " +
 "Пожалуйста, убедитесь, что скрипт сборки был запущен перед запуском post-build скрипта.");
}

# Копируем скрипты настройки Hyper-V и post-install в 'dist/Scripts'
$ScriptsDir = "$pwd\dist\Scripts"
if (-not (Test-Path $ScriptsDir)) {
 New-Item -Path $ScriptsDir -ItemType Directory | Out-Null
 Copy-Item -Path "$PSScriptRoot\lib\*" -Destination $ScriptsDir
}

# Извлекаем инструменты MacHyperVSupport в 'dist/Tools'
$ToolsDir = "$pwd\dist\Tools"
if (-not (Test-Path $ToolsDir)) {
 # Извлекаем URL для MacHyperVSupport из lockfile
 $lockfile = Get-Content -Path "$pwd\src\build.lock" -Raw
 $lockfile -match "MacHyperVSupport:[\s\S]*?url: '([^\s]+)'" | Out-Null

 # Извлекаем содержимое архива MacHyperVSupport во временную директорию
 $TempDir = Get-Item "$([System.IO.Path]::GetTempPath())\ocebuild-unpack-*"
 if (-not $TempDir) {
 throw (`
 "Не удалось найти временную директорию OCE-Build. " +
 "Пожалуйста, убедитесь, что скрипт сборки был запущен перед запуском post-build скрипта.");
 }
 $MacHyperVSupport = "$TempDir\MacHyperVSupport.zip"
 iwr -Uri $Matches[1] -OutFile $MacHyperVSupport
 Expand-Archive -Path $MacHyperVSupport -Destination $TempDir

 # Перемещаем папку Tools в директорию сборки
 Move-Item -Path "$TempDir\Tools" -Destination $ToolsDir

 # Удаляем временные файлы
 if ($TempDir -match "ocebuild-unpack-") {
 Remove-Item -Path $TempDir\* -Recurse -Force
 }
}

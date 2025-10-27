## @file
# ������ post-build ��� EFI ������� OSX Hyper-V
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
 "�� ������� ����� ���������� ������ OCE-Build. " +
 "����������, ���������, ��� ������ ������ ��� ������� ����� �������� post-build �������.");
}

# �������� ������� ��������� Hyper-V � post-install � 'dist/Scripts'
$ScriptsDir = "$pwd\dist\Scripts"
if (-not (Test-Path $ScriptsDir)) {
 New-Item -Path $ScriptsDir -ItemType Directory | Out-Null
 Copy-Item -Path "$PSScriptRoot\lib\*" -Destination $ScriptsDir
}

# ��������� ����������� MacHyperVSupport � 'dist/Tools'
$ToolsDir = "$pwd\dist\Tools"
if (-not (Test-Path $ToolsDir)) {
 # ��������� URL ��� MacHyperVSupport �� lockfile
 $lockfile = Get-Content -Path "$pwd\src\build.lock" -Raw
 $lockfile -match "MacHyperVSupport:[\s\S]*?url: '([^\s]+)'" | Out-Null

 # ��������� ���������� ������ MacHyperVSupport �� ��������� ����������
 $TempDir = Get-Item "$([System.IO.Path]::GetTempPath())\ocebuild-unpack-*"
 if (-not $TempDir) {
 throw (`
 "�� ������� ����� ��������� ���������� OCE-Build. " +
 "����������, ���������, ��� ������ ������ ��� ������� ����� �������� post-build �������.");
 }
 $MacHyperVSupport = "$TempDir\MacHyperVSupport.zip"
 iwr -Uri $Matches[1] -OutFile $MacHyperVSupport
 Expand-Archive -Path $MacHyperVSupport -Destination $TempDir

 # ���������� ����� Tools � ���������� ������
 Move-Item -Path "$TempDir\Tools" -Destination $ToolsDir

 # ������� ��������� �����
 if ($TempDir -match "ocebuild-unpack-") {
 Remove-Item -Path $TempDir\* -Recurse -Force
 }
}

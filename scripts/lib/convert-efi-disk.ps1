## @file
# ������ ����������� EFI VHDX ��� Hyper-V
#
# Copyright (c)2023-2025, Cory Bennett. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

param (
 [string]$pwd = "$((Get-Item "$PSScriptRoot\..").FullName)",
 # ��������� �������
 [string]$path = "$($pwd)\EFI",
 [string]$dest = "$($pwd)\EFI.vhdx"
)
$ErrorActionPreference = 'Stop'

# ������ ���� ��������������
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
 Start-Process powershell.exe -Verb RunAs -ArgumentList ("-NoExit -noprofile -file `"{0}`" -elevated -pwd `"$pwd`" -name `"$name`" -version $version -cpu $cpu -ram $ram -size $size -outdir `"$outdir`"" -f ($myinvocation.MyCommand.Definition));
 exit;
}

# ��������������, ���� ������� Microsoft-Hyper-V �� ��������
if (-not (Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -ErrorAction SilentlyContinue).State -eq 'Enabled') {
 Write-Warning "������� Microsoft-Hyper-V �� ��������. " +
 "����������, �������� � � ����������� Windows ����� ��������� VM."
}


# ������ � ��������� ����� EFI.vhdx ����
Write-Host "�������� � ������������ EFI VHDX ����� �� ���� $dest..."
$efiDisk = New-VHD -Path "$dest" -Dynamic -SizeBytes5GB |
 Mount-VHD -Passthru |
 Initialize-Disk -PartitionStyle "GPT" -Confirm:$false -Passthru |
 New-Partition -AssignDriveLetter -UseMaximumSize |
 Format-Volume -FileSystem "FAT32" -NewFileSystemLabel "EFI" -Confirm:$false -Force

# �������� ����� EFI �� VHDX ����
Copy-Item -Path "$path" -Recurse -Destination "$($efiDisk.DriveLetter):\EFI"

# �������� ���������� Scripts (��� post-install ��������)
$scriptsDir = "$pwd\Scripts"
if (Test-Path -Path $scriptsDir) {
 # �������� ������ shell-������� (.sh) ��� post-install
 $postInstallScripts = Get-ChildItem -Path $scriptsDir -Filter "*.sh" -Recurse
 if ($postInstallScripts) {
 # ������ ����� Scripts �� VHDX �����
 New-Item -Path "$($efiDisk.DriveLetter):\Scripts" -ItemType Directory -Force | Out-Null

 # �������� ������ ������ � Scripts �� VHDX �����
 Write-Host "����������� post-install �������� � $($efiDisk.DriveLetter):\Scripts"
 foreach ($script in $postInstallScripts) {
 $destinationPath = "$($efiDisk.DriveLetter):\Scripts\$($script.Name)"
 Copy-Item -Path $script.FullName -Destination $destinationPath -Force
 Write-Host "���������� ������: $($script.Name) � $destinationPath"
 }
 }
} else {
 Write-Host "���������� Scripts �� ������� �� ���� $scriptsDir. ������� �����������."
}

# �������� ���������� Tools (��� post-install �������)
$toolsDir = "$pwd\Tools"
if (Test-Path -Path $toolsDir) {
 Copy-Item -Path $toolsDir -Recurse -Destination "$($efiDisk.DriveLetter):\Tools"
 Write-Host "����������� ���������� Tools � $($efiDisk.DriveLetter):\Tools"
} else {
 Write-Host "���������� Tools �� ������� �� ���� $toolsDir. ������� �����������."
}

# �������� ����� �������������� macOS, ���� �� ����
$recoveryImage = "com.apple.recovery.boot"
if (Test-Path -Path "$($pwd)\$recoveryImage") {
 Write-Host "����������� ������ �������������� macOS �� EFI ����..."
 Copy-Item -Path "$($pwd)\$recoveryImage" -Recurse -Destination "$($efiDisk.DriveLetter):\$recoveryImage"
}

# ����������� VHDX ����
Write-Host "�������������� EFI VHDX �����..."
Dismount-VHD -Path "$dest" | Out-Null

Write-Host "����������� EFI VHDX �����..."

# ������������ VHDX (������)
Mount-VHD -Path "$dest" -ReadOnly | Out-Null
Optimize-VHD -Path "$dest" -Mode Full
Dismount-VHD -Path "$dest" | Out-Null

# ������� VHDX �� ������������ �������
Resize-VHD -Path "$dest" -ToMinimumSize

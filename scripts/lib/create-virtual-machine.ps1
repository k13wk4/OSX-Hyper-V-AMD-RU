## @file
# ������ �������� ����������� ������ Hyper-V
#
# Copyright (c)2023-2025, Cory Bennett. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

param (
 [string]$pwd = "$((Get-Item "$PSScriptRoot\..").FullName)",
 # ��������� �������
 [string]$name = "macOS",
 [string]$version = "latest",
 [int]$cpu =2,
 [int]$ram =8, # ������ � ��
 [int]$size =50, #
 [string]$outdir = "$env:USERPROFILE\Documents\Hyper-V"
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

# �������� ������������� �������� $outdir\$name (� �� ������ �� ��)
if ((Test-Path -Path "$outdir\$name") -and (Get-ChildItem -Path "$outdir\$name").Count -gt0) {
 Write-Host "����������� ������ '$name' ��� ���������� � '$outdir'. �������� ������ ��� ��� ������� ������������." 
 exit1
}


# ������ ����� ����������� ������
Write-Host "������ ����������� ������ '$name'..."
New-VM -Generation2 -Name "$name" -path "$outdir" -NoVHD | Out-Null

# ����������� ������� ������� �� ������������� Default Switch
Write-Host "��������� �������� �������� ��� VM '$name'..."
$networkAdapter = Get-VMNetworkAdapter -VMName "$name"
Connect-VMNetworkAdapter -VMName "$name" -Name "$($networkAdapter.name)" -SwitchName "Default Switch"

# ������ EFI ����
Write-Host "������ EFI ���� ��� VM '$name'..."
$efiVHD = "$outdir\$name\EFI.vhdx"
& "$PSScriptRoot\create-macos-recovery.ps1" -version $version
& "$PSScriptRoot\convert-efi-disk.ps1" -dest $efiVHD
Add-VMHardDiskDrive -VMName "$name" -Path "$efiVHD" -ControllerType SCSI
$efiDisk = Get-VMHardDiskDrive -VMName "$name"

# ������ ���� ��� macOS
$macOSVHD = "$outdir\$name\$name.vhdx"
Write-Host "������ ���� macOS ��� VM '$name'..."
New-VHD -Path "$macOSVHD" -SizeBytes $($size *1GB) |
 Mount-VHD -Passthru |
 Initialize-Disk -PartitionStyle "GPT" -Confirm:$false -Passthru |
 New-Partition -AssignDriveLetter -UseMaximumSize |
 Format-Volume -FileSystem "exFAT" -NewFileSystemLabel "macOS" -Confirm:$false -Force
Dismount-DiskImage -ImagePath "$macOSVHD" | Out-Null

# ��������� ���� macOS � VM
Write-Host "��������� macOS ���� � VM '$name'..."
Add-VMHardDiskDrive -VMName "$name" -Path "$macOSVHD" -ControllerType SCSI

# ������������� VM
Write-Host "������������ VM '$name'..."
Set-VM `
 -Name "$name" `
 -ProcessorCount $cpu `
 -MemoryStartupBytes $($ram*1GB) `
 -AutomaticCheckpointsEnabled $false
Set-VMFirmware -VMName "$name" `
 -EnableSecureBoot Off `
 -FirstBootDevice $efiDisk

# �������� ����� ������������ ��� ������ ������
Write-Host "`n����������� ������ '$name' ������� ������� � $outdir\$name.`n"

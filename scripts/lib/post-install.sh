#!/bin/bash
# shellcheck disable=SC1091,SC2164

## @file
# Post-install ������ MacHyperVSupport
#
# Copyright (c)2023-2025, Cory Bennett. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

# ��������� � ������� ���������� ��� ��������
__PWD__=$(pwd); SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
cd "$(dirname "${SCRIPTS_DIR}")"

# ��������� ������� ���������� Tools/
if [[ ! -d "Tools" ]]; then
 echo "���������� Tools �� �������. ���� ������ ������ ����������� �� ���������� Scripts ������ EFI ����."
 exit 1
fi

if [[ $EUID -ne 0 ]]; then
 echo "���� ������ ������ ���� ������� � ������� root (����������� sudo ��� ��������� �� root)."
 exit 1
fi


PKG_BUILD_DIR="/tmp/pkg-build"
APP_SUPPORT_DIR="/Library/Application Support/MacHyperVSupport"
LAUNCH_DAEMON_DIR="/Library/LaunchDaemons"

sudo mkdir -p "${APP_SUPPORT_DIR}"
sudo mkdir -p "${LAUNCH_DAEMON_DIR}"


copy_daemon() {
 local daemon_path="$1"
 local plist_path="$2"

 local daemon_name="${daemon_path##*/}"
 local plist_name="${plist_path##*/}"

 if [[ -f "${daemon_path}" && -f "${plist_path}" ]]; then
 # ��������� �����, ���� �� ��� �������
 if sudo launchctl list | grep "${daemon_name}$"; then
 echo "��������� ������������ �����: ${daemon_name}"
 sudo launchctl unload "${LAUNCH_DAEMON_DIR}/${plist_name}"
 fi

 # �������� ����� � plist � ��������������� ����������
 sudo cp "${daemon_path}" "${APP_SUPPORT_DIR}/"
 sudo cp "${plist_path}" "${LAUNCH_DAEMON_DIR}/"

 # ������������� ��������� � �����
 sudo chown root:wheel "${APP_SUPPORT_DIR}/${daemon_name}"
 sudo chmod 755 "${APP_SUPPORT_DIR}/${daemon_name}"
 sudo chown root:wheel "${LAUNCH_DAEMON_DIR}/${plist_name}"
 sudo chmod 644 "${LAUNCH_DAEMON_DIR}/${plist_name}"

 # ��������� �����
 sudo launchctl load "${LAUNCH_DAEMON_DIR}/${plist_name}"
 else
 echo "����� ��� plist ��� ${daemon_name} �� ������."
 fi
}


# ������������� ������ Hyper-V ����� � launchd
(
 cd "Tools" || { echo "�� ������� ������� � ���������� Tools."; exit 1; }

 for plist in fish.goldfish64.*; do
 [ -e "${plist}" ] || continue
 # ��������� ��� ������ �� plist
 daemon="${plist%.plist}"
 daemon="${daemon#fish.goldfish64.}"
 if [[ -f "${daemon}" ]]; then
 echo "������������� �����: ${daemon}"
 copy_daemon "${daemon}" "${plist}"
 echo "������."
 fi
 done
)


FRAMEBUFFER_KEXT="EFI/OC/Kexts/MacHyperVFramebuffer.kext"
FRAMEBUFFER_KEXT_PATH="/Library/Extensions/MacHyperVFramebuffer.kext"
if [[ -d "${FRAMEBUFFER_KEXT}" ]]; then
 # ��������� kext, ���� �� ��� ��������
 if kextstat | grep -q "com.apple.driver.MacHyperVFramebuffer"; then
 echo "��������� ������������ MacHyperVFramebuffer kext..."
 sudo kextunload "${FRAMEBUFFER_KEXT_PATH}"
 fi

 echo "��������� MacHyperVFramebuffer kext...\n"
 echo "��� ������� ������ �� ��������� ������������ � ��������� ���������� > ������������������ � ������������ ��� �������� kext."
 echo "����� ����� ��� ����� ����� ������������� ����������� ������ ��� ���������� ���������."
 sudo cp -R "${FRAMEBUFFER_KEXT}" "/Library/Extensions/"
 sudo chown -R root:wheel "${FRAMEBUFFER_KEXT_PATH}"
 sudo chmod -R 755 "${FRAMEBUFFER_KEXT_PATH}"

 # �������� kext ���������� ��������� ������� �� ��������� � ��������� ����������
 echo "�������� MacHyperVFramebuffer kext..."
 sudo kextload "${FRAMEBUFFER_KEXT_PATH}"

 # ���������� ���� kext �����������, ��� ����� ������ ����� ������������ ��������
 echo "���������� ���� kext..."
 sudo kextcache -i /
elif [[ -d "${FRAMEBUFFER_KEXT_PATH}" ]]; then
 echo "MacHyperVFramebuffer kext ��� ���������� � ${FRAMEBUFFER_KEXT_PATH}."
 echo "���� ����� ��������������, ������� ��� �������:
 sudo rm -rf ${FRAMEBUFFER_KEXT_PATH}"
else
 echo "MacHyperVFramebuffer kext �� ������. ���������, ��� �� ��������� � EFI/OC/Kexts."
fi

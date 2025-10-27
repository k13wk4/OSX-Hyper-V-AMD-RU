#!/bin/bash
# shellcheck disable=SC1091,SC2164

## @file
# Post-install скрипт MacHyperVSupport
#
# Copyright (c)2023-2025, Cory Bennett. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

# Переходим в рабочую директорию для импортов
__PWD__=$(pwd); SCRIPTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
cd "$(dirname "${SCRIPTS_DIR}")"

# Проверяем наличие директории Tools/
if [[ ! -d "Tools" ]]; then
 echo "Директория Tools не найдена. Этот скрипт должен запускаться из директории Scripts внутри EFI тома."
 exit 1
fi

if [[ $EUID -ne 0 ]]; then
 echo "Этот скрипт должен быть запущен с правами root (используйте sudo или запустите от root)."
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
 # Выгружаем демон, если он уже запущен
 if sudo launchctl list | grep "${daemon_name}$"; then
 echo "Выгружаем существующий демон: ${daemon_name}"
 sudo launchctl unload "${LAUNCH_DAEMON_DIR}/${plist_name}"
 fi

 # Копируем демон и plist в соответствующие директории
 sudo cp "${daemon_path}" "${APP_SUPPORT_DIR}/"
 sudo cp "${plist_path}" "${LAUNCH_DAEMON_DIR}/"

 # Устанавливаем владельца и права
 sudo chown root:wheel "${APP_SUPPORT_DIR}/${daemon_name}"
 sudo chmod 755 "${APP_SUPPORT_DIR}/${daemon_name}"
 sudo chown root:wheel "${LAUNCH_DAEMON_DIR}/${plist_name}"
 sudo chmod 644 "${LAUNCH_DAEMON_DIR}/${plist_name}"

 # Загружаем демон
 sudo launchctl load "${LAUNCH_DAEMON_DIR}/${plist_name}"
 else
 echo "Демон или plist для ${daemon_name} не найден."
 fi
}


# Устанавливаем каждый Hyper-V демон в launchd
(
 cd "Tools" || { echo "Не удалось перейти в директорию Tools."; exit 1; }

 for plist in fish.goldfish64.*; do
 [ -e "${plist}" ] || continue
 # Извлекаем имя демона из plist
 daemon="${plist%.plist}"
 daemon="${daemon#fish.goldfish64.}"
 if [[ -f "${daemon}" ]]; then
 echo "Устанавливаем демон: ${daemon}"
 copy_daemon "${daemon}" "${plist}"
 echo "Готово."
 fi
 done
)


FRAMEBUFFER_KEXT="EFI/OC/Kexts/MacHyperVFramebuffer.kext"
FRAMEBUFFER_KEXT_PATH="/Library/Extensions/MacHyperVFramebuffer.kext"
if [[ -d "${FRAMEBUFFER_KEXT}" ]]; then
 # Выгружаем kext, если он уже загружен
 if kextstat | grep -q "com.apple.driver.MacHyperVFramebuffer"; then
 echo "Выгружаем существующий MacHyperVFramebuffer kext..."
 sudo kextunload "${FRAMEBUFFER_KEXT_PATH}"
 fi

 echo "Установка MacHyperVFramebuffer kext...\n"
 echo "Это вызовет запрос на одобрение разработчика в Системных настройках > Конфиденциальность и безопасность для загрузки kext."
 echo "После этого вам нужно будет перезагрузить виртуальную машину для завершения установки."
 sudo cp -R "${FRAMEBUFFER_KEXT}" "/Library/Extensions/"
 sudo chown -R root:wheel "${FRAMEBUFFER_KEXT_PATH}"
 sudo chmod -R 755 "${FRAMEBUFFER_KEXT_PATH}"

 # Загрузка kext инициирует появление запроса на одобрение в Системных настройках
 echo "Загрузка MacHyperVFramebuffer kext..."
 sudo kextload "${FRAMEBUFFER_KEXT_PATH}"

 # Пересборка кэша kext гарантирует, что новая версия будет использована системой
 echo "Пересборка кэша kext..."
 sudo kextcache -i /
elif [[ -d "${FRAMEBUFFER_KEXT_PATH}" ]]; then
 echo "MacHyperVFramebuffer kext уже установлен в ${FRAMEBUFFER_KEXT_PATH}."
 echo "Если нужно переустановить, удалите его сначала:
 sudo rm -rf ${FRAMEBUFFER_KEXT_PATH}"
else
 echo "MacHyperVFramebuffer kext не найден. Убедитесь, что он находится в EFI/OC/Kexts."
fi

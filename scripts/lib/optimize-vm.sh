#!/usr/bin/env bash

## @file
# Пост-инсталляционный скрипт - оптимизация macOS виртуальных машин для Hyper-V
#
# Copyright (c)2023-2025, Cory Bennett. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##


# Запрашиваем sudo и поддерживаем активную сессию
sudo -v
while true; do sudo -n true; sleep60; kill -0 "$$" || exit; done2>/dev/null &
osascript -e "tell application \"System Preferences\" to quit"

# Константы
KERNEL=$(uname -r)

################################################################################
# Оптимизации при загрузке #
################################################################################

# Отключает сохранение состояния приложений при выходе/выключении
defaults write com.apple.loginwindow TALLogoutSavesState -bool false

# Пропустить экран GUI логина (автовход)
defaults write com.apple.loginwindow autoLoginUser -bool true
# Отключить фон экрана входа
sudo defaults write /Library/Preferences/com.apple.loginwindow DesktopPicture ""

################################################################################
# Оптимизации для серверных задач #
################################################################################

# Отключить блокировку экрана
defaults write com.apple.loginwindow DisableScreenLock -bool true
# Отключает автоматическое завершение неактивных приложений
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true
# Отключить автоматический выход
sudo defaults write GlobalPreferences com.apple.autologout.AutoLogOutDelay0

# Включить режим сервера - выделяет дополнительные ресурсы для серверных приложений
# @see https://support.apple.com/en-us/HT202528
if [[ $(cut -d. -f1 <<< "$KERNEL") -ge15 ]]; then
 sudo nvram boot-args="serverperfmode=1 $(nvram boot-args2>/dev/null | cut -f2-)"
else
 serverinfo --setperfmode1
fi

# Проверять и устанавливать критические обновления ежедневно
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
defaults write com.apple.SoftwareUpdate ConfigDataInstall -bool true
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -bool true
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int1
# Отключить автоматическую загрузку обновлений и перезагрузки
defaults write com.apple.SoftwareUpdate AutomaticUpdateRestartRequired -bool false
defaults write com.apple.SoftwareUpdate AutomaticDownload -bool false

# Авто-перезагрузка при зависании системы
sudo systemsetup -setrestartfreeze on

################################################################################
# Оптимизации диска/IO #
################################################################################

# Отключить индексирование Spotlight
sudo mdutil -i off -a

# Показать папку /Volumes
sudo chflags nohidden /Volumes

# Включить дополнительные опции дисковой утилиты
defaults write com.apple.DiskUtility advanced-image-options -bool true
# Показать детали в First Aid
defaults write com.apple.DiskUtility DUShowDetailsInFirstAid -bool true
# Отключить проверку контрольных сумм для дисковых образов
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Отключить гибернацию
sudo pmset -a hibernatemode0
# Удалить sleep image чтобы сохранить место на диске
sudo rm /Private/var/vm/sleepimage
sudo touch /Private/var/vm/sleepimage
sudo chflags uchg /Private/var/vm/sleepimage

# По умолчанию безопасно очищать Корзину
defaults write com.apple.finder EmptyTrashSecurely -bool true

################################################################################
# Оптимизации сети #
################################################################################

# Отключает создание .DS_Store на SMB-шарах
# @see https://support.apple.com/en-us/HT208209
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Разрешает osascript по SSH без предупреждений
defaults write com.apple.universalaccessAuthWarning /System/Applications/Utilities/Terminal.app -bool true
defaults write com.apple.universalaccessAuthWarning /usr/libexec -bool true
defaults write com.apple.universalaccessAuthWarning /usr/libexec/sshd-keygen-wrapper -bool true
defaults write com.apple.universalaccessAuthWarning com.apple.Terminal -bool true

################################################################################
# Оптимизации VESA/графики #
################################################################################

# Включить субпиксельный рендеринг шрифтов для не-Apple LCD
defaults write NSGlobalDomain AppleFontSmoothing -int1

# Уменьшить motion и прозрачность
defaults write com.apple.Accessibility DifferentiateWithoutColor -int1
defaults write com.apple.Accessibility ReduceMotionEnabled -int1
defaults write com.apple.universalaccess reduceMotion -int1
defaults write com.apple.universalaccess reduceTransparency -int1
defaults write com.apple.Accessibility ReduceMotionEnabled -int1

# Отключить все анимации macOS
defaults write -g NSScrollViewRubberbanding -int0
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSScrollAnimationEnabled -bool false
defaults write -g NSWindowResizeTime -float0.001
defaults write -g QLPanelAnimationDuration -float0
defaults write -g NSScrollViewRubberbanding -bool false
defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false
defaults write -g NSToolbarFullScreenAnimationDuration -float0
defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float0
defaults write com.apple.dock autohide-time-modifier -float0
defaults write com.apple.dock autohide-delay -float0
defaults write com.apple.dock expose-animation-duration -float0
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock springboard-show-duration -float0
defaults write com.apple.dock springboard-hide-duration -float0
defaults write com.apple.dock springboard-page-duration -float0
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write NSGlobalDomain NSWindowResizeTime .001

################################################################################

# Применяем обновлённые настройки
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
defaults write com.apple.activatesettings log true

# Перезапускаем затронутые приложения
for app in "cfprefsd" "Dock" "Finder" "SystemUIServer" "Terminal"; do
 killall "${app}" > /dev/null2>&1
done

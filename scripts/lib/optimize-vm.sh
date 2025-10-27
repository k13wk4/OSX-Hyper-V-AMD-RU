#!/usr/bin/env bash

## @file
# ����-��������������� ������ - ����������� macOS ����������� ����� ��� Hyper-V
#
# Copyright (c)2023-2025, Cory Bennett. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##


# ����������� sudo � ������������ �������� ������
sudo -v
while true; do sudo -n true; sleep60; kill -0 "$$" || exit; done2>/dev/null &
osascript -e "tell application \"System Preferences\" to quit"

# ���������
KERNEL=$(uname -r)

################################################################################
# ����������� ��� �������� #
################################################################################

# ��������� ���������� ��������� ���������� ��� ������/����������
defaults write com.apple.loginwindow TALLogoutSavesState -bool false

# ���������� ����� GUI ������ (��������)
defaults write com.apple.loginwindow autoLoginUser -bool true
# ��������� ��� ������ �����
sudo defaults write /Library/Preferences/com.apple.loginwindow DesktopPicture ""

################################################################################
# ����������� ��� ��������� ����� #
################################################################################

# ��������� ���������� ������
defaults write com.apple.loginwindow DisableScreenLock -bool true
# ��������� �������������� ���������� ���������� ����������
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true
# ��������� �������������� �����
sudo defaults write GlobalPreferences com.apple.autologout.AutoLogOutDelay0

# �������� ����� ������� - �������� �������������� ������� ��� ��������� ����������
# @see https://support.apple.com/en-us/HT202528
if [[ $(cut -d. -f1 <<< "$KERNEL") -ge15 ]]; then
 sudo nvram boot-args="serverperfmode=1 $(nvram boot-args2>/dev/null | cut -f2-)"
else
 serverinfo --setperfmode1
fi

# ��������� � ������������� ����������� ���������� ���������
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
defaults write com.apple.SoftwareUpdate ConfigDataInstall -bool true
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -bool true
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int1
# ��������� �������������� �������� ���������� � ������������
defaults write com.apple.SoftwareUpdate AutomaticUpdateRestartRequired -bool false
defaults write com.apple.SoftwareUpdate AutomaticDownload -bool false

# ����-������������ ��� ��������� �������
sudo systemsetup -setrestartfreeze on

################################################################################
# ����������� �����/IO #
################################################################################

# ��������� �������������� Spotlight
sudo mdutil -i off -a

# �������� ����� /Volumes
sudo chflags nohidden /Volumes

# �������� �������������� ����� �������� �������
defaults write com.apple.DiskUtility advanced-image-options -bool true
# �������� ������ � First Aid
defaults write com.apple.DiskUtility DUShowDetailsInFirstAid -bool true
# ��������� �������� ����������� ���� ��� �������� �������
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# ��������� ����������
sudo pmset -a hibernatemode0
# ������� sleep image ����� ��������� ����� �� �����
sudo rm /Private/var/vm/sleepimage
sudo touch /Private/var/vm/sleepimage
sudo chflags uchg /Private/var/vm/sleepimage

# �� ��������� ��������� ������� �������
defaults write com.apple.finder EmptyTrashSecurely -bool true

################################################################################
# ����������� ���� #
################################################################################

# ��������� �������� .DS_Store �� SMB-�����
# @see https://support.apple.com/en-us/HT208209
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# ��������� osascript �� SSH ��� ��������������
defaults write com.apple.universalaccessAuthWarning /System/Applications/Utilities/Terminal.app -bool true
defaults write com.apple.universalaccessAuthWarning /usr/libexec -bool true
defaults write com.apple.universalaccessAuthWarning /usr/libexec/sshd-keygen-wrapper -bool true
defaults write com.apple.universalaccessAuthWarning com.apple.Terminal -bool true

################################################################################
# ����������� VESA/������� #
################################################################################

# �������� ������������� ��������� ������� ��� ��-Apple LCD
defaults write NSGlobalDomain AppleFontSmoothing -int1

# ��������� motion � ������������
defaults write com.apple.Accessibility DifferentiateWithoutColor -int1
defaults write com.apple.Accessibility ReduceMotionEnabled -int1
defaults write com.apple.universalaccess reduceMotion -int1
defaults write com.apple.universalaccess reduceTransparency -int1
defaults write com.apple.Accessibility ReduceMotionEnabled -int1

# ��������� ��� �������� macOS
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

# ��������� ���������� ���������
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
defaults write com.apple.activatesettings log true

# ������������� ���������� ����������
for app in "cfprefsd" "Dock" "Finder" "SystemUIServer" "Terminal"; do
 killall "${app}" > /dev/null2>&1
done

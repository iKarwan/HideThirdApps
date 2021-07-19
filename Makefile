THEOS_DEVICE_IP = 192.168.0.13
export ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:11.0

#DEBUG = 0
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)
#FINALPACKAGE = 1
#GO_EASY_ON_ME = 1

INSTALL_TARGET_PROCESSES =  Preferences


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HideThirdApps

HideThirdApps_FILES = Tweak.x
HideThirdApps_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

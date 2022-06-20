ARCHS = arm64 arm64e
THEOS_DEVICE_IP = Xr#localhost -p 2222
TARGET := iphone:clang:latest:12.2
INSTALL_TARGET_PROCESSES = SpringBoard
PACKAGE_VERSION = 4.20

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DankTime

DankTime_FILES = $(shell find Sources/DankTime -name '*.swift') $(shell find Sources/DankTimeC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
DankTime_SWIFTFLAGS = -ISources/DankTimeC/include
DankTime_CFLAGS = -fobjc-arc -ISources/DankTimeC/include

include $(THEOS_MAKE_PATH)/tweak.mk

THEOS_DEVICE_IP = 192.168.1.45

ARCHS = arm64 arm64e
TARGET = iphone::12.0:latest

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = dictationkeyhook
dictationkeyhook_FILES = Tweak.xm
dictationkeyhook_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "/bin/rm -rf /var/mobile/Library/Caches/com.apple.keyboards/"

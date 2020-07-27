ARCHS = arm64 arm64e
TARGET = iphone:clang:12.2:12.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = dictationkeyhook
dictationkeyhook_FILES = $(wildcard *.xm *.m)
dictationkeyhook_EXTRA_FRAMEWORKS = libhdev
dictationkeyhook_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += pref

include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "/bin/rm -rf /var/mobile/Library/Caches/com.apple.keyboards/"

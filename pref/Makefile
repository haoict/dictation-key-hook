ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = DKHPref
DKHPref_FILES = $(wildcard *.m)
DKHPref_INSTALL_PATH = /Library/PreferenceBundles
DKHPref_PRIVATE_FRAMEWORKS = Preferences
DKHPref_EXTRA_FRAMEWORKS = libhdev
DKHPref_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/DKHPref.plist$(ECHO_END)

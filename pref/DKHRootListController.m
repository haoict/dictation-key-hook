#include "DKHRootListController.h"

#define TWEAK_TITLE "EmojiKey++"
#define TINT_COLOR "#adb4be"
#define BUNDLE_NAME "DKHPref"

@implementation DKHRootListController
- (id)init {
  self = [super init];
  if (self) {
    self.tintColorHex = @TINT_COLOR;
    self.bundlePath = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@.bundle", @BUNDLE_NAME];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[self localizedItem:@"APPLY"] style:UIBarButtonItemStylePlain target:self action:@selector(apply)];;
  }
  return self;
}

- (void)apply {
  [HCommon killProcess:@"backboardd" viewController:self alertTitle:@TWEAK_TITLE message:[self localizedItem:@"DO_YOU_REALLY_WANT_TO_RESPRING"] confirmActionLabel:[self localizedItem:@"CONFIRM"] cancelActionLabel:[self localizedItem:@"CANCEL"]];
}

@end

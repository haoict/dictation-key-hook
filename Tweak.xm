#define EMOJI_ICON_IMAGE "emoji_people.png"

@interface UIKBTree : NSObject
@property (nonatomic,retain) NSString * name;
@property (nonatomic,retain) NSMutableDictionary * properties;
@end

@interface UIKeyboardInputMode : NSObject
@property (nonatomic,retain) NSString * normalizedIdentifier; 
@end

@interface UIKeyboardInputModeController : NSObject
@property (retain) UIKeyboardInputMode * currentInputMode;
@property (nonatomic,retain) UIKeyboardInputMode * nextInputModeToUse;
+ (id)sharedInputModeController;
- (id)activeInputModes;
@end

static void switchToEmojiKeyboard() {
  UIKeyboardInputModeController *kimController = [UIKeyboardInputModeController sharedInputModeController];
  UIKeyboardInputMode *currentInputMode = [kimController currentInputMode];

  if ([currentInputMode.normalizedIdentifier isEqual:@"emoji"]) {
    kimController.currentInputMode = kimController.nextInputModeToUse;
    return;
  }

  NSArray* activeInputModes = [kimController activeInputModes];
  for (int i = 0; i < [activeInputModes count]; i++) {
    UIKeyboardInputMode *mode = [activeInputModes objectAtIndex:i];
    if ([mode.normalizedIdentifier isEqual:@"emoji"]) {
      kimController.nextInputModeToUse = currentInputMode;
      kimController.currentInputMode = mode;
      break;
    }
  }
}

/* Debug helper 
static void showAlertMessage(NSString *message) {
  __block UIWindow* topWindow;
  topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  topWindow.rootViewController = [UIViewController new];
  topWindow.windowLevel = UIWindowLevelAlert + 1;
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    topWindow.hidden = YES;
    topWindow = nil;
  }]];

  [topWindow makeKeyAndVisible];
  [topWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}
*/

%hook UISystemKeyboardDockController
- (void)dictationItemButtonWasPressed:(id)arg1 withEvent:(id)arg2 {
  NSSet *event = [arg2 allTouches];
  if (event) {
    id uiTouch = event.allObjects[0];
    if([NSStringFromClass([uiTouch classForCoder]) isEqual:@"UITouch"]){
      // check if phase is UITouchPhase.UITouchPhaseBegan);
      if ([uiTouch phase] == 0) {
        switchToEmojiKeyboard();
      }
    }
  }
}
%end

%hook UIKeyboardLayoutStar
- (UIKBTree*)keyHitTest:(CGPoint)arg1 {
  UIKBTree* orig = %orig;
  if (orig && [orig.name isEqualToString:@"Dictation-Key"]) {
    // showAlertMessage(orig.name);
    orig.properties[@"KBinteractionType"] = @(0);
    switchToEmojiKeyboard();
  }
  return orig;
}

- (BOOL)shouldShowDictationKey {
  return TRUE;
}

- (int)stateForDictationKey:(id)arg1 {
  // 0: hidden
  // 1: Disabled
  // 2: Enabled (white background like normal keys)
  // 3: ?? same as 2
  // 4: Enabled (gray background like globe key)
  // >4: ?? same as 4 or 2
  return 2;
}
%end

%hook UIKBRenderFactory
- (id)dictationKeyImageName {
  // orig is dismiss_portrait.png
  // we need to replace microphone icon with emoji icon
  // https://github.com/ghuntley/ios-artwork/tree/master/iPad%20Simulator%207.0%20artwork/UIKit%20framework%20UIKit_NewArtwork
  // keyboard cache clear is required
  // /bin/rm -rf /var/mobile/Library/Caches/com.apple.keyboards/
  return @EMOJI_ICON_IMAGE;
}
%end

%hook UIKBRenderFactoryiPhone
- (id)dictationKeyImageName {
  return @EMOJI_ICON_IMAGE;
}
%end

%hook UIKBRenderFactoryiPhoneLandscape
- (id)dictationKeyImageName {
  return @EMOJI_ICON_IMAGE;
}
%end

%hook UIKBRenderFactoryiPad
- (id)dictationKeyImageName {
  return @EMOJI_ICON_IMAGE;
}
%end

%hook UIKBRenderFactoryiPadLandscape
- (id)dictationKeyImageName {
  return @EMOJI_ICON_IMAGE;
}
%end

%hook UIKBRenderFactoryiPadSplit
- (id)dictationKeyImageName {
  return @EMOJI_ICON_IMAGE;
}
%end

// TODO: skip emoji mode when tap globe button
// Candicated methods:
// UIKeyboardImpl
// setInputModeToNextInPreferredListWithExecutionContext:
// setKeyboardInputMode:userInitiated:updateIndicator:executionContext:
// setInputMode:userInitiated:updateIndicator:executionContext:

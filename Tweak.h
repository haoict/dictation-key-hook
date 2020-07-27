#import <Foundation/Foundation.h>
#import <libhdev/HUtilities/HCommon.h>

#define PLIST_PATH "/var/mobile/Library/Preferences/com.haoict.dictationkeyhookpref.plist"
#define PREF_CHANGED_NOTIF "com.haoict.dictationkeyhook/PrefChanged"

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
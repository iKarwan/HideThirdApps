#import <Foundation/Foundation.h>

@interface NSUserDefaults (Tweak_Category)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

static NSString * nsDomainString = @"me.ikghd.htapps";
static NSString * nsNotificationString = @"me.ikghd.htapps/preferences.changed";
static BOOL enabled;

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSNumber * enabledValue = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enabled" inDomain:nsDomainString];
	enabled = (enabledValue)? [enabledValue boolValue] : YES;
}

//thirdpartyappstoreapps
%hook PSUIPrefsListController
- (void)_reallyLoadThirdPartySpecifiersForApps:(id)arg1  shouldAddAppClipSpecifier:(BOOL)arg2  withCompletion:(id)arg3
{
  if(enabled)
{
  %orig(arg1, arg2, nil);
}
 else return %orig;
}
%end

%ctor {
	// Set variables on start up
	notificationCallback(NULL, NULL, NULL, NULL, NULL);

	// Register for 'PostNotification' notifications
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, (CFStringRef)nsNotificationString, NULL, CFNotificationSuspensionBehaviorCoalesce);

	// Add any personal initializations

}

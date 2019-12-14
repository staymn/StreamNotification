#import "StreamNotificationsPlugin.h"
#if __has_include(<stream_notifications/stream_notifications-Swift.h>)
#import <stream_notifications/stream_notifications-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "stream_notifications-Swift.h"
#endif

@implementation StreamNotificationsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftStreamNotificationsPlugin registerWithRegistrar:registrar];
}
@end

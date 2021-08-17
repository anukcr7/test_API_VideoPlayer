#import "TestApiVideoPlayerPlugin.h"
#if __has_include(<test_api_video_player/test_api_video_player-Swift.h>)
#import <test_api_video_player/test_api_video_player-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "test_api_video_player-Swift.h"
#endif

@implementation TestApiVideoPlayerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTestApiVideoPlayerPlugin registerWithRegistrar:registrar];
}
@end

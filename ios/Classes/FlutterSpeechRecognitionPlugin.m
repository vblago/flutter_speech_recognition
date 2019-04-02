#import "FlutterSpeechRecognitionPlugin.h"
#import <flutter_speech_recognition/flutter_speech_recognition-Swift.h>

@implementation FlutterSpeechRecognitionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSpeechRecognitionPlugin registerWithRegistrar:registrar];
}
@end

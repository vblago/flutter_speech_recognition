import 'dart:async';

import 'dart:ui';
import 'package:flutter/services.dart';

typedef void AvailabilityHandler(bool result);
typedef void StringResultHandler(String text);

class FlutterSpeechRecognition {
  static const MethodChannel _channel =
  const MethodChannel('flutter_speech_recognition');

  static final FlutterSpeechRecognition _speech = new FlutterSpeechRecognition._internal();

  factory FlutterSpeechRecognition() => _speech;

  FlutterSpeechRecognition._internal() {
    _channel.setMethodCallHandler(_platformCallHandler);
  }

  AvailabilityHandler availabilityHandler;

  StringResultHandler currentLocaleHandler;
  StringResultHandler recognitionResultHandler;

  VoidCallback recognitionStartedHandler;

  StringResultHandler recognitionCompleteHandler;

  VoidCallback errorHandler;

  /// ask for speech  recognizer permission
  Future activate() => _channel.invokeMethod("speech.activate");

  /// start listening
  Future listen({String locale}) =>
      _channel.invokeMethod("speech.listen", locale);

  /// cancel speech
  Future cancel() => _channel.invokeMethod("speech.cancel");

  /// stop listening
  Future stop() => _channel.invokeMethod("speech.stop");

  Future _platformCallHandler(MethodCall call) async {
    print("_platformCallHandler call ${call.method} ${call.arguments}");
    switch (call.method) {
      case "speech.onSpeechAvailability":
        availabilityHandler(call.arguments);
        break;
      case "speech.onCurrentLocale":
        currentLocaleHandler(call.arguments);
        break;
      case "speech.onSpeech":
        recognitionResultHandler(call.arguments);
        break;
      case "speech.onRecognitionStarted":
        recognitionStartedHandler();
        break;
      case "speech.onRecognitionComplete":
        recognitionCompleteHandler(call.arguments);
        break;
      case "speech.onError":
        errorHandler();
        break;
      default:
        print('Unknowm method ${call.method} ');
    }
  }

  // define a method to handle availability / permission result
  void setAvailabilityHandler(AvailabilityHandler handler) =>
      availabilityHandler = handler;

  // define a method to handle recognition result
  void setRecognitionResultHandler(StringResultHandler handler) =>
      recognitionResultHandler = handler;

  // define a method to handle native call
  void setRecognitionStartedHandler(VoidCallback handler) =>
      recognitionStartedHandler = handler;

  // define a method to handle native call
  void setRecognitionCompleteHandler(StringResultHandler handler) =>
      recognitionCompleteHandler = handler;

  void setCurrentLocaleHandler(StringResultHandler handler) =>
      currentLocaleHandler = handler;

  void setErrorHandler(VoidCallback handler) => errorHandler = handler;
}
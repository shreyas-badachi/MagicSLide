// lib/features/home/viewmodel/home_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:magicslide/core/models/generate_request.dart';
import '../../core/models/constants/constants.dart';
class HomeViewModel extends ChangeNotifier {
  String topic = '';
  String template = 'bullet-point1';
  int slideCount = 10;

  String language = 'en';

  final List<Map<String, String>> languages = [
    {'label': 'English', 'value': 'en'},
    {'label': 'Hindi', 'value': 'hi'},
  ];

  bool aiImages = false;
  bool imageEach = true;
  bool googleImage = false;
  bool googleText = false;
  String model = 'gpt-3.5';
  String presentationFor = 'student';
  String watermarkWidth = '';
  String watermarkHeight = '';
  String watermarkUrl = '';
  String watermarkPosition = 'BottomRight';
  String get languageLabel =>
      languages.firstWhere((e) => e['value'] == language)['label'] ?? 'English';
  String valueForLabel(String label) =>
      languages.firstWhere((e) => e['label'] == label)['value'] ?? 'en';
  GenerateRequest buildRequest(String email) {
    return GenerateRequest(
      topic: topic,
      email: email,
      accessId: AppConstants.magicSlidesAccessId,
      template: template,
      language: language,
      slideCount: slideCount,
      aiImages: aiImages,
      imageForEachSlide: imageEach,
      googleImage: googleImage,
      googleText: googleText,
      model: model,
      presentationFor: presentationFor,
      watermark: watermarkUrl.isNotEmpty
          ? {
        'width': watermarkWidth,
        'height': watermarkHeight,
        'brandURL': watermarkUrl,
        'position': watermarkPosition
      }
          : null,
    );
  }
}

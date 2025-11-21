class GenerateRequest {
  final String topic;
  final String email;
  final String accessId;
  final String template;
  final String? extraInfoSource;
  final String? language;
  final int? slideCount;
  final bool? aiImages;
  final bool? imageForEachSlide;
  final bool? googleImage;
  final bool? googleText;
  final String? model;
  final String? presentationFor;
  final Map<String, dynamic>? watermark;


  GenerateRequest({
    required this.topic,
    required this.email,
    required this.accessId,
    required this.template,
    this.extraInfoSource,
    this.language,
    this.slideCount,
    this.aiImages,
    this.imageForEachSlide,
    this.googleImage,
    this.googleText,
    this.model,
    this.presentationFor,
    this.watermark,
  });


  Map<String, dynamic> toJson() {
    return {
      "topic": topic,
      "email": email,
      "accessId": accessId,
      "template": template,
      "extraInfoSource": extraInfoSource,
      "language": language,
      "slideCount": slideCount,
      "aiImages": aiImages,
      "imageForEachSlide": imageForEachSlide,
      "googleImage": googleImage,
      "googleText": googleText,
      "model": model,
      "presentationFor": presentationFor,
      "watermark": watermark,
    };
  }
}
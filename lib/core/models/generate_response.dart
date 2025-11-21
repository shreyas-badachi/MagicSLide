class GenerateResponse {
  final bool success;
  final Map<String, dynamic>? data;
  final String? message;


  GenerateResponse({
    required this.success,
    this.data,
    this.message,
  });


  factory GenerateResponse.fromJson(Map<String, dynamic> json) {
    return GenerateResponse(
      success: json["success"] ?? false,
      data: json["data"] != null ? Map<String, dynamic>.from(json["data"]) : null,
      message: json["message"],
    );
  }
}
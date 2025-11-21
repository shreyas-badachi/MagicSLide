import 'package:dio/dio.dart';
import 'package:magicslide/core/models/generate_request.dart';
import 'package:magicslide/core/models/generate_response.dart';

import '../models/constants/constants.dart';

class MagicSlidesService {
  final Dio _dio = Dio();

  Future<GenerateResponse> generate(GenerateRequest request) async {
    try {
      final response = await _dio.post(
        AppConstants.magicSlidesEndpoint,
        data: request.toJson(),
      );

      return GenerateResponse.fromJson(response.data);
    } catch (_) {
      return GenerateResponse(success: false, message: 'API request failed');
    }
  }
}

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';


class DownloadService {
  final Dio _dio = Dio();


  Future<String?> downloadFile(String url, String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName';


      await _dio.download(url, filePath);
      return filePath;
    } catch (_) {
      return null;
    }
  }
}
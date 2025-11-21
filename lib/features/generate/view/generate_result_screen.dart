import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:dio/dio.dart';
import 'package:magicslide/core/services/download_service.dart';
import 'package:url_launcher/url_launcher.dart';

class GenerateResultScreen extends StatefulWidget {
  final String fileUrl;

  const GenerateResultScreen({super.key, required this.fileUrl});

  @override
  State<GenerateResultScreen> createState() => _GenerateResultScreenState();
}

class _GenerateResultScreenState extends State<GenerateResultScreen> {
  PdfControllerPinch? _pdfController;
  bool loadingPdf = false;
  bool downloading = false;

  @override
  void initState() {
    super.initState();
    if (widget.fileUrl.toLowerCase().endsWith('.pdf')) {
      loadPdfFromUrl();
    }
  }

  Future<void> loadPdfFromUrl() async {
    setState(() => loadingPdf = true);

    try {
      final response = await Dio().get(
        widget.fileUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      // pdfx expects a Future<PdfDocument> here, pass the Future directly
      _pdfController = PdfControllerPinch(
        document: PdfDocument.openData(response.data),
      );

      setState(() => loadingPdf = false);
    } catch (e) {
      setState(() => loadingPdf = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to load PDF: $e")));
      }
    }
  }

  Future<void> _download() async {
    setState(() => downloading = true);

    final extension = widget.fileUrl.split('.').last;
    final fileName =
        'magicslides_${DateTime.now().millisecondsSinceEpoch}.$extension';

    final path = await DownloadService().downloadFile(widget.fileUrl, fileName);

    setState(() => downloading = false);

    if (path != null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Downloaded to $path')));
      }
      try {
        if (Platform.isAndroid || Platform.isIOS) {
          await launchUrl(Uri.file(path));
        } else {
          // On desktop/web, try open via external browser
          await launchUrl(Uri.file(path));
        }
      } catch (_) {}
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Download failed')));
      }
    }
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPdf = widget.fileUrl.toLowerCase().endsWith('.pdf');

    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      body: Column(
        children: [
          Expanded(
            child: isPdf
                ? loadingPdf
                      ? const Center(child: CircularProgressIndicator())
                      : _pdfController == null
                      ? const Center(child: Text("Unable to load PDF"))
                      : PdfViewPinch(controller: _pdfController!)
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'PPT files cannot be previewed.\nUse Download to open the file.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: downloading ? null : _download,
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                    ),
                    child: downloading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Download'),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () async {
                    final uri = Uri.parse(widget.fileUrl);
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  child: const Text('Open Browser'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

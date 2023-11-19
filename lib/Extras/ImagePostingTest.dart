import 'dart:typed_data';
import 'dart:io';
import 'package:http/http.dart' as http;

class ImageDownloader {
  final String downloadLink;

  ImageDownloader({required this.downloadLink});

  Future<void> downloadAndDisplayImage() async {
    try {
      final response = await http.get(Uri.parse(downloadLink));

      if (response.statusCode == 200) {
        Uint8List bytes = response.bodyBytes;

        // Display the image (in a real app, you would use an Image widget)
        printImage(bytes);
      } else {
        print('Failed to fetch image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching image: $e');
    }
  }

  void printImage(Uint8List bytes) {
    // In a real app, you would display the image using an Image widget
    // For demonstration purposes, we'll print the bytes to the console
    String imageString = String.fromCharCodes(bytes);
    print(imageString);
  }
}
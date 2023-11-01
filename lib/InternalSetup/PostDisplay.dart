import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostDisplay extends StatelessWidget {
  final String caption;
  final XFile? selectedImage;
  final String address;

  PostDisplay({
    required this.caption,
    required this.selectedImage,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              caption,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          if (selectedImage != null)
            Image.file(
              File(selectedImage!.path),
              width: 400,
              height: 600,
            ),
          if (selectedImage == null)
            Text('No image selected'),
          Text(
            address,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

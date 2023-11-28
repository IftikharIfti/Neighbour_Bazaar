

import 'dart:io';

import 'package:image_picker/image_picker.dart';
class ImageFetcher {
 XFile? _selectedImage;
 final String _defaultImagePath = "img/default_pic.jpeg";
 ImageFetcher._private(){
  _selectedImage = XFile(_defaultImagePath);
 }

 static final ImageFetcher _instance = ImageFetcher._private();
 factory ImageFetcher() {
  return _instance;
 }

 XFile? get selectedImage => _selectedImage;
 void imagestore(XFile? pic) {
  _selectedImage=pic;
 }

}

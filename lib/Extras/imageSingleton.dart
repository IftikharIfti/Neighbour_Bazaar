import 'package:image_picker/image_picker.dart';

class ImageSingleton {
  static final ImageSingleton _instance = ImageSingleton._internal();

  factory ImageSingleton() {
    return _instance;
  }

  ImageSingleton._internal();

  XFile? _image;

  XFile? get image => _image;

  set imageGet(XFile? value) {
    _image = value;
  }
}

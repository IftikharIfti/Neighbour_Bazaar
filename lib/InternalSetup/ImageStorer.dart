import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class ImageStorer{
  final XFile? selectedImage;
  ImageStorer({required this.selectedImage});
  String imageURL="IF nothing is available";

  Future<String?> storeImage() async{
    try{
      if(selectedImage == null)
        {
          print('Sorry no image');
          return null;
        }
      print('Hello');
      String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      Reference storageReference=FirebaseStorage.instance.ref().child('Images/$timestamp.jpg');
      File imageFile=File(selectedImage!.path);
      UploadTask uploadTask=storageReference.putFile(imageFile);
      await uploadTask.whenComplete(() => print('Dooooneeeeeeeeeeeeeeeeeeee'));
      imageURL=await storageReference.getDownloadURL();
      print('Here is the $imageURL');
      return imageURL;
    }
    catch(e)
    {
      print('Error storig image:$e');
      return null;
    }
  }

}
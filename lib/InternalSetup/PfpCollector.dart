import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neighbour_bazaar/InternalSetup/imageFetcher.dart';
import 'package:neighbour_bazaar/InternalSetup/profilepicClass.dart';
import 'package:neighbour_bazaar/UserNameSingleton.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PfpCollector{
  static Future<void> printDummyDocumentIds() async{
    try{
      CollectionReference dummyCollection = FirebaseFirestore.instance.collection('UserProfilePic');
      QuerySnapshot querySnapshot = await dummyCollection.get();
      for (QueryDocumentSnapshot dummyDoc in querySnapshot.docs)
        {
          String username=dummyDoc.id;
             String imageurl = dummyDoc['image'];
             XFile? selectedImage = await fetchImage(imageurl);
             ProfilePicClass pfp=ProfilePicClass(img: selectedImage,username: username);
            ProfilePicClass.addNewPfp(pfp);
          if(username==usernameSingleton().username)
            ImageFetcher().imagestore(selectedImage);

        }

    }
    catch (e) {
      print('Error retrieving dummy documents: $e');
      // Handle errors if needed
    }
  }
  static Future<XFile?> fetchImage(String imageUrl) async {
    try {
      final response = await http.get(
        Uri.parse(imageUrl),
        headers: {'Cache-Control': 'no-cache'},
      );

      if (response.statusCode == 200) {
        Uint8List bytes = response.bodyBytes;
        if (bytes.isNotEmpty) {
          final tempDir = await getTemporaryDirectory();
          final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_${imageUrl.hashCode}.jpg';

          File tempFile = File('${tempDir.path}/$uniqueFileName');
          await tempFile.writeAsBytes(bytes);
          XFile imageFile = XFile(tempFile.path);
          return imageFile;
        } else {
          print('Fetched image has empty bytes.');
          return null;
        }
      } else {
        print('Failed to fetch image. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {

      print('Error fetching image: $e');
      return null;
    }
  }

}
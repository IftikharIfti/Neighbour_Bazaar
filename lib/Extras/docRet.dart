import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../InternalSetup/Post.dart';

class DummyDocumentPrinter {
  static Future<void> printDummyDocumentIds() async {
    try {
      CollectionReference dummyCollection = FirebaseFirestore.instance.collection('dummy');
      QuerySnapshot querySnapshot = await dummyCollection.get();
      for (QueryDocumentSnapshot dummyDoc in querySnapshot.docs) {
        String address=dummyDoc.id;
        print('Dummy Document ID: ${dummyDoc.id}');
        CollectionReference localUsersCollection = dummyDoc.reference.collection('LocalUsers');
        QuerySnapshot localUsersSnapshot = await localUsersCollection.get();
        for (QueryDocumentSnapshot localUserDoc in localUsersSnapshot.docs) {
          String userName=localUserDoc.id;
          print('LocalUser Document ID: ${localUserDoc.id}');
          CollectionReference allPostsCollection = localUserDoc.reference.collection('AllPosts');
          QuerySnapshot allPostsSnapshot = await allPostsCollection.get();
          for (QueryDocumentSnapshot allPostDoc in allPostsSnapshot.docs) {
            String description=allPostDoc.id;
            print('AllPosts Document ID: ${allPostDoc.id}');
            CollectionReference relatedPostCollection = allPostDoc.reference.collection('RelatedPost');
            QuerySnapshot relatedPostSnapshot = await relatedPostCollection.get();
            for (QueryDocumentSnapshot relatedPostDoc in relatedPostSnapshot.docs) {

              String imageUrl=relatedPostDoc['image'];
              String caption=relatedPostDoc['caption'];

              print('RelatedPost Document ID: ${relatedPostDoc.id}');
              print('Image: ${relatedPostDoc['image']}');
              print('Caption: ${relatedPostDoc['caption']}');

                        XFile? selectedImage = await fetchImage(imageUrl);
                        Post post = Post(
                          UserName: userName,
                          caption: caption,
                          selectedImage: selectedImage,
                          address: address,
                          description: description,
                        );

                        Post.addNewPost(post);

            }
          }
        }
      }
    } catch (e) {
      print('Error retrieving dummy documents: $e');
      // Handle errors if needed
    }
  }
  static Future<XFile?> fetchImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        Uint8List bytes = response.bodyBytes;

        XFile imageFile = XFile.fromData(bytes);

        return imageFile;
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
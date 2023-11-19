import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'Post.dart';

class postsFetcher{



  // static Future<void> fetchPosts() async
  // {
  //   print("Entered the fetchPosts");

 /**   // CollectionReference _collectionRef=
    //     FirebaseFirestore.instance.collection('dummy');
    // QuerySnapshot querySnapshot = await _collectionRef.get();
    // final allData=querySnapshot.docs.map((doc) => doc.data()).toList();
    // print(allData);**/

    // try{
    //   QuerySnapshot postsSnapshot= await FirebaseFirestore.instance.collection('dummy').get();
    //   print('Entered PostSnapShor');
    //   for (QueryDocumentSnapshot postDoc in postsSnapshot.docs) {
    //     String address = postDoc.id;
    //     print('Post Document ID:$address');
    //     CollectionReference usersCollection = postDoc.reference.collection('Users');
    //     QuerySnapshot usersSnapshot = await usersCollection.get();
    //
    //     for (QueryDocumentSnapshot userDoc in usersSnapshot.docs) {
    //       String userName = userDoc.id;
    //       print('User Document ID:$userName');
    //       CollectionReference allPostsCollection = userDoc.reference.collection('AllPosts');
    //       QuerySnapshot allPostsSnapshot = await allPostsCollection.get();
    //       for (QueryDocumentSnapshot allPostDoc in allPostsSnapshot.docs) {
    //         String description = allPostDoc.id;
    //         print('AllPosts Documen ID:$description');
    //         CollectionReference relatedPostsCollection = allPostDoc.reference.collection('RelatedPost');
    //         QuerySnapshot relatedPostsSnapshot = await relatedPostsCollection.get();
    //
    //         for (QueryDocumentSnapshot relatedPostDoc in relatedPostsSnapshot.docs) {
    //           String imageUrl = relatedPostDoc['image'];
    //           String caption = relatedPostDoc['caption'];
    //           XFile? selectedImage = await fetchImage(imageUrl);
    //           Post post = Post(
    //             UserName: userName,
    //             caption: caption,
    //             selectedImage: selectedImage,
    //             address: address,
    //             description: description,
    //           );
    //
    //           Post.addNewPost(post);
    //         }
    //       }
    //     }
    //   }
    // }
    // catch(e){
    //
    // }
 // }
 //  static Future<XFile?> fetchImage(String imageUrl) async {
 //    try {
 //      final response = await http.get(Uri.parse(imageUrl));
 //
 //      if (response.statusCode == 200) {
 //        Uint8List bytes = response.bodyBytes;
 //
 //        XFile imageFile = XFile.fromData(bytes);
 //
 //        return imageFile;
 //      } else {
 //        print('Failed to fetch image. Status code: ${response.statusCode}');
 //        return null;
 //      }
 //    } catch (e) {
 //
 //      print('Error fetching image: $e');
 //      return null;
 //    }
 //  }

}

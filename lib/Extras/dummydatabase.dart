import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class dummyDatabase{
  final String imageurl;
  final String userAddress;
  final String caption;
  final String username;
  final String category;
  dummyDatabase({
    required this.userAddress,
    required this.imageurl,
    required this.caption,
    required this.username,
    required this.category,
});
  Future<void> uploadPost() async {
    if (imageurl.isNotEmpty && userAddress.isNotEmpty && caption.isNotEmpty) {
      final userData = {
        'caption': caption,
        'image': imageurl
      };
      var userAddressDocRef = FirebaseFirestore.instance.collection('dummy').doc(userAddress);
      var userAddressDoc = await userAddressDocRef.get();
      if (!userAddressDoc.exists) {
        await userAddressDocRef.set(userData);
      }
      CollectionReference userreference ;
      userreference=userAddressDocRef.collection('LocalUsers');
      //userreference.add(userData);
      var locals=userreference.doc(username);
      var localsDoc=await locals.get();
      if(!localsDoc.exists)
      {
        await locals.set(userData);
      }
      CollectionReference Allposts;
      Allposts=userreference.doc(username).collection('AllPosts');
      var alls=Allposts.doc(category);
      var allDoc=await alls.get();
      if(!allDoc.exists)
        {
          await alls.set(userData);
        }

      CollectionReference relatedPost;
      relatedPost=Allposts.doc(category).collection('RelatedPost');
      relatedPost.add(userData);
      // final FirebaseFirestore firestore = FirebaseFirestore.instance;
      // try {
      //   await firestore.collection('dummy').doc(userAddress)
      //       .set(userData)
      //       .whenComplete(() =>
      //       print("Done for dummmmyyyyyyyyy")
      //   );
      //
      //
      //   // Data is saved to Firestore
      // } catch (e) {
      //   print('Error saving user data: $e');
      // }
    }
  }
}

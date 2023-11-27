import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class dummyDatabase{
  final String imageurl;
  final String userAddress;
  final String caption;
  final String username;
  final String category;
  final String value;
  dummyDatabase({
    required this.userAddress,
    required this.imageurl,
    required this.caption,
    required this.username,
    required this.category,
    required this.value
});
  Future<void> uploadPost() async {
    if (imageurl.isNotEmpty && userAddress.isNotEmpty && caption.isNotEmpty) {
      final userData = {
        'caption': caption,
        'image': imageurl,
        'value':value
      };
      final nullData=
          {
            'null':null
          };
      var userAddressDocRef = FirebaseFirestore.instance.collection('dummy').doc(userAddress);
      var userAddressDoc = await userAddressDocRef.get();
      if (!userAddressDoc.exists) {
        await userAddressDocRef.set(nullData);
      }
      CollectionReference userreference ;
      userreference=userAddressDocRef.collection('LocalUsers');
      var locals=userreference.doc(username);
      var localsDoc=await locals.get();
      if(!localsDoc.exists)
      {
        await locals.set(nullData);
      }
      CollectionReference Allposts;
      Allposts=userreference.doc(username).collection('AllPosts');
      var alls=Allposts.doc(category);
      var allDoc=await alls.get();
      if(!allDoc.exists)
        {
          await alls.set(nullData);
        }

      CollectionReference relatedPost;
      relatedPost=Allposts.doc(category).collection('RelatedPost');
      relatedPost.add(userData);

    }
  }
}

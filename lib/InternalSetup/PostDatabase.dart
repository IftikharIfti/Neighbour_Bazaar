import 'package:cloud_firestore/cloud_firestore.dart';

class PostDatabase {
  final String userName;
  final String userAddress;
  final String image;
  final String caption;
  final String product;

  PostDatabase({
    required this.userName,
    required this.userAddress,
    required this.image,
    required this.caption,
    required this.product,
  });

  Future<void> uploadPost() async {
    var userAddressDocRef = FirebaseFirestore.instance.collection('Posts').doc(userAddress);
    var userAddressDoc = await userAddressDocRef.get();

    if (!userAddressDoc.exists) {
      await userAddressDocRef.set({});
    }
    var userCollectionRef = userAddressDocRef.collection('Users');
    var userDocRef = userCollectionRef.doc(userName);
    var userDoc = await userDocRef.get();

    if (!userDoc.exists) {
      await userDocRef.set({});

      await userDocRef.collection('AllPosts').doc(product).set({
        'RelatedPost': {},
      });
    } else {
      var productDocRef = userDocRef.collection('AllPosts').doc(product);
      var productDoc = await productDocRef.get();

      if (!productDoc.exists) {
        await productDocRef.set({
          'RelatedPost': {},
        });
      }
    }
    var relatedPostRef = userDocRef.collection('AllPosts').doc(product).collection('RelatedPost');
    await relatedPostRef.add({
      'Image': image,
      'Caption': caption,
    });

    print('Post uploaded successfully');
  }
}

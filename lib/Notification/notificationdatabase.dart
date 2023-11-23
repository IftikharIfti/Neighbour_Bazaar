import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class notificationDatabase{
  final String username;
  final String datetime;
  final String category;
  final String address;
  notificationDatabase({
    required this.username,
    required this.address,
    required this.category,
    required this.datetime,

  });
  Future<void> uploadPost() async {
    if (username.isNotEmpty && datetime.isNotEmpty && category.isNotEmpty) {
      final userData = {
        'user': username,
        'date': datetime,
        'address': address,
        'category':category
      };
      final userbool = {
        'done':'no'
      };
      CollectionReference notifuser=FirebaseFirestore.instance.collection('notificationuser');
      QuerySnapshot querySnapshot=await notifuser.get();
      for(QueryDocumentSnapshot user in querySnapshot.docs) {
        String users=user.id;
        var userAddressDocRef = FirebaseFirestore.instance.collection(
            'notification').doc(datetime);
        var userAddressDoc = await userAddressDocRef.get();
        if (!userAddressDoc.exists) {
          await userAddressDocRef.set(userData);
        }
        CollectionReference userreference;
        userreference = userAddressDocRef.collection('users');
        var locals = userreference.doc(users);
        var localsDoc = await locals.get();
        if (!localsDoc.exists) {
          await locals.set(userbool);
        }
      }
    }
  }
}

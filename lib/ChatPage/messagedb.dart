import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class messageDatabase{
  final String user;
  final String friend;
  final String message;
  final DateTime datetime;
  final String   state;
  messageDatabase({
    required this.user,
    required this.friend,
    required this.message,
    required this.datetime,
    required this.state,
  });
  Future<void> uploadPost() async {
    print(user);
    print(friend);
    print(message);
    print(datetime);
    print(state);
    if (user.isNotEmpty && friend.isNotEmpty && message.isNotEmpty) {
       String timeinput = DateFormat.Hm().format(datetime);
      final userData = {
        'message': message,
        'state': state,
        'datetime': timeinput,
      };
      var userAddressDocRef = FirebaseFirestore.instance.collection('Message').doc(user);
      var userAddressDoc = await userAddressDocRef.get();
      if (!userAddressDoc.exists) {
        await userAddressDocRef.set({});
      }
      CollectionReference userreference ;
      userreference=userAddressDocRef.collection('chatlist');
      //userreference.add(userData);
      var locals=userreference.doc(friend);
      var localsDoc=await locals.get();
      if(!localsDoc.exists)
      {
        await locals.set({});
      }
      CollectionReference Allposts;
      Allposts=userreference.doc(friend).collection('messages');
      String DT=datetime.toString();
      var alls=Allposts.doc(DT+'_'+state);
      var allDoc=await alls.get();
      if(!allDoc.exists)
      {
        await alls.set(userData);
      }
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neighbour_bazaar/User-Model.dart';

class UserRepository extends GetxController{
  static UserRepository get instance=>Get.find();

  final db=FirebaseFirestore.instance;

  createUser(UserModel user)
  async {
   await db.collection("User").add(user.toJson()).whenComplete(
            () => Get.snackbar("Success", "Your Account has been created",snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue.withOpacity(0.8),colorText: Colors.white),
    )
   .catchError((error,stackTrace){
     Get.snackbar("Error", "Something went wrong",snackPosition: SnackPosition.BOTTOM,
         backgroundColor: Colors.red.withOpacity(.8),colorText: Colors.white);
   }
   );


  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neighbour_bazaar/Extras/PostTest.dart';
import 'package:neighbour_bazaar/Extras/docRet.dart';
import 'package:neighbour_bazaar/User-Model.dart';
import 'package:neighbour_bazaar/UserNameSingleton.dart';
import 'package:neighbour_bazaar/dashboard.dart';
import 'package:neighbour_bazaar/login_failure.dart';
import 'package:neighbour_bazaar/login_page.dart';
import 'package:neighbour_bazaar/signup_email_password_failure.dart';
import 'package:neighbour_bazaar/Extras/user_location.dart';
import 'package:neighbour_bazaar/user_repository.dart';
import 'package:neighbour_bazaar/welcome_page.dart';

import 'EmailSingleton.dart';
import 'OverLay.dart';
import 'about_user.dart';

class AuthController extends GetxController {
  // to make the authcontroller globally accessibl anywhere
  /*
  AuthController will handle singup and login page and redirect to
  other pages
  * */
  static AuthController get instance => Get.find();
  //to initialize firebase user model
   // it will handle email,password,usrname..
  final auth=FirebaseAuth.instance;
  late final Rx<User?> _user;
  final userRepo=Get.put(UserRepository());
  @override
  void onReady()
  {
    // we can do some initialization which comes from
    _user =Rx<User?>(auth.currentUser);// we are casting it to Rx user
    _user.bindStream(auth.userChanges());// we bind our user with stream, user will be notified
    ever(_user,_initialScreen);
  }
  _initialScreen(User? user)
  {
    // if(user==null)
    //   {
        print("login page");
        Get.offAll(()=>LoginPage());
   //   }
    // else
    //   {
    //     Get.offAll(()=>WelcomePage());
    //   }

  }
  Future<void> register(String username,String email,String password)// this is a helper function which will called from signup view

  async{
  try {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    if(_user.value!=null) {
    //  Get.offAll(() =>  Dashboard());
      EmailSingleton().email = email;
      Get.off(() => AboutUser(username, email, password));
      final user=UserModel(username: username, email: email, password: password);
    //  UserRepository.instance.createUser(user);
    }
    else
      Get.to(()=>LoginPage());
  }on FirebaseAuthException catch(e) {
    final ex=SignUpWithEmailAndPasswordFailure.code(e.code);
    print('FIREBASE AUTH EXCEPTION-${ex.message}');
        Get.snackbar("Error! ", '${ex.message}',snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue.withOpacity(0.8),colorText: Colors.white);
    throw ex;
  } catch(_){
    final ex=SignUpWithEmailAndPasswordFailure();
    print('FIREBASE AUTH EXCEPTION-${ex.message}');
    throw ex;
  }
  }
  Future<void> logout() async=> await auth.signOut();
  void createUser(UserModel user)
  {
   userRepo.createUser(user);
  }

  Future<bool> login(String email,String password)
  async{
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      if(_user.value!=null)
        {

          EmailSingleton().email = email;
          final docSnapshot=
          await FirebaseFirestore.instance.collection('User').doc(email).get();
          if(docSnapshot.exists)
            {
              final userData=docSnapshot.data() as Map<String,dynamic>;
              usernameSingleton().username=userData['UserName'] ?? '';
            }
          await DummyDocumentPrinter.printDummyDocumentIds();

          //usernameSingleton().username=;
          //Get.offAll(()=>Dashboard());

          return true;
        }
      else {
        print('No User');
        return false;
      }
    }on FirebaseAuthException catch(e) {

      final ex=LogInFailure.code(e.code);
      Get.snackbar("", '${ex.message}',snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.withOpacity(0.8),colorText: Colors.white);
      print('FIREBASE AUTH EXCEPTION-${ex.message}');

      return false;
    } catch(_){

      final ex=LogInFailure();
      print('sth is wroooooonnnggggg');
      print('FIREBASE AUTH EXCEPTION-${ex.message}');
      return false;
    }
  }

  }



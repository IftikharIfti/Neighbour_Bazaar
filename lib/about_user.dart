
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neighbour_bazaar/EmailSingleton.dart';
import 'package:neighbour_bazaar/InternalSetup/ImageStorerForPfp.dart';
import 'package:neighbour_bazaar/InternalSetup/imageFetcher.dart';
import 'package:neighbour_bazaar/UserNameSingleton.dart';
import 'package:neighbour_bazaar/passwordSingleton.dart';

import 'InternalSetup/UploadImageForAboutUser.dart';
import 'dashboard.dart';

class AboutUser extends StatefulWidget {
   String username=usernameSingleton().username;
   String email=EmailSingleton().email;
   String password=passwordSingleton().password;
 //  XFile? profilePic=ImageFetcher().selectedImage;
 // AboutUser(this.username, this.email, this.password);

  @override
  _AboutUserState createState() => _AboutUserState();
}

class _AboutUserState extends State<AboutUser> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  bool isSubmitButtonEnabled = false;
  Future<void> _saveUserInfo() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get the values from the text controllers
    final String location = locationController.text;
    final String occupation = occupationController.text;
    final String contactNumber = contactNumberController.text;

    // Check if location, occupation, and contactNumber are filled
    if (location.isNotEmpty && occupation.isNotEmpty && contactNumber.isNotEmpty) {
      // Define the data you want to save in Firestore
      final userData = {
        'UserName': widget.username,
        'Email': widget.email,
        'Password': widget.password,
        'Location': location,
        'Occupation': occupation,
        'ContactNumber': contactNumber,
      };
      final uservalue = {
        'collected':0,
        'seen':0
      };

      // ImageStorerPfp imagestorepfp=ImageStorerPfp(selectedImage:ImageFetcher().selectedImage);
      // // imagestore.storeImage();
      // String? imageurl=await imagestorepfp.storeImage() ;
      // final imageURL= {
      //   'image':imageurl
      // };
      // Save the user data in Firestore
      try {
        await firestore.collection('User').doc(widget.username).set(userData).whenComplete(() =>  Get.snackbar("Success", "Your Account has been created",snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue.withOpacity(0.8),colorText: Colors.white),
        );
        await firestore.collection('User').doc(widget.email).set(userData).whenComplete(() =>  print('Done'),
        );
        // await firestore.collection('UserProfilePic').doc(widget.username).set(imageURL).whenComplete(() =>  print('Done'),
        // );
        DocumentReference documentReference = FirebaseFirestore.instance.collection('notificationuser').doc(widget.username);

        await documentReference.set(uservalue);
      } catch (e) {

        // Handle any errors that occur during the process
        Get.snackbar("Error", "Something went wrong",snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(.8),colorText: Colors.white);

        print('Error saving user data: $e');
      }
      // Navigate to the dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About User'),
      ),
      body: Column(
        children: [
          // GestureDetector(
          //   onTap: () {
          //     _changeProfilePic();
          //   },
          //   child: Container(
          //     child: Image.file(
          //       File(widget.profilePic?.path ?? ImageFetcher().selectedImage?.path ?? 'packges/neigbour_bazaar/img/default_pic.jpeg'),
          //       width: 80,
          //       height: 80,
          //       fit: BoxFit.cover,
          //     )
          //   ),
          // ),
          TextField(
            controller: locationController,
            decoration: InputDecoration(labelText: 'Location'),
          ),
          TextField(
            controller: occupationController,
            decoration: InputDecoration(labelText: 'Occupation'),
          ),
          TextField(
            controller: contactNumberController,
            decoration: InputDecoration(labelText: 'Contact Number'),
          ),
          ElevatedButton(
            onPressed: isSubmitButtonEnabled ? _saveUserInfo : null,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
  // void _changeProfilePic() async {
  //   XFile? newProfilePic = await Get.to(() => UploadImage());
  //   if (newProfilePic != null) {
  //     setState(() {
  //       widget.profilePic = newProfilePic;
  //     });
  //   }
  // }
  @override
  void initState() {
    super.initState();
    // Listen for changes in the text fields
    locationController.addListener(_updateSubmitButton);
    occupationController.addListener(_updateSubmitButton);
    contactNumberController.addListener(_updateSubmitButton);
  }

  void _updateSubmitButton() {
    // Enable the submit button when all required fields are filled
    setState(() {
      isSubmitButtonEnabled =
          locationController.text.isNotEmpty &&
              occupationController.text.isNotEmpty &&
              contactNumberController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    // Clean up the controllers
    locationController.dispose();
    occupationController.dispose();
    contactNumberController.dispose();
    super.dispose();
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neighbour_bazaar/EmailSingleton.dart';
import 'package:neighbour_bazaar/InternalSetup/imageFetcher.dart';
import 'InternalSetup/UploadImageForAboutUser.dart';
import 'dashboard.dart';

class EditProfile extends StatefulWidget {
  // fetch the email here
  XFile? selectedImage=ImageFetcher().selectedImage; // Assuming you're using XFile from image_picker
 // EditProfile({required this.selectedImage});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  String email=EmailSingleton().email;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    // Fetch user data from Firestore based on the provided email
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {

      final docSnapshot =
      await FirebaseFirestore.instance.collection('User').doc(email).get();// use the email here
      if (docSnapshot.exists) {
        final userData = docSnapshot.data() as Map<String, dynamic>;
        userNameController.text = userData['UserName'] ?? '';
        locationController.text = userData['Location'] ?? '';
        contactController.text = userData['ContactNumber'] ?? '';
        occupationController.text = userData['Occupation'] ?? '';
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> updateUserData() async {
    try {
      await FirebaseFirestore.instance.collection('User').doc(email).set({
        'UserName': userNameController.text,
        'Location': locationController.text,
        'ContactNumber': contactController.text,
        'Occupation': occupationController.text,
      }, SetOptions(merge: true));

      // Redirect to the dashboard
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      Get.offAll(Dashboard());
      return false;// Replace Dashboard() with your actual Dashboard class
      // Return false to prevent default behavior
    },
    child:  Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              ClipOval(
                child: Container(
                  width: 180.0,
                  height: 180.0,
                  child: GestureDetector(
                    onTap: () {
                      _changeProfilePic();
                    },
                    child: widget.selectedImage != null
                        ? Image.file(
                      File(widget.selectedImage!.path),
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    )
                        : Center(
                      child: Text(
                        'Tap here to select an image',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: userNameController,
                enabled: isEditing,
                decoration: InputDecoration(labelText: 'UserName'),
              ),
              TextFormField(
                controller: locationController,
                enabled: isEditing,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              TextFormField(
                controller: contactController,
                enabled: isEditing,
                decoration: InputDecoration(labelText: 'Contact'),
              ),
              TextFormField(
                controller: occupationController,
                enabled: isEditing,
                decoration: InputDecoration(labelText: 'Occupation'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Toggle the editing mode
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                child: Text(isEditing ? 'Cancel' : 'Edit Info'),
              ),
              ElevatedButton(
                onPressed: isEditing ? updateUserData : null,
                child: Text('Save and Exit'),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
  void _changeProfilePic() async {
    XFile? newProfilePic = await Get.to(() => UploadImage());
    if (newProfilePic != null) {
      setState(() {
        widget.selectedImage = newProfilePic;
      });
    }
  }
}

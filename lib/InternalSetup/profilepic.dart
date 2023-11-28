//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neighbour_bazaar/InternalSetup//dummydatabase.dart';
import 'package:neighbour_bazaar/InternalSetup/ImageStorer.dart';
import 'package:neighbour_bazaar/Notification/notificationdatabase.dart';
import 'package:neighbour_bazaar/UserLocation/addressReturner.dart';
import 'package:neighbour_bazaar/dashboard.dart';

import '../UserLocation/GetUserLoactionforUploadPost.dart';
import 'Post.dart';
import 'package:neighbour_bazaar/UserNameSingleton.dart';

import 'UploadImageForAboutUser.dart';

class ProfilePic extends StatefulWidget
{
   XFile? selectedImage; // Assuming you're using XFile from image_picker
  ProfilePic({required this.selectedImage});
  @override
  _ProfilePicState createState()=>_ProfilePicState();
}


class _ProfilePicState extends State<ProfilePic> {

  final TextEditingController captionController = TextEditingController();
  final TextEditingController valueController =TextEditingController();
  final TextEditingController nameController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    String address = AddressReturner().getAddress();
    return WillPopScope(
      onWillPop: () async {
        Get.to(() => Dashboard()); // Replace Dashboard() with your actual Dashboard class
        return false; // Return false to prevent default behavior
      },
      child:Scaffold(
        appBar: AppBar(
          title: Text('Upload Post'),
        ),
        body: SingleChildScrollView(
          // Wrap your content in a SingleChildScrollView
          child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Display the selected image
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

                ],
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: true,
      ),// Set this to true
    );
  }
  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: () {
        _changeProfilePic();
      },
      child: Container(
        width: 80.0,
        height: 80.0,
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

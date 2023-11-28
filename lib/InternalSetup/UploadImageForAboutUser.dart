import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neighbour_bazaar/EditProfile.dart';
import 'package:neighbour_bazaar/InternalSetup/imageFetcher.dart';
import 'package:neighbour_bazaar/InternalSetup/profilepic.dart';
import 'package:neighbour_bazaar/about_user.dart';

import '../dashboard.dart';
import 'UploadPost.dart';

class UploadImage extends StatelessWidget {
  final selectedImage = Rx<XFile?>(null);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(EditProfile()); // Replace Dashboard() with your actual Dashboard class
        return false; // Return false to prevent default behavior
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upload Page'),
        ),
        body: Stack(
          children: [
            // 1. Background for the upload page
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('img/refImage.png'), // Set your background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 2. Button to upload image
                  ElevatedButton(
                    onPressed: () {
                      // Show modal sheet with options
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.photo),
                                title: Text('Image from Gallery'),
                                onTap: () async {
                                  final picker = ImagePicker();
                                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                  selectedImage.value=pickedFile;
                                  if (pickedFile != null) {
                                    ImageFetcher().imagestore(pickedFile);

                                    Get.offAll(()=> EditProfile());
                                  } else {
                                    print("CANCELLED");
                                    // The user canceled the image selection.
                                  }
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.camera),
                                title: Text('Take photo from camera'),
                                onTap: () async {
                                  final picker = ImagePicker();
                                  final pickedFile = await picker.pickImage(source: ImageSource.camera);
                                  selectedImage.value=pickedFile;
                                  if (pickedFile != null) {
                                    ImageFetcher().imagestore(pickedFile);
                                  } else {
                                    print("CANCELLED");
                                    // The user canceled taking a photo.
                                  }
                                },
                              ),
                              ListTile(
                                title: Text('Cancel'),
                                onTap: () {
                                  // Close the modal sheet
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Upload Image'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

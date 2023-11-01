//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neighbour_bazaar/Extras/PostTest.dart';
import 'package:neighbour_bazaar/UserLocation/GetUserLocation.dart';
import 'package:neighbour_bazaar/UserLocation/addressReturner.dart';
import 'package:neighbour_bazaar/home_screen.dart';

import '../UserLocation/GetUserLoactionforUploadPost.dart';
import 'Post.dart'; // Import image_picker package

class UploadPost extends StatelessWidget {
  final XFile? selectedImage; // Assuming you're using XFile from image_picker

  UploadPost({required this.selectedImage});
  final TextEditingController captionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String address = AddressReturner().getAddress();
    return Scaffold(
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
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: captionController,
                    decoration: InputDecoration(
                      hintText: 'Add a caption to the post',
                    ),
                  ),
                ),
                // Display the selected image
                if (selectedImage != null)
                  Image.file(
                    File(selectedImage!.path),
                    width: 400,
                    height: 600,
                  ),
                if (selectedImage == null)
                  Text('No image selected'),
                Text(
                  address,// Get the address from ShowUserLocation
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => ShowUserLocation2(selectedImage: selectedImage));
                  },
                  child: Text('Get Location'),
                ),
                ElevatedButton(
                  onPressed: () {
                    String caption = captionController.text;
                    Post newPost = Post(
                      caption: caption,
                      selectedImage: selectedImage,
                      address: address,
                    );

                    // Add the new post to the list
                    Post.allPosts.add(newPost);
                     Get.offAll(PostViewTest());
                  },
                  child: Text('Create Post'), // Add a button for creating a post
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true, // Set this to true
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neighbour_bazaar/InternalSetup/Post.dart';
import 'package:neighbour_bazaar/InternalSetup/upload.dart';

import '../UserLocation/AddressSingleton.dart';
import '../dashboard.dart';
class Mobile extends StatelessWidget {
  final reversedPosts = List.of(Post.allPosts.reversed);
  @override
  Widget build(BuildContext context) {
    String nowaddress=addressSingleton().address;
    final mobilePosts = reversedPosts
        .where((post) => post.description == 'Mobile'&& post.address==nowaddress)
        .toList();
    return WillPopScope(
        onWillPop: () async {
      // Handle the back button press
      // Navigate back to the Dashboard class
      Get.to(() => Dashboard()); // Replace Dashboard() with your actual Dashboard class
      return false; // Return false to prevent default behavior
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text('Mobiles'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.offAll(() => UploadPage()); // Redirect to UploadPage using GetX
            },
            child: Text('Sell'), // Button text
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: mobilePosts.length,
        itemBuilder: (context, index) {
          final post = mobilePosts[index];
          return Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child:Text(
                    post.UserName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize:22.0,
                    ),
                  )
              ),
              Align(
                alignment: Alignment.centerLeft,
                child:Text(
                  post.address,
                  style: TextStyle(
                    color: Colors.grey, // Light grey color for address
                    fontSize: 14.0,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child:Text(
                  post.caption,
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
              if(post.selectedImage != null)
                Image.file(
                  File(post.selectedImage!.path),
                  width: 400,
                  height: 600,
                ),

              if (post.selectedImage == null)
                Text('No image selected'),
              ElevatedButton(onPressed: (){

              }, child: Text('Buy')),
            ],
          );

        },
      ),
    ),
    );
  }
}

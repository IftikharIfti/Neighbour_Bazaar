import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neighbour_bazaar/InternalSetup/Post.dart';
import 'package:neighbour_bazaar/InternalSetup/upload.dart';
import 'package:neighbour_bazaar/UserLocation/GetUserLocation.dart';

import 'InternalSetup/PostDisplay.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Home Screen Content'),
            ElevatedButton(onPressed: (){Get.offAll(UploadPage());}, child: Text("Post"),),
            Text("Number of posts: ${Post.allPosts.length}"),
            Expanded(
              child: ListView.builder(
                itemCount: Post.allPosts.length, // Assuming you have a list of posts in your Post class
                itemBuilder: (context, index) {
                  return PostDisplay(
                    caption: Post.allPosts[index].caption,
                    selectedImage: Post.allPosts[index].selectedImage,
                    address: Post.allPosts[index].address,
                  );
                },
              ),
            ),

        ],
        ),
      ),
    );
  }
}

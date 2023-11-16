import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neighbour_bazaar/InternalSetup/Post.dart';
import 'package:neighbour_bazaar/InternalSetup/upload.dart';
import 'package:neighbour_bazaar/UserLocation/GetUserLocation.dart';
import 'InternalSetup/PostDisplay.dart';
class HomeScreen extends StatelessWidget {
  final reversedPosts = List.of(Post.allPosts.reversed);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Posts'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.offAll(() => UploadPage()); // Redirect to UploadPage using GetX
            },
            child: Text('Post'), // Button text
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: Post.allPosts.length,
        itemBuilder: (context, index) {
          final post = reversedPosts[index];

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
              if (post.selectedImage != null)
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
    );
  }
}

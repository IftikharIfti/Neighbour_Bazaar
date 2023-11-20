import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neighbour_bazaar/InternalSetup/Post.dart';
import 'package:neighbour_bazaar/InternalSetup/upload.dart';

import '../UserLocation/AddressSingleton.dart';
import '../dashboard.dart';
class children_toys extends StatelessWidget {
  final reversedPosts = List.of(Post.allPosts.reversed);
  @override
  Widget build(BuildContext context) {
    String nowaddress=addressSingleton().address;
    final children_toysPosts = reversedPosts
        .where((post) => post.description ==  'Children\'s clothes and toys' && post.address==nowaddress)
        .toList();
    return WillPopScope(
        onWillPop: () async {
      Get.to(() => Dashboard()); // Replace Dashboard() with your actual Dashboard class
      return false; // Return false to prevent default behavior
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text('Children\'s Toys and Clothes Section'),
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
        itemCount: children_toysPosts.length,
        itemBuilder: (context, index) {
          final post = children_toysPosts[index];
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

import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neighbour_bazaar/InternalSetup/Post.dart';
import 'package:neighbour_bazaar/InternalSetup/upload.dart';

import '../Cart/cartCounter.dart';
import '../Cart/cartclass.dart';
import '../UserLocation/AddressSingleton.dart';
import '../dashboard.dart';
class furniture extends StatelessWidget {
  final reversedPosts = List.of(Post.allPosts.reversed);
  CartCounter cartCounter=CartCounter();
  @override
  Widget build(BuildContext context) {
    String nowaddress=addressSingleton().address;
    final furniturePosts = reversedPosts
        .where((post) => post.description == 'Furniture' && post.address==nowaddress)
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
        title: Text('furniture'),
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
        itemCount: furniturePosts.length,
        itemBuilder: (context, index) {
          final post = furniturePosts[index];
          String value=post.value;
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
                _showConfirmationDialog(context, post);

              }, child: Text('$value Buy')),
            ],
          );

        },
      ),
    ),
    );
  }
  void _showConfirmationDialog(BuildContext context, Post post) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: AlertDialog(
              title: Text(
                post.description,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Value: ${post.value}'),
                  // Add other details as needed

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cartCounter.increment();
                          String numericString = post.value.replaceAll(RegExp(r'[^0-9]'), ''); // Remove non-numeric characters

                          CartClass CC=CartClass(price: int.parse(numericString), type: post.description);
                          CartClass.addNewCart(CC);
                          // Call your method here
                          // Example: _confirmPurchase(post);
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}

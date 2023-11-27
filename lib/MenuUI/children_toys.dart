import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neighbour_bazaar/Cart/cartCounter.dart';
import 'package:neighbour_bazaar/Cart/cartclass.dart';
import 'package:neighbour_bazaar/InternalSetup/Post.dart';
import 'package:neighbour_bazaar/InternalSetup/upload.dart';
import '../UserLocation/AddressSingleton.dart';
import '../dashboard.dart';
class children_toys extends StatelessWidget {
  final reversedPosts = List.of(Post.allPosts.reversed);
  CartCounter cartCounter=CartCounter();
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

            child: Text('Sell'),
            // Button text
          ),

        ],
      ),

      body: ListView.builder(
        itemCount: children_toysPosts.length,
        itemBuilder: (context, index) {
          final post = children_toysPosts[index];
          String value=post.value;
          return GestureDetector(
            onTap: () {
              Get.to(() => ProductDetailsPage(post: post));
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  if (post.selectedImage != null)
                    Image.file(
                      File(post.selectedImage!.path),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.name,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        Text(
                          'Product Price: ${post.value} BDT',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );

        },
      ),
    ),
    );
  }
}
class ProductDetailsPage extends StatelessWidget{
  final Post post;
  CartCounter cartCounter = CartCounter();

  ProductDetailsPage({required this.post});

  @override
  Widget build(BuildContext context) {
    String nowAddress = addressSingleton().address;

    return WillPopScope(
      onWillPop: () async {
        Get.to(() => Dashboard());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(post.name),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.offAll(() => UploadPage());
              },
              child: Text('Sell'),
            ),
          ],
        ),
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                post.UserName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                post.address,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
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
            if (post.selectedImage == null) Text('No image selected'),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context, post);
              },
              child: Text('${post.value} Buy'),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, Post post) {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cartCounter.increment();
                          String numericString =
                          post.value.replaceAll(RegExp(r'[^0-9]'), '');

                          CartClass CC = CartClass(
                            price: int.parse(numericString),
                            type: post.description,
                          );
                          CartClass.addNewCart(CC);
                          Navigator.of(context).pop();
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

// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:neighbour_bazaar/InternalSetup/Post.dart';
// //
// // import '../InternalSetup/upload.dart';
// //
// // class PostViewTest extends StatelessWidget {
// //   final reversedPosts = List.of(Post.allPosts.reversed);
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('All Posts'),
// //         actions: [
// //           ElevatedButton(
// //             onPressed: () {
// //               Get.offAll(() => UploadPage()); // Redirect to UploadPage using GetX
// //             },
// //             child: Text('Post'), // Button text
// //           ),
// //         ],
// //       ),
// //       body: ListView.builder(
// //         itemCount: Post.allPosts.length,
// //         itemBuilder: (context, index) {
// //           final post = reversedPosts[index];
// //
// //           return Column(
// //             children: [
// //               Align(
// //                 alignment: Alignment.centerLeft,
// //               child:Text(
// //                   post.address,
// //                   style: TextStyle(
// //                     color: Colors.grey, // Light grey color for address
// //                     fontSize: 14.0,
// //                   ),
// //                 ),
// //               ),
// //              Align(
// //                alignment: Alignment.centerLeft,
// //              child:Text(
// //                   post.caption,
// //                   style: TextStyle(
// //                     fontSize: 17.0,
// //                   ),
// //                 ),
// //              ),
// //               if (post.selectedImage != null)
// //                 Image.file(
// //                   File(post.selectedImage!.path),
// //                   width: 400,
// //                   height: 600,
// //                 ),
// //               if (post.selectedImage == null)
// //                 Text('No image selected'),
// //
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:neighbour_bazaar/InternalSetup/imageFetcher.dart';

import '../InternalSetup/Post.dart';
import 'docRet.dart';

 class PostTest extends StatefulWidget {
  @override
  _PostTestState createState() => _PostTestState();
}


class _PostTestState extends State<PostTest> {
  @override
  void initState() {
    super.initState();
    fetchData(); // Call your async function here
  }

  Future<void> fetchData() async {
    await DummyDocumentPrinter.printDummyDocumentIds();
  }


  @override
  Widget build(BuildContext context) {
    print("You are in the PostTest");


    return Scaffold(
      appBar: AppBar(
        title: Text('Post Display'),
      ),
      body: ListView.builder(
        itemCount: Post.allPosts.length,
        itemBuilder: (context, index) {
          Post post = Post.allPosts[index];

          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('User: ${post.UserName}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Address: ${post.address}'),
                  Text('Description: ${post.description}'),
                  Text('Caption: ${post.caption}'),
                ],
              ),
              leading: post.selectedImage != null
                  ? Image.file(File(post.selectedImage!.path))
                  : Placeholder(), // Placeholder for no image
            ),
          );
        },
      ),
    );
  }
}

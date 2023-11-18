//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neighbour_bazaar/Extras/PostTest.dart';
import 'package:neighbour_bazaar/InternalSetup//dummydatabase.dart';
import 'package:neighbour_bazaar/InternalSetup/ImageStorer.dart';
import 'package:neighbour_bazaar/InternalSetup/PostDatabase.dart';
import 'package:neighbour_bazaar/UserLocation/GetUserLocation.dart';
import 'package:neighbour_bazaar/UserLocation/addressReturner.dart';
import 'package:neighbour_bazaar/dashboard.dart';
import 'package:neighbour_bazaar/home_screen.dart';

import '../UserLocation/GetUserLoactionforUploadPost.dart';
import 'Post.dart'; // Import image_picker package
import 'package:neighbour_bazaar/UserNameSingleton.dart';

class UploadPost extends StatefulWidget
{
  final XFile? selectedImage; // Assuming you're using XFile from image_picker
  UploadPost({required this.selectedImage});
  @override
  _UploadPostState createState()=>_UploadPostState();
}


class _UploadPostState extends State<UploadPost> {
  String dropdownvalue='Mobile';
  String description = '';
  var items =  ['Mobile',
    'Electronics',
    'Vehicles',
    'Furniture',
    'Men\'s clothes',
    'Women\'s clothes',
    'Children\'s clothes and toys',
    'Essential',
  ];


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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      elevation: 0,
                      value: dropdownvalue,

                      icon: Icon(Icons.keyboard_arrow_down),

                      items:items.map((String items) {
                        return DropdownMenuItem(
                            value: items,
                            child: Text(items)
                        );
                      }
                      ).toList(),

                      onChanged: (String? newValue){
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },

                    ),
                  ),
                ),

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
                if (widget.selectedImage != null)
                  Image.file(
                    File(widget.selectedImage!.path),
                    width: 400,
                    height: 600,
                  ),
                if (widget.selectedImage == null)
                  Text('No image selected'),
                Text(
                  address,// Get the address from ShowUserLocation
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => ShowUserLocation2(selectedImage: widget.selectedImage));
                  },
                  child: Text('Get Location'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    description=dropdownvalue;
                    String caption = captionController.text;
                    ImageStorer imagestore=ImageStorer(selectedImage:widget.selectedImage);
                   // imagestore.storeImage();
                    String? imageurl=await imagestore.storeImage() ;
                    Post newPost = Post(
                      UserName: usernameSingleton().username,
                      caption: caption,
                      selectedImage: widget.selectedImage,
                      address: address,
                      description: description,
                    );
                    // if(imageurl!=null) {
                    //   PostDatabase newpostdb = PostDatabase(
                    //       username: usernameSingleton().username,
                    //       userAddress: address,
                    //       imageurl: imageurl,
                    //       caption: caption,
                    //       category: description);
                    //   newpostdb.uploadPost();
                    // }
                    // else
                    //
                    //   {
                    //     print("Sorry man it didn't work");
                    //   }
                    /** dummy db**/
                    if(imageurl!=null) {
                      dummyDatabase dumb = dummyDatabase(userAddress: address,
                          imageurl: imageurl,
                          caption: caption,
                          username: usernameSingleton().username,
                          category: description,
                      );
                      dumb.uploadPost();
                    }
                    else
                      {
                        print("Sorry man didn't work");
                      }
                    // Add the new post to the list
                    Post.allPosts.add(newPost);
                     Get.offAll(Dashboard());
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

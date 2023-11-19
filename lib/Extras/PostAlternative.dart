import 'package:image_picker/image_picker.dart';

class PostAlt {
  final String UserName;
  final String caption;
  final String selectedImage;
  final String address;
  final String description;
  PostAlt({
    required this.UserName,
    required this.caption,
    required this.selectedImage,
    required this.address,
    required this.description,
  });
  static List<PostAlt> allPosts = []; // A static list to store all posts
  // A method to add a new post to the list
  static void addNewPost(PostAlt post) {
    allPosts.add(post);
  }
}

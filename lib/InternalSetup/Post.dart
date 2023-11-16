import 'package:image_picker/image_picker.dart';

class Post {
  final String UserName;
  final String caption;
  final XFile? selectedImage;
  final String address;
  final String description;
  Post({
    required this.UserName,
    required this.caption,
    required this.selectedImage,
    required this.address,
    required this.description,
  });
  static List<Post> allPosts = []; // A static list to store all posts
  // A method to add a new post to the list
  static void addNewPost(Post post) {
    allPosts.add(post);
  }
}

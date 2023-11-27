import 'package:image_picker/image_picker.dart';

class Post {
  final String UserName;
  final String caption;
  final XFile? selectedImage;
  final String address;
  final String description;
  final String value;
  final String name;
  Post({
    required this.UserName,
    required this.caption,
    required this.selectedImage,
    required this.address,
    required this.description,
    required this.value,
    required this.name
  });
  static List<Post> allPosts = []; // A static list to store all posts
  // A method to add a new post to the list
  static void addNewPost(Post post) {
    allPosts.add(post);
  }
}

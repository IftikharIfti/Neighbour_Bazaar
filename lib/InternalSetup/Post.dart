import 'package:image_picker/image_picker.dart';

class Post {
  final String caption;
  final XFile? selectedImage;
  final String address;

  Post({
    required this.caption,
    required this.selectedImage,
    required this.address,
  });
  static List<Post> allPosts = []; // A static list to store all posts
  // A method to add a new post to the list
  static void addNewPost(Post post) {
    allPosts.add(post);
  }
}

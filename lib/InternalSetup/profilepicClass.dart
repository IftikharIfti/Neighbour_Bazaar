import 'package:image_picker/image_picker.dart';

class ProfilePicClass{
  final XFile? img;
  final String username;
  ProfilePicClass({ required this.img,required this.username});
  static List<ProfilePicClass> allPfp = []; // A static list to store all posts
  // A method to add a new post to the list
  static void addNewPfp(ProfilePicClass post) {
    allPfp.add(post);
  }
}
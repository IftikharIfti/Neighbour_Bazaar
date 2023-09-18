import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  final String username;
  final String email;
  final String password;
 // final List<String> interests;
  const UserModel(
  {
    required this.username,
    required this.email,
    required this.password,
   // required this.interests,

  }
      );
//version1 
  toJson(){
    return{
      "Email":email,
      "Password":password,
      "UserName":username,
    };
  }

}


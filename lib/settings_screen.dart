import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:neighbour_bazaar/EditProfile.dart';
import 'package:neighbour_bazaar/InternalSetup/Post.dart';
import 'login_page.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'), // You can set the title here
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit Profile'),
            onTap: () {
              Get.to(()=>EditProfile());
              // Handle 'Edit Profile' action here
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Buy and Sell Areas'),
            onTap: () {
              // Handle 'Buy and Sell Areas' action here
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Handle 'Notifications' action here
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            onTap: () {
              // Handle 'Language' action here
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Account Management'),
            onTap: () {
              // Handle 'Account Management' action here
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () {
              // Handle 'Help' action here
            },
          ),
      //version2 android studio

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Post.allPosts.clear();
              Get.offAll(()=>const LoginPage());
              // Handle 'Logout' action here
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neighbour_bazaar/InternalSetup/upload.dart';
import 'package:neighbour_bazaar/UserLocation/GetUserLocation.dart';
class HomeScreen extends StatelessWidget {
  void navigateToUserLocation() {
    Get.offAll(() => ShowUserLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Screen Content'),
            ElevatedButton(
              onPressed: () {
              // Get.offAll(()=>UploadPage());
                navigateToUserLocation();
              },
              child: Text('Show User Location'),
            ),
          ],
        ),
      ),
    );
  }
}

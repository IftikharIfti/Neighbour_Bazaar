// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         //title: Text('Your App'),
//       ),
//       body: Center(
//         child: Text('Home Screen Content'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neighbour_bazaar/user_location.dart';

class HomeScreen extends StatelessWidget {
  void navigateToUserLocation() {
    Get.offAll(() => UserLocation());
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

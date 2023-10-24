// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'dashboard.dart';
//
// class AboutUser extends StatefulWidget {
//   final String username;
//   final String email;
//   final String password;
//
//   AboutUser(this.username, this.email, this.password);
//
//   @override
//   _AboutUserState createState() => _AboutUserState();
// }
//
// class _AboutUserState extends State<AboutUser> {
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController occupationController = TextEditingController();
//   final TextEditingController contactNumberController = TextEditingController();
//
//   bool isSubmitButtonEnabled = false;
//
//   Future<void> _saveUserInfo() async {
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//     // Get the values from the text controllers
//     final String location = locationController.text;
//     final String occupation = occupationController.text;
//     final String contactNumber = contactNumberController.text;
//
//     // Check if location, occupation, and contactNumber are filled
//     if (location.isNotEmpty && occupation.isNotEmpty && contactNumber.isNotEmpty) {
//       // Define the data you want to save in Firestore
//       final userData = {
//         'username': widget.username,
//         'email': widget.email,
//         'password': widget.password,
//         'location': location,
//         'occupation': occupation,
//         'contactNumber': contactNumber,
//       };
//
//       // Save the user data in Firestore
//       try {
//         await firestore.collection('User').add(userData);
//         // Data is saved to Firestore
//       } catch (e) {
//         // Handle any errors that occur during the process
//         print('Error saving user data: $e');
//       }
//       // Navigate to the dashboard
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => Dashboard()),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('About User'),
//       ),
//       body: Column(
//         children: [
//           TextField(
//             controller: locationController,
//             decoration: InputDecoration(labelText: 'Location'),
//           ),
//           TextField(
//             controller: occupationController,
//             decoration: InputDecoration(labelText: 'Occupation'),
//           ),
//           TextField(
//             controller: contactNumberController,
//             decoration: InputDecoration(labelText: 'Contact Number'),
//           ),
//           ElevatedButton(
//             onPressed: isSubmitButtonEnabled ? _saveUserInfo : null,
//             child: Text('Submit'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // Listen for changes in the text fields
//     locationController.addListener(_updateSubmitButton);
//     occupationController.addListener(_updateSubmitButton);
//     contactNumberController.addListener(_updateSubmitButton);
//   }
//
//   void _updateSubmitButton() {
//     // Enable the submit button when all required fields are filled
//     setState(() {
//       isSubmitButtonEnabled =
//           locationController.text.isNotEmpty &&
//               occupationController.text.isNotEmpty &&
//               contactNumberController.text.isNotEmpty;
//     });
//   }
//
//   @override
//   void dispose() {
//     // Clean up the controllers
//     locationController.dispose();
//     occupationController.dispose();
//     contactNumberController.dispose();
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dashboard.dart';

class AboutUser extends StatefulWidget {
  final String username;
  final String email;
  final String password;

  AboutUser(this.username, this.email, this.password);

  @override
  _AboutUserState createState() => _AboutUserState();
}

class _AboutUserState extends State<AboutUser> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  bool isSubmitButtonEnabled = false;

  Future<void> _saveUserInfo() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get the values from the text controllers
    final String location = locationController.text;
    final String occupation = occupationController.text;
    final String contactNumber = contactNumberController.text;

    // Check if location, occupation, and contactNumber are filled
    if (location.isNotEmpty && occupation.isNotEmpty && contactNumber.isNotEmpty) {
      // Define the data you want to save in Firestore
      final userData = {
        'UserName': widget.username,
        'Email': widget.email,
        'Password': widget.password,
        'Location': location,
        'Occupation': occupation,
        'ContactNumber': contactNumber,
      };

      // Save the user data in Firestore
      try {
        await firestore.collection('User').doc(widget.email).set(userData);
        // Data is saved to Firestore
      } catch (e) {
        // Handle any errors that occur during the process
        print('Error saving user data: $e');
      }
      // Navigate to the dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About User'),
      ),
      body: Column(
        children: [
          TextField(
            controller: locationController,
            decoration: InputDecoration(labelText: 'Location'),
          ),
          TextField(
            controller: occupationController,
            decoration: InputDecoration(labelText: 'Occupation'),
          ),
          TextField(
            controller: contactNumberController,
            decoration: InputDecoration(labelText: 'Contact Number'),
          ),
          ElevatedButton(
            onPressed: isSubmitButtonEnabled ? _saveUserInfo : null,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Listen for changes in the text fields
    locationController.addListener(_updateSubmitButton);
    occupationController.addListener(_updateSubmitButton);
    contactNumberController.addListener(_updateSubmitButton);
  }

  void _updateSubmitButton() {
    // Enable the submit button when all required fields are filled
    setState(() {
      isSubmitButtonEnabled =
          locationController.text.isNotEmpty &&
              occupationController.text.isNotEmpty &&
              contactNumberController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    // Clean up the controllers
    locationController.dispose();
    occupationController.dispose();
    contactNumberController.dispose();
    super.dispose();
  }
}

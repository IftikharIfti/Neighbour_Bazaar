import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard.dart';

class EditProfile extends StatefulWidget {
  final String email;

  EditProfile(this.email);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    // Fetch user data from Firestore based on the provided email
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final docSnapshot =
      await FirebaseFirestore.instance.collection('User').doc(widget.email).get();
      if (docSnapshot.exists) {
        final userData = docSnapshot.data() as Map<String, dynamic>;
        userNameController.text = userData['UserName'] ?? '';
        locationController.text = userData['Location'] ?? '';
        contactController.text = userData['ContactNumber'] ?? '';
        occupationController.text = userData['Occupation'] ?? '';
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> updateUserData() async {
    try {
      await FirebaseFirestore.instance.collection('User').doc(widget.email).set({
        'UserName': userNameController.text,
        'Location': locationController.text,
        'ContactNumber': contactController.text,
        'Occupation': occupationController.text,
      }, SetOptions(merge: true));

      // Redirect to the dashboard
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: userNameController,
                enabled: isEditing,
                decoration: InputDecoration(labelText: 'UserName'),
              ),
              TextFormField(
                controller: locationController,
                enabled: isEditing,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              TextFormField(
                controller: contactController,
                enabled: isEditing,
                decoration: InputDecoration(labelText: 'Contact'),
              ),
              TextFormField(
                controller: occupationController,
                enabled: isEditing,
                decoration: InputDecoration(labelText: 'Occupation'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Toggle the editing mode
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                child: Text(isEditing ? 'Cancel' : 'Edit Info'),
              ),
              ElevatedButton(
                onPressed: isEditing ? updateUserData : null,
                child: Text('Save and Exit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
class DummyCollectionReader extends StatefulWidget {
  @override
  _DummyCollectionReaderState createState() => _DummyCollectionReaderState();
}

class _DummyCollectionReaderState extends State<DummyCollectionReader> {
  @override
  void initState() {
    super.initState();
    _initializeFirebaseAndPrintDummyDocuments();
  }

  Future<void> _initializeFirebaseAndPrintDummyDocuments() async {
    try {
      // Ensure that Flutter is initialized
      WidgetsFlutterBinding.ensureInitialized();

      // Initialize Firebase
      await Firebase.initializeApp();

      // Now, you can call the method to print dummy document IDs
      await DummyDocumentPrinter.printDummyDocumentIds();
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dummy Collection Reader'),
      ),
      body: Center(
        child: Text('Fetching and printing Dummy documents...'),
      ),
    );
  }
}

class DummyDocumentPrinter {
  static Future<void> printDummyDocumentIds() async {
    try {
      // Access the Firestore collection "dummy"
      CollectionReference dummyCollection = FirebaseFirestore.instance.collection('dummy');

      // Use the get method to retrieve all documents in the collection
      QuerySnapshot querySnapshot = await dummyCollection.get();

      // Loop through each document in the "dummy" collection
      for (QueryDocumentSnapshot dummyDoc in querySnapshot.docs) {
        print('Dummy Document ID: ${dummyDoc.id}');

        // Access the "LocalUsers" subcollection for the current dummy document
        CollectionReference localUsersCollection = dummyDoc.reference.collection('LocalUsers');

        // Use the get method to retrieve all documents in the "LocalUsers" subcollection
        QuerySnapshot localUsersSnapshot = await localUsersCollection.get();

        // Loop through each document in the "LocalUsers" subcollection
        for (QueryDocumentSnapshot localUserDoc in localUsersSnapshot.docs) {
          print('LocalUser Document ID: ${localUserDoc.id}');

          // Access the "AllPosts" subcollection for the current local user document
          CollectionReference allPostsCollection = localUserDoc.reference.collection('AllPosts');

          // Use the get method to retrieve all documents in the "AllPosts" subcollection
          QuerySnapshot allPostsSnapshot = await allPostsCollection.get();

          // Loop through each document in the "AllPosts" subcollection
          for (QueryDocumentSnapshot allPostDoc in allPostsSnapshot.docs) {
            print('AllPosts Document ID: ${allPostDoc.id}');

            // Access the "RelatedPost" subcollection for the current "AllPosts" document
            CollectionReference relatedPostCollection = allPostDoc.reference.collection('RelatedPost');

            // Use the get method to retrieve all documents in the "RelatedPost" subcollection
            QuerySnapshot relatedPostSnapshot = await relatedPostCollection.get();

            // Loop through each document in the "RelatedPost" subcollection
            for (QueryDocumentSnapshot relatedPostDoc in relatedPostSnapshot.docs) {
              print('RelatedPost Document ID: ${relatedPostDoc.id}');
              print('Image: ${relatedPostDoc['image']}');
              print('Caption: ${relatedPostDoc['caption']}');



            }
          }
        }
      }
    } catch (e) {
      print('Error retrieving dummy documents: $e');
      // Handle errors if needed
    }
  }



}

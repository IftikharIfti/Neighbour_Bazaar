// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class MyFirestoreData extends StatefulWidget {
//   @override
//   _MyFirestoreDataState createState() => _MyFirestoreDataState();
// }
//
// class _MyFirestoreDataState extends State<MyFirestoreData> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore Data'),
//       ),
//       body: FutureBuilder<QuerySnapshot>(
//         future: FirebaseFirestore.instance.collection('User').get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator(); // Show a loading indicator while data is fetched.
//           }
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//           if (!snapshot.hasData) {
//             return Text('No data available'); // Handle the case where there's no data.
//           }
//           final documents = snapshot.data!.docs; // Get the list of documents in the collection.
//
//           // Process and display the data (example: display it in a ListView).
//           return ListView.builder(
//             itemCount: documents.length,
//             itemBuilder: (context, index) {
//               final data = documents[index].data() as Map<String, dynamic>;
//
//               // Access and display the 'Email', 'Password', and 'UserName' fields
//               final email = data['Email'] as String?;
//               final password = data['Password'] as String?;
//               final userName = data['UserName'] as String?;
//
//               return ListTile(
//                 title: Text('Email: ${email ?? 'N/A'}'),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Password: ${password ?? 'N/A'}'),
//                     Text('UserName: ${userName ?? 'N/A'}'),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyFirestoreData extends StatefulWidget {
  @override
  _MyFirestoreDataState createState() => _MyFirestoreDataState();
}

class _MyFirestoreDataState extends State<MyFirestoreData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Data'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('User').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while data is fetched.
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return Text('No data available'); // Handle the case where there's no data.
          }
          final documents = snapshot.data!.docs; // Get the list of documents in the collection.

          // Process and display the data (example: display it in a ListView).
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final data = documents[index].data() as Map<String, dynamic>;

              // Access and display the fields
              final email = data['Email'] as String?;
              final password = data['Password'] as String?;
              final userName = data['UserName'] as String?;
              final location = data['Location'] as String?;
              final occupation = data['Occupation'] as String?;
              final contactNumber = data['ContactNumber'] as String?;

              return ListTile(
                title: Text('Email: ${email ?? 'N/A'}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Password: ${password ?? 'N/A'}'),
                    Text('UserName: ${userName ?? 'N/A'}'),
                    Text('Location: ${location ?? 'N/A'}'),
                    Text('Occupation: ${occupation ?? 'N/A'}'),
                    Text('Contact Number: ${contactNumber ?? 'N/A'}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

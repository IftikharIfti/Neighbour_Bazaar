import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:neighbour_bazaar/dashboard.dart';

import '../UserNameSingleton.dart';


class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
       FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) =>
    // {
    //   if(!isAllowed)
    //     {
    //       AwesomeNotifications().requestPermissionToSendNotifications()
    //     }
    // }
    // );
  }


  // Future<void> _retrieveFCMToken() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   print('FCM Token: $token');
  // }

  // void _configureFirebaseMessaging() {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print("Received FCM message: $message");
  //     showLocalNotification(message.data['unseenCount']);
  //   });
  // }
  //
  // Future<void> initializeNotifications() async {
  //   final InitializationSettings initializationSettings =
  //   InitializationSettings(
  //     android: AndroidInitializationSettings('img/bazaar.png'),
  //   );
  //
  //   await flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //     onDidReceiveNotificationResponse:onSelectNotification,
  //   );
  // }
  //
  // Future<void> onSelectNotification(NotificationResponse? payload) async {
  //   // Handle notification tap here
  //   // Redirect to another page, update 'seen' in Firestore, etc.
  //   print('Notification tapped with payload: $payload');
  //
  // }
  triggerNotification()
  {
    AwesomeNotifications().createNotification(content:
      NotificationContent(id: 10,
          channelKey: 'basic_channel',
         title: 'Hello Brother',
        body: 'Hellooooo',
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: FutureBuilder(
        future: getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return FutureBuilder<int>(
              future: getseen(),
              builder: (context, seenSnapshot) {
                if (seenSnapshot.connectionState == ConnectionState.waiting ||
                    seenSnapshot.data == null) {
                  return Container();
                }

                return FutureBuilder<int>(
                  future: getcollect(),
                  builder: (context, collectSnapshot) {
                    if (collectSnapshot.connectionState == ConnectionState.waiting ||
                        collectSnapshot.data == null) {
                      return Container();
                    }

                    int collected = seenSnapshot.data!;
                    int seen = collectSnapshot.data!;
                    int unseen = collected - seen;


                   // showLocalNotification(unseen);

                    List<QueryDocumentSnapshot<Object?>>? notifications = snapshot.data as List<QueryDocumentSnapshot<Object?>>?;
                    if (notifications != null) {
                      return ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          return buildNotificationCard(notifications[index]);
                        },
                      );
                    } else {
                      return Container(); // Handle the case when notifications is null
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<int> getseen() async {
    final docSnapshot =
    await FirebaseFirestore.instance.collection('notificationuser').doc(usernameSingleton().username).get();
    final userData = docSnapshot.data() as Map<String, dynamic>;
    int seen = userData['seen'];
    print(seen);
    return seen;
  }

  Future<int> getcollect() async {
    print(usernameSingleton().username);
    final docSnapshot =
    await FirebaseFirestore.instance.collection('notificationuser').doc(usernameSingleton().username).get();
    final userData = docSnapshot.data() as Map<String, dynamic>;
    int collect = userData['collected'];
    return collect;
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getNotifications() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('notification').get();
    return querySnapshot.docs;
  }

  Widget buildNotificationCard(QueryDocumentSnapshot<Object?> notification) {
    String user = notification['user'];
    String category = notification['category'];
    String address = notification['address'];
    String date = notification['date'];
    String DocName=notification.id;
    // Fetch user-specific data from 'users' subcollection
    var currentUserDoc = notification.reference.collection('users').doc(usernameSingleton().username);

    return StreamBuilder(
      stream: currentUserDoc.snapshots(),
      builder: (context, snapshot) {
        bool seen = snapshot.data != null && snapshot.data!['done'] == 'yes';

        return WillPopScope(
            onWillPop: () async {
          Get.to(() => NotificationPage()); // Replace Dashboard() with your actual Dashboard class
          return false; // Return false to prevent default behavior
        },
        child: GestureDetector(
          onTap: () {
            triggerNotification();
            updateField(DocName);
            Get.to(()=>Dashboard());
            // Handle tap on notification
            // Update 'seen' in Firestore, navigate to another page, etc.
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: seen ? Colors.white : Colors.blueGrey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: '$user',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' has posted a new product in the ',
                      ),
                      TextSpan(
                        text: '$category',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' section near ',
                      ),
                      TextSpan(
                        text: '$address',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
         )
        );
      },
    );
  }
  void updateField(String Doc) async {
    // Get the reference to the document
    DocumentReference docRef = FirebaseFirestore.instance.collection('notification').doc(Doc).collection('users').doc(usernameSingleton().username);
    final docSnapshot =
    await FirebaseFirestore.instance.collection('notification').doc(Doc).collection('users').doc(usernameSingleton().username).get();
    final userdat = docSnapshot.data() as Map<String, dynamic>;
    String have=userdat['done'];
      if(have=='no') {
        DocumentReference docRef2 = FirebaseFirestore.instance.collection(
            'notificationuser').doc(usernameSingleton().username);
        final docSnapshot2 = await FirebaseFirestore.instance.collection(
            'notificationuser').doc(usernameSingleton().username).get();
        final userdat2 = docSnapshot2.data() as Map<String, dynamic>;
        int seen = userdat2['seen'];
        int collect = userdat2['collected'];
        collect += 1;
        if (have == 'no')
          seen += 1;
        await docRef2.update({
          'seen': seen,
        });
      }
    // Update the field
    await docRef.update({
      'done':'yes',
    });

  }
  //
  // void showLocalNotification(int unseenCount) async {
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'New Notifications',
  //     'You have $unseenCount new notification(s)',
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'neighbour_bazaar',
  //         'Neighour Bazaar',
  //         priority: Priority.high,
  //         importance: Importance.max,
  //       ),
  //     ),
  //     payload: 'New Notification Payload',
  //   );
  // }
}

Future<void> main() async {
     WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   usernameSingleton().username='abc';

   // AwesomeNotifications().initialize(null, [
   //      NotificationChannel(channelKey: 'basic_channel', channelName: 'Simple Notification', channelDescription:'Simple Channel')
   // ],
   //   debug: true
   // );
  runApp(
    GetMaterialApp(
      home: NotificationPage(),
    )
  );
}

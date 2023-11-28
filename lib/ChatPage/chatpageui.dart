import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neighbour_bazaar/ChatPage/messagedb.dart';
import 'package:neighbour_bazaar/UserNameSingleton.dart';
import 'package:neighbour_bazaar/dashboard.dart';

import '../InternalSetup/profilepicClass.dart';
import 'chatmessage.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter is initialized.
//
//   // Initialize Firebase
//   await Firebase.initializeApp();
//   usernameSingleton().username='shadid';
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       home: ChatScreen(),
//     );
//   }
// }
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

 class _ChatScreenState extends State<ChatScreen> {
  final List<String> usernames = [];

  @override
  void initState() {
    super.initState();
    loadUsernames();
  }

  Future<void> loadUsernames() async {
    try {
      List<String> friends = await fetchfriends();
      setState(() {
        usernames.addAll(friends);
      });
    } catch (e) {
      // Handle error
      print('Error loading usernames: $e');
    }
  }

  Future<List<String>>  fetchfriends()
  async{
    try {
      List<String> friends=[];
      CollectionReference dummyCollection = FirebaseFirestore.instance.collection('Message');
      QuerySnapshot querySnapshot = await dummyCollection.get();
      print('This query is ok');
      for (QueryDocumentSnapshot dummyDoc in querySnapshot.docs) {
        String user = dummyDoc.id;
        print('I am inside the user $user');
        //if(user==usernameSingleton().username) {
        if(user==usernameSingleton().username){
          CollectionReference localUsersCollection = dummyDoc.reference
              .collection('chatlist');
          QuerySnapshot localUsersSnapshot = await localUsersCollection.get();
          for (QueryDocumentSnapshot localUserDoc in localUsersSnapshot.docs) {
            String userName = localUserDoc.id;
            friends.add(userName);
          }
        }
      }
   return friends;
    }
    catch(e) {
      return [];
    }
  }

 // final List<String> usernames = ["User 1", "User 2", "User 3"];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      Get.to(() => Dashboard()); // Replace Dashboard() with your actual Dashboard class
      return false; // Return false to prevent default behavior
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: ListView.builder(
        itemCount: usernames.length,
        itemBuilder: (context, index) {
          // return ListTile(
          //   title: Text(usernames[index]),
          //   onTap: () {
          //     Get.to(()=>ChatDetailScreen(username: usernames[index]));
          //   },
          // );
          ProfilePicClass? userProfile = ProfilePicClass.allPfp
              .firstWhere((pfp) => pfp.username == usernames[index], orElse: () => ProfilePicClass(img: null, username: ''));

          return Column(
            children: [
              // Divider at the upper side of each conversation
              Divider(height: 1, color: Colors.grey),
              ListTile(
                leading: userProfile.img != null
                    ? CircleAvatar(
                  backgroundImage: FileImage(File(userProfile.img!.path)),
                )
                    : CircleAvatar(
                  // Placeholder avatar when no image is available
                  backgroundColor: Colors.grey,
                  child: Text(usernames[index][0].toUpperCase()),
                ),
                title: Text(
                  usernames[index],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Tap to chat",
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                onTap: () {
                  Get.to(() => ChatDetailScreen(username: usernames[index]));
                },
              ),
              // Divider at the lower side of each conversation
              Divider(height: 1, color: Colors.grey),
            ],
          );

        },
      ),
    )
    );
   }

}


class ChatDetailScreen extends StatefulWidget {
  final String username;

  ChatDetailScreen({required this.username});

  @override
  ChatDetailScreenState createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends State<ChatDetailScreen> {
  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    try {
      CollectionReference messageCollection =
      FirebaseFirestore.instance.collection('Message');

      // Fetch messages from the 'messages' subcollection
      QuerySnapshot messageSnapshot = await messageCollection
          .doc(usernameSingleton().username) // Assuming 'widget.username' is the friend's username
          .collection('chatlist')
          .doc(widget.username) // Your username
          .collection('messages')
          .get();

      // Iterate through the messages and add them to the 'messages' list
      for (QueryDocumentSnapshot messageDoc in messageSnapshot.docs) {
        String messageText = messageDoc['message'];
        String state = messageDoc['state'];
        //String datetime = messageDoc['datetime'];
        String text = messageDoc.id;
        String datetime='';
        if (text.endsWith("_send")) {
           datetime=text.substring(0, text.length - 5);
        } else if (text.endsWith("_received")) {
           datetime=text.substring(0, text.length - 9);
        }
        DateTime dateT = DateTime.parse(datetime);
        // Create a ChatMessage object and add it to the 'messages' list
        ChatMessage message = ChatMessage(
          user: usernameSingleton().username,
          friend: widget.username,
          message: messageText,
          state: state,
          datetime: dateT,
        );
        messages.add(message);
      }

      // Update the UI after fetching messages
      setState(() {});
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return buildMessageBubble(messages[index]);
                },
              ),
            ),
          ),
          buildMessageInputField(widget.username),
        ],
      ),
    );
  }

  Widget buildMessageBubble(ChatMessage message) {
    String sendTime = DateFormat.Hm().format(message.datetime);

    // Determine if the message is sent or received
    bool isSentMessage = message.state == "send";

    return Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isSentMessage ? Colors.blue : Colors.grey, // Use different colors for sent and received messages
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: isSentMessage ? Colors.white : Colors.black, // Use different text colors for sent and received messages
          fontSize: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.message),
            SizedBox(height: 4.0),
            Text(
              sendTime,
              style: TextStyle(
                color: isSentMessage ? Colors.white38 : Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
        )
    );
  }



  Widget buildMessageInputField(String friends) {
    TextEditingController messageController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              sendMessage(messageController.text,friends);
              messageController.clear();
            },
          ),
        ],
      ),
    );
  }

  void sendMessage(String text , String friends) {
    setState(() {
      // Create a new message and add it to the list
      print('This is $friends');
        messageDatabase message = messageDatabase(
        user: usernameSingleton().username,
        message: text,
        datetime: DateTime.now(),
        friend: friends,
        state: "send",
      );
        messageDatabase message1 = messageDatabase(
          user: friends,
          message: text,
          datetime: DateTime.now(),
          friend: usernameSingleton().username,
          state: "received",
        );
        message.uploadPost();
        message1.uploadPost();
        ChatMessage msg=ChatMessage(user: usernameSingleton().username,
            friend: friends, message: text, datetime: DateTime.now(),
            state: "send");
      messages.add(msg);
    });
  }
}


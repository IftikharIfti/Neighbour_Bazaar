import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neighbour_bazaar/ChatPage/messagedb.dart';
import 'package:neighbour_bazaar/UserNameSingleton.dart';

import 'chatmessage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter is initialized.

  // Initialize Firebase
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
    );
  }
}
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
        if(user=='abc'){
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: ListView.builder(
        itemCount: usernames.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(usernames[index]),
            onTap: () {
              // Navigate to the chat with the selected user
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(username: usernames[index]),
                ),
              );
            },
          );
        },
      ),
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

    return Container(
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
        messageDatabase message = messageDatabase(
        user: "abc",
        message: text,
        datetime: DateTime.now(),
        friend: friends,
        state: "send",
      );
        messageDatabase message1 = messageDatabase(
          user: friends,
          message: text,
          datetime: DateTime.now(),
          friend: "abc",
          state: "received",
        );
        message.uploadPost();
        message1.uploadPost();
        ChatMessage msg=ChatMessage(user: "abc",
            friend: friends, message: text, datetime: DateTime.now(),
            state: "send");
      messages.add(msg);
    });
  }
}


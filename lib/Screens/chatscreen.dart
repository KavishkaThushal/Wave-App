import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenchat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  late String message;

  final _authentication = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;

      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _authentication.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text(
          'Wave Chat',
          style: TextStyle(color: Colors.black54, fontFamily: 'Alkatra'),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('img/back.png'),
                  repeat: ImageRepeat.repeatY)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const MsgStream(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        onChanged: (value) {
                          message = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        messageController.clear();
                        _fireStore.collection('message').add({
                          'sender': loggedInUser.email,
                          'text': message,
                        });
                      },
                      child: const Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MsgStream extends StatelessWidget {
  const MsgStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('message').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data?.docs.reversed;
            List<MsgBox> messageText = [];
            for (var message in messages!) {
              var data = message.data() as Map;
              final msgTxt = data['text'];
              final msgSender = data['sender'];
              final currentUser = loggedInUser.email;
              final fullMsg = MsgBox(
                txt: msgTxt,
                sender: msgSender,
                isSender: currentUser == msgSender,
              );
              messageText.add(fullMsg);
            }
            return Expanded(
              child: ListView(
                reverse: true,
                children: messageText,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlue,
              ),
            );
          }
        });
  }
}
class MsgBox extends StatelessWidget {
  const MsgBox(
      {super.key,
        required this.txt,
        required this.sender,
        required this.isSender});
  final String txt;
  final String sender;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      child: Column(
        crossAxisAlignment:
        isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender,style: const TextStyle(
              fontFamily: 'Alkatra',
              color: Colors.white70
          ),),
          Material(
            elevation: 5.0,
            borderRadius: isSender
                ? const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))
                : const BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            color: isSender ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 20.0),
              child: Text(
                txt,
                style: TextStyle(
                  fontSize: 15.0,
                  color: isSender ? Colors.white70 : Colors.black45,
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_master_chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _messageStream =
      FirebaseFirestore.instance.collection('messages').snapshots();
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String messages;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getMessageFromStream();
  }

  void getCurrentUser() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        loggedInUser = user;
        print('User is signed in!');
        print(loggedInUser.email);
      }
    });
  }

  void getMessages() async {
    var messages = await _fireStore.collection('messages').get();
    // print(messages.docs.toList();
    for (var messages in messages.docs) {
      print(messages.data().values);
      for (var message in messages.data().values) {
        print(message);
      }
      print("***");
    }
  }

  void getMessageFromStream() async {
    await for (var snapshot in _fireStore.collection('messages').snapshots()) {
      for (var messages in snapshot.docs) {
        print("here ..");
        print(messages.data());
        var a = messages.data();
        print("plpl" + a['sender']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            leading: null,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.logout_outlined),
                  onPressed: () async {
                    final progressIndicator = ProgressHUD.of(context);
                    progressIndicator?.showWithText("Signing Out ...");
                    await _auth.signOut();
                    Navigator.pop(context);
                    progressIndicator?.dismiss();
                  }),
            ],
            title: Text('M️Chat'),
            backgroundColor: Colors.lightBlueAccent,
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                    stream: _messageStream,
                    builder: (context, snapshot) {
                      List<ListTile> tileWidgets = [];
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlueAccent,
                          ),
                        );
                      }

                      List<Text> textWIdgets = [];

                      var streamData = snapshot.data;
                      var streamdata2 = streamData?.docs;
                      ListTile lt;
                      for (var message in streamdata2!) {
                        textWIdgets.add(Text(message['messageText']));
                        textWIdgets.add(Text(message['sender']));
                      }

                      return Column(children: textWIdgets);
                    }),
                Container(
                  decoration: kMessageContainerDecoration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            messages = value;
                          },
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _fireStore.collection('messages').add({
                            'messageText': messages,
                            'sender': _auth.currentUser?.email
                          });
                          print('from get messages:');
                          // getMessages();
                          print('from stream');
                          getMessageFromStream();
                        },
                        child: Text(
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
      ),
    );
  }
}

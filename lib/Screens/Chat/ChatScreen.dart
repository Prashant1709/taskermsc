// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskermsc/Screens/Chat/messages.dart';
import 'package:taskermsc/Screens/Chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

Widget userName() {
  final user = FirebaseAuth.instance.currentUser;

  return FutureBuilder(
    future: Future.value(
        FirebaseFirestore.instance.collection(user!.uid).doc('Data').get()),
    builder: (ctx, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data! as Map<String, dynamic>;
        return Text("${data['username']}");
      }
      return Container();
    },
  );
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            userName(),
            Expanded(
              child: Messages(),
            ),
            newMessage(),
          ],
        ),
      ),
    );
  }
}

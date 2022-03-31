import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Messages extends StatefulWidget {
  Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final firestoreInstance = FirebaseFirestore.instance;

  Widget chatBubble(String message) {
    return Padding(
      padding: EdgeInsets.only(right: width(0.57)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(20)),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: height(0.05),
            maxWidth: width(0.05),
          ),
          child: Text(message, textAlign: TextAlign.center),
        ),
      ),
    );
  }

  double height(double height) {
    return MediaQuery.of(context).size.height * height;
  }

  double width(double width) {
    return MediaQuery.of(context).size.width * width;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Chats')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final chatDocs = chatSnapshot.data!.docs;
          return StaggeredGridView.countBuilder(
            crossAxisCount: 1,
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) => chatBubble(chatDocs[index]['text']),
          );
        });
  }
}

// ignore_for_file: unused_element, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chat extends StatefulWidget {
  const chat({Key? key}) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

String dp_url =
    "https://www.kindpng.com/picc/m/53-533328_man-cartoon-suit-businessman-person-manager-male-man.png";

class _chatState extends State<chat> {
  final _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  List<String> users = [];
  String uid = "";
  @override
  void initState() {
    super.initState();
    firestoreInstance.collection('Users').snapshots().listen((event) {
      for (var i in event.docs) {
        print(i.get('username'));
        users.add('${i.get('username')}');
      }
    });
    getdat();
  }

  Future<void> getdat() async {
    final newUser = _auth.currentUser;
    uid = newUser!.uid;
    firestoreInstance.collection('Users').doc('$uid').update({'status': true});
  }

  @override
  void dispose() {
    super.dispose();
    firestoreInstance.collection('Users').doc('$uid').update({'status': false});
  }

  Widget build(BuildContext context) {
    double height(double height) {
      return MediaQuery.of(context).size.height * height;
    }

    double width(double width) {
      return MediaQuery.of(context).size.width * width;
    }

    Widget chatBox(String name, String url, String lastMessage, String time) {
      return Container(
        height: height(0.08),
        width: width(1),
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    url //"https://www.kindpng.com/picc/m/53-533328_man-cartoon-suit-businessman-person-manager-male-man.png",
                    ),
                radius: 28,
              ),
              Padding(
                padding: EdgeInsets.only(top: height(0.015), left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      lastMessage,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Chat"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Color.fromARGB(255, 27, 33, 41),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: firestoreInstance.collection('Users').snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        if (users.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Text(
                              'No Data to show',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            )),
                          );
                        } else {
                          return SingleChildScrollView(
                            child: ListTile(
                              title: chatBox(users[index], dp_url,
                                  "Hi I am " + users[index], "18:20"),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

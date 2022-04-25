// ignore_for_file: prefer_const_constructors ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile2 extends StatefulWidget {
  const Profile2({Key? key}) : super(key: key);

  @override
  State<Profile2> createState() => _Profile2State();
}

enum ImageSourceType { gallery, camera }

class _Profile2State extends State<Profile2> {
  final _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String username = "";
  String uid = "";
  String url = "";
  String url2 = "";


  double height(double height) {
    return MediaQuery.of(context).size.height * height;
  }

  double width(double width) {
    return MediaQuery.of(context).size.width * width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 27, 33, 41),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "Hi!",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        _auth.currentUser!.displayName.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                // ignore: prefer_const_literals_to_create_immutables
                children: [CircleAvatar(
                  backgroundImage: AssetImage(_auth.currentUser?.photoURL as String),
                  radius: 62,
                  backgroundColor: Colors.blueGrey,
                ),
                  Positioned(
                    left: 60,
                    bottom: 5,
                    child: RawMaterialButton(
                      child: Icon(Icons.create_rounded),
                      fillColor: Colors.blue,
                      shape: CircleBorder(),
                      onPressed: () {
                        showModalBottomSheet(context: context, builder: (BuildContext bc){
                          return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Select your Display Picture",style: TextStyle(color: Colors.teal,fontSize: 20),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    OutlinedButton(onPressed: (){
                                      _auth.currentUser?.updatePhotoURL("assets/male1.png");
                                      //Navigator.of(context).popAndPushNamed('/login');
                                      Navigator.pop(context);
                                      showDialog(context: context,builder: (BuildContext bc){
                                        return AlertDialog(
                                          title: const Text('DP will be updated on next Login'),
                                        );
                                      });
                                    },
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(width: 5.0,color: Colors.transparent)
                                      ),
                                      child: Column(
                                        children: [
                                          CircleAvatar(radius: 32,backgroundImage: AssetImage("assets/male1.png"),backgroundColor: Colors.blueGrey,),
                                          Text("Andy",style: TextStyle(color: Colors.orange,fontSize: 16),),
                                        ],
                                      ),
                                    ),OutlinedButton(onPressed: (){
                                      _auth.currentUser?.updatePhotoURL("assets/male2.png");
                                      //Navigator.of(context).popAndPushNamed('/login');
                                      Navigator.pop(context);
                                      showDialog(context: context,builder: (BuildContext bc){
                                        return AlertDialog(
                                          title: const Text('DP will be updated on next Login'),
                                        );
                                      });
                                    },
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(width: 5.0,color: Colors.transparent)
                                      ),
                                      child: Column(
                                        children: [
                                          CircleAvatar(radius: 32,backgroundImage: AssetImage("assets/male2.png"),backgroundColor: Colors.blueGrey,),
                                          Text("Mandy",style: TextStyle(color: Colors.pink,fontSize: 16),),
                                        ],
                                      ),
                                    ),OutlinedButton(onPressed: (){
                                      _auth.currentUser?.updatePhotoURL("assets/male3.png");
                                      //Navigator.of(context).popAndPushNamed('/login');
                                      Navigator.pop(context);
                                      showDialog(context: context,builder: (BuildContext bc){
                                        return AlertDialog(
                                          title: const Text('DP will be updated on next Login'),
                                        );
                                      });
                                    },
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(width: 5.0,color: Colors.transparent)
                                      ),
                                      child: Column(
                                        children: [
                                          CircleAvatar(radius: 32,backgroundImage: AssetImage("assets/male3.png"),backgroundColor: Colors.blueGrey,),
                                          Text("Sandy",style: TextStyle(color: Colors.brown,fontSize: 16),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    OutlinedButton(onPressed: (){
                                      _auth.currentUser?.updatePhotoURL("assets/Female1.png");
                                      //Navigator.of(context).popAndPushNamed('/login');
                                      Navigator.pop(context);
                                      showDialog(context: context,builder: (BuildContext bc){
                                        return AlertDialog(
                                          title: const Text('DP will be updated on next Login'),
                                        );
                                      });
                                    },
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(width: 5.0,color: Colors.transparent)
                                      ),
                                      child: Column(
                                        children: [
                                          CircleAvatar(radius: 32,backgroundImage: AssetImage("assets/Female1.png"),backgroundColor: Colors.blueGrey,),
                                          Text("Alisha",style: TextStyle(color: Colors.orange,fontSize: 16),),
                                        ],
                                      ),
                                    ),OutlinedButton(onPressed: (){
                                      _auth.currentUser?.updatePhotoURL("assets/Female2.png");
                                      //Navigator.of(context).popAndPushNamed('/login');
                                      Navigator.pop(context);
                                      showDialog(context: context,builder: (BuildContext bc){
                                        return AlertDialog(
                                          title: const Text('DP will be updated on next Login'),
                                        );
                                      });
                                    },
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(width: 5.0,color: Colors.transparent)
                                      ),
                                      child: Column(
                                        children: [
                                          CircleAvatar(radius: 32,backgroundImage: AssetImage("assets/Female2.png"),backgroundColor: Colors.blueGrey,),
                                          Text("Nora",style: TextStyle(color: Colors.pink,fontSize: 16),),
                                        ],
                                      ),
                                    ),OutlinedButton(onPressed: (){
                                      _auth.currentUser?.updatePhotoURL("assets/Female3.png");
                                      //Navigator.of(context).popAndPushNamed('/login');
                                      Navigator.pop(context);
                                      showDialog(context: context,builder: (BuildContext bc){
                                        return AlertDialog(
                                          title: const Text('DP will be updated on next Login'),
                                        );
                                      });
                                    },
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(width: 5.0,color: Colors.transparent)
                                      ),
                                      child: Column(
                                        children: [
                                          CircleAvatar(radius: 32,backgroundImage: AssetImage("assets/Female3.png"),backgroundColor: Colors.blueGrey,),
                                          Text("Candice",style: TextStyle(color: Colors.brown,fontSize: 16),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
            height: 40,
            thickness: 2,
          ),
          Container(
            // width: width(1),
            height: height(0.25),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Color.fromARGB(255, 59, 71, 90),
              elevation: height(0.02),
              shadowColor: Colors.blue[900],
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: width(0.03), top: height(0.013)),
                      child: Text(
                        "Status",
                        style: TextStyle(
                          color: Color.fromARGB(255, 97, 162,
                              236), //Color.fromARGB(255, 103, 115, 151),
                          fontSize: height(0.037),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      endIndent: width(0.7),
                      indent: width(0.03),
                      thickness: 2,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: width(0.03), top: height(0.01)),
                      child: Text(
                        "Completed :",
                        style: TextStyle(
                            color: Colors.white54, fontSize: height(0.025)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: width(0.03))),
                        Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: height(0.02),
                        ),
                        Padding(padding: EdgeInsets.only(left: width(0.03))),
                        Text(
                          "15",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: height(0.02),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: width(0.1))),

                        Icon(
                          Icons.circle,
                          color: Colors.yellow[600],
                          size: height(0.02),
                        ),
                        Padding(padding: EdgeInsets.only(left: width(0.03))),
                        Text(
                          "8",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: height(0.02),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: width(0.1))),
                        Icon(
                          Icons.circle,
                          color: Colors.green[600],
                          size: height(0.02),
                        ),
                        Padding(padding: EdgeInsets.only(left: width(0.03))),
                        Text(
                          "2",
                          style: TextStyle(
                              color: Colors.white, fontSize: height(0.02)),
                        ),

                        // ignore: prefer_const_literals_to_create_immutables
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: width(0.03), top: height(0.02)),
                      child: Text(
                        "Remaining :",
                        style: TextStyle(
                            color: Colors.white54, fontSize: height(0.025)),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: width(0.03))),
                        Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: height(0.02),
                        ),
                        Padding(padding: EdgeInsets.only(left: width(0.03))),
                        Text(
                          "12",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: height(0.02),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: width(0.1))),
                        Icon(
                          Icons.circle,
                          color: Colors.yellow[600],
                          size: height(0.02),
                        ),
                        Padding(padding: EdgeInsets.only(left: width(0.03))),
                        Text(
                          "3",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: height(0.02),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: width(0.1))),
                        Icon(
                          Icons.circle,
                          color: Colors.green[600],
                          size: height(0.02),
                        ),
                        Padding(padding: EdgeInsets.only(left: width(0.03))),
                        Text(
                          "20",
                          style: TextStyle(
                              color: Colors.white, fontSize: height(0.02)),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: height(0.02))),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: height(0.2),
              minWidth: width(1),
            ),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Color.fromARGB(255, 59, 71, 90),
                elevation: height(0.02),
                shadowColor: Colors.blue[900],
                // ignore: prefer_const_literals_to_create_immutables
                child: Padding(
                  padding:
                      EdgeInsets.only(left: width(0.03), top: height(0.013)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Created Tasks ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 97, 162, 236),
                            fontSize: height(0.033)),
                      ),
                      Divider(
                        color: Colors.grey,
                        endIndent: width(0.53),
                        indent: width(0.01),
                        thickness: 2,
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}

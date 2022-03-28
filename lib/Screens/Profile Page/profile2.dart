// ignore_for_file: prefer_const_constructors ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskermsc/Screens/Profile Page/ImageSel.dart';

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
  void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageSel(type)));
  }
  Future<void> getdat() async {
    final newUser = _auth.currentUser;
    uid = newUser!.uid;
    print(uid);
    firestoreInstance
        .collection('$uid')
        .doc('Data')
        .snapshots()
        .listen((result) {
      print(result.get("username"));
      username = result.get("username");});
  }
  double height(double height) {
    return MediaQuery.of(context).size.height * height;
  }

  double width(double width) {
    return MediaQuery.of(context).size.width * width;
  }
      @override
      void initState() {
        super.initState();
        getdat();
        print(_auth.currentUser?.photoURL.toString());
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
                        username,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('${_auth.currentUser?.photoURL.toString()}'),
                      backgroundColor: Colors.transparent,
                      radius: 70,
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 70,
                    child: RawMaterialButton(
                      child: Icon(Icons.create_rounded),
                      fillColor: Colors.blue,
                      shape: CircleBorder(),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Wrap(
                              children: [
                                OutlinedButton(onPressed:(){
                                  _handleURLButtonPress(context, ImageSourceType.gallery);
                                },
                                  child: ListTile(
                                    leading: Icon(Icons.image,color: Colors.purple,),
                                    title: Text('Choose from Gallery'),
                                  ),
                                ),
                                OutlinedButton(onPressed:(){
                                  _handleURLButtonPress(context, ImageSourceType.camera);
                                },
                                  child: ListTile(
                                    leading: Icon(Icons.camera_alt,color: Colors.blueGrey,),
                                    title: Text('Use Camera'),
                                  ),
                                ),

                              ],
                            );
                          },
                        );
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
                    SizedBox(height: 10,),
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
                    SizedBox(height: 7,),
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

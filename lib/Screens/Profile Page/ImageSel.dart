import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskermsc/Screens/Profile%20Page/profile2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class ImageSel extends StatefulWidget {
  final type;
  ImageSel(this.type);

  @override
  ImageSelState createState() => ImageSelState(this.type);
}

class ImageSelState extends State<ImageSel> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var _image;
  var imagePicker;
  var type;
  String uid="";
  String url="";

  ImageSelState(this.type);

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
    final newUser = _auth.currentUser;
    //print(newUser?.uid);
    uid = newUser!.uid;
    print(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
          title: Text(type == ImageSourceType.camera
              ? "Image from Camera"
              : "Image from Gallery")),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                var source = type == ImageSourceType.camera
                    ? ImageSource.camera
                    : ImageSource.gallery;
                XFile image = await imagePicker.pickImage(
                    source: source, imageQuality: 50, preferredCameraDevice: CameraDevice.front);

                setState(() {
                  _image = File(image.path);
                });
                storage.ref('${_auth.currentUser!.uid}').child('${_auth.currentUser!.displayName}').putFile(File(image.path));
                url=await storage.ref('${_auth.currentUser!.uid}').child('${_auth.currentUser!.displayName}').getDownloadURL();
                firestoreInstance
                    .collection('$uid')
                    .doc('Data')
                    .set({
                  'DisplayPhoto': url,
                });
               Navigator.pop(context);
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.red[200]),
                child: _image != null
                    ? Image.file(
                  _image,
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.fitHeight,
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey),
                  width: 20,
                  height: 20,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
            
          ),
          SizedBox(height: 20,),
          Text("Click up to Select Image",style: TextStyle(fontSize: 20),),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
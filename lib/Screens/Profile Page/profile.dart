// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  //Gives height and width according to screen size
  double height(double height) {
    return MediaQuery.of(context).size.height * height;
  }

  double width(double width) {
    return MediaQuery.of(context).size.width * width;
  }

  Widget addProfile(String label) {
    //This method add the fields with any entry type
    return Container(
      height: height(0.08),
      width: width(1),
      child: Card(
        color: Color.fromARGB(255, 33, 40, 51),
        child: OutlinedButton(
          onPressed: () => {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Color.fromARGB(255, 144, 161, 210),
                  fontSize: height(0.023),
                ),
              ),
              IconButton(
                onPressed: () => {},
                icon: Icon(Icons.arrow_forward_ios),
                color: Color.fromARGB(255, 144, 161, 210),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color.fromARGB(255, 20, 24, 30),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height(0.02),
              ),
              Center(
                child: Container(
                  height: height(0.2),
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: NetworkImage(
                      'https://www.linkpicture.com/q/dp_4.png',
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Upload Pricture",
                    style: TextStyle(
                      color: Color.fromARGB(255, 144, 161, 210),
                      fontWeight: FontWeight.bold,
                      fontSize: height(0.02),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addProfile("Personal Details"),
                  addProfile("Contacts"),
                  addProfile("Security"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

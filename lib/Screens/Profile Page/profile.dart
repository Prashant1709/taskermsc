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
  Widget addList(String label) {
    //This method add the fields with any entry type
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          fillColor: Color.fromARGB(255, 33, 40, 51), //rgba(33,40,51,255)
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(),
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget dividerLine(BuildContext context, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 30),
            child: Text(text,
                style: TextStyle(
                    color: Color.fromARGB(
                        255, 144, 161, 210), //rgba(144,161,210,255)
                    fontSize: MediaQuery.of(context).size.height * 0.035))),
        Divider(
          color: Colors.grey,
          height: MediaQuery.of(context).size.height * 0.03,
          endIndent: MediaQuery.of(context).size.height * 0.03,
          thickness: 2,
        ),
      ],
    );
  }

  Widget addProfile(String name,String label) {
    //This method add the fields with any entry type
    return Container(
      height: height(0.08),
      width: width(1),
      child: Card(
        color: Color.fromARGB(255, 33, 40, 51),
        child: OutlinedButton(
          onPressed: () => {showModalBottomSheet(
            isScrollControlled: false,
          context: context,
          builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                addList("Name"),
                addList("Gender"),
                dividerLine(context, "Address"),
                addList("Address Line 1"),
                addList("Address Line 2"),
                addList("Address Line 3"),
                dividerLine(context, "Location"),
                addList("City"),
                addList("State"),
                dividerLine(context, "Social"),
                addList("GitHub"),
                addList("Linkdin"),
                addList("Instagram"),
                addList("Facebook"),
                addList("Twitter"),
                addList("Other"),
              ],
            ),
          );
          })
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Color.fromARGB(255, 144, 161, 210),
                  fontSize: height(0.023),
                ),
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
                    "Upload Picture",
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
                  addProfile("Personal","/personal"),
                  addProfile("Contacts","/contact"),
                  addProfile("Security","/security"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

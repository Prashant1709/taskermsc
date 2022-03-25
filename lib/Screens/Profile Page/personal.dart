// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Personal extends StatefulWidget {
  const Personal({Key? key}) : super(key: key);

  @override
  State<Personal> createState() => _PersonalState();
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

class _PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 24, 30), //rgba(20,24,30,255)
      appBar: AppBar(
        title: Text("Personal Details"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
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
      ),
    );
  }
}

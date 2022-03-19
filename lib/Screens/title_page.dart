// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class titlePage extends StatelessWidget {
  const titlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
          // ignore: prefer_const_literals_to_create_immutables
          body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          Padding(padding: EdgeInsets.all(80)),
          Center(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Welcome to",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          Center(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "MSC Task Assigner",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(50)),
          Center(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Please login to your account or create",
                style: TextStyle(
                    color: Color.fromARGB(209, 158, 158, 158), fontSize: 16),
              ),
            ),
          ),
          Center(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "new account to continue",
                style: TextStyle(
                    color: Color.fromARGB(209, 158, 158, 158), fontSize: 16),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(130)),
          Container(
            height: 48,
            width: 333,
            decoration:
                BoxDecoration(border: Border.all(), color: Colors.blue[900]),
            child: MaterialButton(
              onPressed: (){
                Navigator.pushNamed(context,'/login');
              },
              color: Colors.blue[900],
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 16),),
                  Icon(Icons.navigate_next,color: Colors.white,),
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Container(
            height: 48,
            width: 333,
            decoration: BoxDecoration(
                border:
                    Border.all(color: Color.fromRGBO(36, 59, 139, 5), width: 5)),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context,'/regist');
              },
              color: Colors.black,
              child: Center(
                  child: Text("CREATE ACCOUNT",
                      style: TextStyle(fontSize: 16, color: Colors.white))),
            ),
          ),
        ],
      )),
    );
  }
}

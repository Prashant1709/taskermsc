// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class titlePage extends StatelessWidget {
  const titlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color.fromARGB(255, 20, 24, 30),
          // ignore: prefer_const_literals_to_create_immutables
          body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              SizedBox(height: 240,),
              CircleAvatar(backgroundImage: AssetImage('assets/logo2.png'),backgroundColor: Color.fromARGB(255, 20, 24, 30),radius: 70,),
              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Task It",
                    style: TextStyle(
                        color: Colors.teal.shade700,
                        fontSize: MediaQuery.of(context).size.height * 0.08,
                        fontFamily: 'ShadowsIntoLight'),
                  ),
                ),
              ),
              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Please login to your account or create",
                    style: TextStyle(
                        color: Color.fromARGB(209, 158, 158, 158),
                        fontSize: MediaQuery.of(context).size.height * 0.02),
                  ),
                ),
              ),
              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "new account to continue",
                    style: TextStyle(
                        color: Color.fromARGB(209, 158, 158, 158),
                        fontSize: MediaQuery.of(context).size.height * 0.02),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(15)),
              Container(
                height: MediaQuery.of(context).size.height * 0.059,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    border: Border.all(), color: Colors.blue[900]),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  color: Colors.blue[900],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.022),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: MediaQuery.of(context).size.height * 0.059,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(36, 59, 139, 5), width: 5)),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/regist');
                  },
                  color: Colors.black,
                  child: Center(
                      child: Text("CREATE ACCOUNT",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.022,
                              color: Colors.white))),
                ),
              ),
            ],
          )),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class titlePage extends StatefulWidget {
  const titlePage({Key? key}) : super(key: key);

  @override
  State<titlePage> createState() => _titlePageState();
}

class _titlePageState extends State<titlePage> {
  int _widgetId = 1;
  @override
  /*void initState() {
    // TODO: implement initState
    super.initState();
    _updateWidget();
  }
  Widget _image1(BuildContext context){
    return Container(
      key: Key("First"),
      height: 200,
      child: Image(image: AssetImage("assets/4.png"),),
    );
  }
  Widget _image2(BuildContext context){
    return Container(
      key: Key("Second"),
      height: 200,
      child: Image(image: AssetImage("assets/2.png"),),
    );
  }
  Widget _renderWidget() {
    return _widgetId == 1 ? _image1(context) : _image2(context);
  }

  void _updateWidget() {
    setState(() {
      _widgetId = _widgetId == 1 ? 2 : 1;
    });
  }*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color.fromARGB(255, 20, 24, 30),
          // ignore: prefer_const_literals_to_create_immutables
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              SizedBox(
                height: 240,
              ),
              AnimatedSwitcher(duration: const Duration(seconds: 2),
                child: //_renderWidget(// )
                Container(height:300,width:270 ,child: Image(image: AssetImage("assets/3.png"),)),
              ),
              /*Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Tasker",
                    style: TextStyle(
                        color: Color.fromRGBO(103, 200, 195, 1),
                        fontSize: MediaQuery.of(context).size.height * 0.08,
                        fontFamily: 'ShadowsIntoLight'),
                  ),
                ),
              ),*/

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
                    //_renderWidget();
                    //_updateWidget();

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
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/regist');
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color?>(Colors.black)),
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

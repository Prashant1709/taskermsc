import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final _auth=FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String username="";
  String uid="";
  String Task="";
  double _priority = 2;
  String priority="";
  @override
  void initState() {
    super.initState();
    getdat();
  }
  void getdat() async {
    final newUser = await _auth.currentUser;
    //print(newUser?.uid);
    uid=newUser!.uid;
    setdat();
  }
  void setdat(){
    firestoreInstance.collection('$uid').doc('Data').snapshots().listen((result) {
      username=result.get("username");
    });
  }
  DateTime _date = DateTime.now();
  String sdat="";
  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2028, 1),
      helpText: 'Enter End Date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
        sdat=_date.day.toString();
      });
    }
  }
  Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(50, 70, 70, 1),
            centerTitle: true,
            elevation: 0,
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      //Navigator.pushNamed(context,'/profile'),
                    },
                    child: Icon(
                      Icons.supervised_user_circle_outlined,
                      size: 26.0,
                    ),
                  )
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      CircleAvatar(radius: 28,
                          backgroundImage: NetworkImage("https://www.kindpng.com/picc/m/53-533328_man-cartoon-suit-businessman-person-manager-male-man.png")),
                      SizedBox(height: 10,),
                      StreamBuilder<Object>(
                          stream: firestoreInstance.collection('$uid').doc('Data').snapshots(),
                          builder: (context, snapshot) {
                            return Text("Hi $username",style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),);
                          }
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home,color: Colors.teal,),
                  title: Text("Home"),
                  onTap: (){},
                ),
                Text("© MSC KIIT",textAlign: TextAlign.center,),
              ],
            ),
          ),
          body: SafeArea(child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder<Object>(
                          stream: firestoreInstance.collection('$uid').doc('Data').snapshots(),
                          builder: (context, snapshot) {
                            return Text("Hello $username!",style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                            ),);
                          }
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text("Have a nice day",style: TextStyle(color: Colors.white70,fontSize: 16),textAlign: TextAlign.left,),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: Stack(
                            children:<Widget>[ Center(
                              child: Container(
                                child: StreamBuilder<Object>(
                                    stream: firestoreInstance.collection('$uid').doc('prg').snapshots(),
                                    builder: (context, snapshot) {
                                      return CircularProgressIndicator(
                                        strokeWidth: 15,
                                        value: 0.75,
                                        color: Color.fromRGBO(79, 9, 29,1),
                                      );
                                    }
                                ),
                                width: 200,
                                height:200,
                              ),
                            ),
                              Center(child: Row(
                                children: [
                                  Text("\t\t\t\t\t\t 75%",textAlign:TextAlign.center,style: TextStyle(fontSize:20,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'poppins'),),
                                ],
                              )),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(onPressed: (){},color: Color.fromRGBO(64, 95, 95, 1),child: Text("All Tasks",style: TextStyle(color: Colors.white),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: Stack(
                            children:<Widget>[ Center(
                              child: Container(
                                child: StreamBuilder<Object>(
                                    stream: firestoreInstance.collection('$uid').doc('prg').snapshots(),
                                    builder: (context, snapshot) {
                                      return CircularProgressIndicator(
                                        strokeWidth: 15,
                                        value: 0.65,
                                        color: Color.fromRGBO(79, 9, 29,1),
                                      );
                                    }
                                ),
                                width: 200,
                                height:200,
                              ),
                            ),
                              Center(child: Row(
                                children: [
                                  Text("\t\t\t\t\t\t 65%",textAlign:TextAlign.center,style: TextStyle(fontSize:20,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'poppins'),),
                                ],
                              )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(onPressed: (){},color: Color.fromRGBO(64, 95, 95, 1),child: Text("Ongoing",style: TextStyle(color: Colors.white),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Stack(
                    children:<Widget>[ Center(
                      child: Container(
                        child: StreamBuilder<Object>(
                            stream: firestoreInstance.collection('$uid').doc('prg').snapshots(),
                            builder: (context, snapshot) {
                              return CircularProgressIndicator(
                                strokeWidth: 15,
                                value: 0.25,
                                color: Color.fromRGBO(79, 9, 29,1),
                              );
                            }
                        ),
                        width: 200,
                        height:200,
                      ),
                    ),
                      Center(child: Row(
                        children: [
                          Text("\t\t\t\t\t\t 25%",textAlign:TextAlign.center,style: TextStyle(fontSize:20,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontFamily: 'poppins'),),
                        ],
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(onPressed: (){},color: Color.fromRGBO(64, 95, 95, 1),child: Text("Completed",style: TextStyle(color: Colors.white),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),),
                ),

              ],
            ),
          )),
          floatingActionButton:FloatingActionButton( //Floating action button on Scaffold
            onPressed: (){
              showModalBottomSheet(context: context, builder: (context){
                return Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Create a new task!",style: TextStyle(color: Colors.teal,fontSize: 22),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        width: 350,
                        height: 50,
                        padding: EdgeInsets.only(left: 4),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type here",
                              hintStyle: TextStyle(color: Colors.grey[700])),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: false,
                          onChanged: (value){
                            Task=value;
                          },
                        ),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(onPressed:(){
                          _selectDate();
                          sdat=_date.day.toString();
                        },
                        color: Colors.teal,
                          child: Text("Select End Date",style: TextStyle(color: Colors.white),),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Set Priority",style: TextStyle(color: Colors.teal,fontSize: 18),),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Low",style: TextStyle(color: Colors.green,fontSize: 14),),
                        StatefulBuilder(builder: (context, setState) => Slider(
                          value: _priority,
                          min: 10,
                          max: 100,
                          divisions: 9,
                          activeColor: Colors.teal,
                          inactiveColor: Colors.tealAccent,
                          label: ((_priority/10).round()).toString(),
                          onChanged: (value) {
                            setState(() {
                              _priority = value;

                            });
                          },
                        ),),
                        Text("High",style: TextStyle(color: Colors.red,fontSize: 14),),
                      ],
                    ),
                    SizedBox(height: 20,),
                    MaterialButton(onPressed: (){},
                      color: Colors.teal,
                      child: Text("Create",style: TextStyle(color: Colors.white),),
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
                    ),
                  ],
                );
              },shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)) );
            },
            backgroundColor: Color.fromRGBO(64, 95, 95, 1),
            child: Icon(Icons.add), //icon inside button
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            //bottom navigation bar on scaffold
              color:Color.fromRGBO(50, 70, 70,1),
              shape: CircularNotchedRectangle(), //shape of notch
              notchMargin: 5, //notch margin between floating button and bottom appbar
              child: Row( //children inside bottom appbar
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.home, color: Colors.white,), onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },),

                  IconButton(icon: Icon(Icons.recent_actors, color: Colors.white,), onPressed: () {
                    //Navigator.pushNamed(context, '/logs');
                  },),
                  SizedBox(width: 30,),
                  IconButton(icon: Icon(Icons.sensor_door_outlined, color: Colors.white,), onPressed: () {
                    //Navigator.pushNamed(context, '/sen');
                  },),
                  IconButton(icon: Icon(Icons.stream, color: Colors.white,), onPressed: () {
                    //Navigator.pushNamed(context, '/str');
                  },),
                ],
              )
          ),
        ),
      );
    }
  }

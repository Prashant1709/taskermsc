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
  String priority="";
  double _priority=0;
  int all=0;
  List <DateTime> date=[];
  List <String> task=[];
  //List <String> priority=[];
  List <bool> Status=[];
  List pcol1=[];
  @override
  void initState() {
    super.initState();
    getdat();}
  Future<void> getdat() async {
    final newUser = _auth.currentUser;
    //print(newUser?.uid);
    uid=newUser!.uid;
    print(uid);
    firestoreInstance
        .collection('$uid').doc('Data').snapshots()
        .listen((result)  {
      print(result.get("username"));
      username=result.get("username");
      firestoreInstance.collection('$uid').doc('All').snapshots().listen((event) { all=event.get('number');});
    });
    firestoreInstance.collection("$uid").doc('Tasks').collection('Data').snapshots().listen((event) {
      for(var list in event.docs){
        Timestamp timestamp=list.get('Date');
        var result=DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
        //print(result);
        date.add(result);
        var task1=list.get('Task');
        task.add(task1);
        var sta=list.get('status');
        Status.add(sta);
        var prio=list.get('Priority');
        //priority.add(prio);
        if(prio=="green"){
          setState(() {
            pcol1.add(Colors.green);
          });
        }
        if(prio=="yellow"){
          setState(() {
            pcol1.add(Colors.yellow);
          });
        }
        if(prio=="red"){
          setState(() {
            pcol1.add(Colors.red);
          });
        }
      }
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
          backgroundColor: Colors.white24,
          appBar: AppBar(
            backgroundColor: Colors.white24,
            centerTitle: true,
            elevation: 0,
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        date.clear();
                        task.clear();
                        Status.clear();
                      });
                      getdat();
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
                ListTile(
                  leading: Icon(Icons.exit_to_app,color: Colors.teal,),
                  title: Text("Logout"),
                  onTap: (){
                   _auth.signOut();
                   Navigator.pop(context);
                  },
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
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  height: 500,
                  child: StreamBuilder<Object>(
                      stream:firestoreInstance.collection("$uid").doc('Tasks').collection('Data').snapshots() ,
                      builder: (context, snapshot) {
                        return ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: task.length,
                          itemBuilder: (context,int index)=>
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side:BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  onPressed: (){
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: true, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Update Task',style: TextStyle(color: Colors.teal,fontSize: 18),),
                                          content: SingleChildScrollView(
                                            child: Material(
                                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(height: 20,),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.grey),
                                                          borderRadius: BorderRadius.circular(5)),
                                                      width: 350,
                                                      height: 50,
                                                      padding: EdgeInsets.only(left: 4),
                                                      child: TextFormField(
                                                        style: TextStyle(fontSize: 18, color: Colors.black),
                                                        decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                            hintText: "Type here",
                                                            hintStyle: TextStyle(color: Colors.grey)),
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
                                                        sdat=_date.toString();
                                                      },
                                                        color: Colors.teal,
                                                        child: Text("Select End Date",style: TextStyle(color: Colors.white),),
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 30,),
                                                  Text("Set Priority",style: TextStyle(color: Colors.teal,fontSize: 18),),
                                                  StatefulBuilder(builder: (context, setState) =>Slider(
                                                    value: _priority,
                                                    max: 10,
                                                    label: (_priority/10).round().toString(),
                                                    onChanged: (double value) {
                                                      // print("$value");
                                                      setState(() {
                                                        _priority = value;

                                                      });
                                                      //print(_priority.round());
                                                    },
                                                  ),
                                                  ),
                                                  SizedBox(width: 20,),
                                                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                                                    Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: const Icon(Icons.image),
                                                          tooltip: 'Add image to task',
                                                          onPressed: () {},
                                                        ),
                                                        Text('Picture')
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: const Icon(Icons.person_add),
                                                          tooltip: 'Add collaborators',
                                                          onPressed: () {},
                                                        ),
                                                        Text('Collaborate')
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: const Icon(Icons.calendar_today),
                                                          tooltip: 'Add meet',
                                                          onPressed: () {},
                                                        ),
                                                        Text('Meeting')
                                                      ],
                                                    ),
                                                  ],)
                                                ],),),
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(onPressed: (){
                                              setState(() {
                                                all=all-1;
                                                if(_priority.toInt()>=0 && _priority.toInt()<4){
                                                  setState((){
                                                    priority="green";
                                                  });
                                                }
                                                else if(_priority.toInt()>=4 && _priority.toInt()<=7){
                                                  setState((){
                                                    priority="yellow";
                                                  });
                                                }
                                                else{
                                                  setState((){
                                                    priority="red";
                                                  });
                                                }
                                              });
                                              firestoreInstance.collection("$uid").doc('Tasks').collection('Data').doc('${date[index]}').update({'Task':Task,'Date':_date,'Priority':priority,'status':false,});
                                              firestoreInstance.collection("$uid").doc("Data").update({'number':all});
                                              Navigator.pop(context);
                                            },
                                              color: Colors.teal,
                                              child: Text("Update",style: TextStyle(color: Colors.white),),
                                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
                                            ),
                                            MaterialButton(onPressed: (){
                                              setState(() {
                                                all=all-1;

                                              });
                                              firestoreInstance.collection("$uid").doc('Tasks').collection('Data').doc('${date[index]}').delete();
                                              firestoreInstance.collection("$uid").doc("Data").update({'number':all});
                                              Navigator.pop(context);
                                            },
                                              color: Colors.teal,
                                              child: Text("Mark as Done",style: TextStyle(color: Colors.white),),
                                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
                                            ),
                                          ],
                                          elevation: 24,
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.white,
                                          pcol1[index],
                                        ],
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft,
                                      ),
                                    ),
                                    child:Card(
                                      color:Colors.white,
                                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("${task[index]}"),
                                          Text("${date[index]}"),
                                          //Text("${Status[index]}"),
                                        ],
                                      ), //declareyour widget here
                                    ),
                                  ),
                                ),
                              ),);

                      }
                  ),
                ),
              ],
            ),
          )),
          floatingActionButton:FloatingActionButton( //Floating action button on Scaffold
            onPressed: (){
              showDialog<void>(
                context: context,
                barrierDismissible: true, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Create Task',style: TextStyle(color: Colors.teal,fontSize: 18),),
                    content: SingleChildScrollView(
                      child: Material(
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              width: 350,
                              height: 50,
                              padding: EdgeInsets.only(left: 4),
                              child: TextFormField(
                                style: TextStyle(fontSize: 18, color: Colors.black),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type here",
                                    hintStyle: TextStyle(color: Colors.grey)),
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
                                sdat=_date.toString();
                              },
                                color: Colors.teal,
                                child: Text("Select End Date",style: TextStyle(color: Colors.white),),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              ),
                            ],
                          ),
                          SizedBox(width: 30,),
                          Text("Set Priority",style: TextStyle(color: Colors.teal,fontSize: 18),),
                          StatefulBuilder(builder: (context, setState) =>Slider(
                            value: _priority,
                            max: 10,
                            label: (_priority/10).round().toString(),
                            onChanged: (double value) {
                             // print("$value");
                              setState(() {
                                _priority = value;

                              });
                              //print(_priority.round());
                            },
                          ),
                          ),
                          SizedBox(width: 20,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                          Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.image),
                              tooltip: 'Add image to task',
                              onPressed: () {},
                            ),
                            Text('Picture')
                          ],
                        ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.person_add),
                                tooltip: 'Add collaborators',
                                onPressed: () {},
                              ),
                              Text('Collaborate')
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.calendar_today),
                                tooltip: 'Add meet',
                                onPressed: () {},
                              ),
                              Text('Meeting')
                            ],
                          ),
                        ],)
                        ],),),
                    ),
                    actions: <Widget>[
                      MaterialButton(onPressed: (){
                        setState(() {
                          all=all+1;
                          if(_priority.toInt()>=0 && _priority.toInt()<4){
                            setState((){
                              priority="green";
                            });
                          }
                          else if(_priority.toInt()>=4 && _priority.toInt()<=7){
                            setState((){
                              priority="yellow";
                            });
                          }
                          else{
                            setState((){
                              priority="red";
                            });
                          }
                        });
                        firestoreInstance.collection("$uid").doc('Tasks').collection('Data').doc('$_date').set({'Task':Task,'Date':_date,'Priority':priority,'status':false,});
                        firestoreInstance.collection("$uid").doc("Data").update({'number':all});
                        Navigator.pop(context);
                      },
                        color: Colors.teal,
                        child: Text("Create",style: TextStyle(color: Colors.white),),
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
                      ),
                    ],
                    elevation: 24,
                  );
                },
              );
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
                    Navigator.pushNamed(context, '/task');
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

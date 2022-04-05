// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String _url = 'https://meet.google.com';
  final _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String username = "";
  String uid = "";
  String Task = "";
  String priority = "";
  double _priority = 0;
  DateTime _sdate = DateTime.now();
  int all = 0;
  List<DateTime> date = [];
  List<String> task = [];
  //List <String> priority=[];
  List<bool> Status = [];
  List pcol1 = [];
  @override
  void initState() {
    super.initState();
    getdat();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('${notification.title}'),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('${notification.body}')],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  void showNotification() {
    setState(() {});
    flutterLocalNotificationsPlugin.show(
        0,
        "Task It",
        "New Task Created at ${DateTime.now()}",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  Future<void> getdat() async {
    final newUser = _auth.currentUser;
    _sdate = DateTime.now();
    //print(newUser?.uid);
    uid = newUser!.uid;
    print(uid);
    firestoreInstance
        .collection('Users')
        .doc('$uid').snapshots().listen((event) {
          all=event.get('number');
    });

    firestoreInstance
        .collection("Users")
        .doc('$uid')
        .collection('Task')
        .snapshots()
        .listen((event) {
      for (var list in event.docs) {
        Timestamp timestamp = list.get('Date');
        var result = DateTime.fromMicrosecondsSinceEpoch(
            timestamp.microsecondsSinceEpoch);
        print(result);
        date.add(result);
        var task1 = list.get('Task');
        task.add(task1);
        var sta = list.get('status');
        Status.add(sta);
        var prio = list.get('Priority');
        // priority.add(prio);
        if (prio == "green") {
          setState(() {
            pcol1.add(AssetImage("assets/green_background.jpg"));
          });
        }
        if (prio == "yellow") {
          setState(() {
            pcol1.add(AssetImage("assets/yellow_background.png"));
          });
        }
        if (prio == "red") {
          setState(() {
            pcol1.add(AssetImage("assets/red_background.jpg"));
          });
        }
      }
    });
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  DateTime _date = DateTime.now();
  String sdat = "";
  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2028, 1),
      helpText: 'Enter End Date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
        sdat = _date.day.toString();
      });
    }
  }

  // Gives height and width according to screen size
  double height(double height) {
    return MediaQuery.of(context).size.height * height;
  }

  double width(double width) {
    return MediaQuery.of(context).size.width * width;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 27, 33, 41),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Home"),
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
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://www.kindpng.com/picc/m/53-533328_man-cartoon-suit-businessman-person-manager-male-man.png",
                  ),
                  radius: 28,
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://www.linkpicture.com/q/dark_blue_1.jpg"),
                      fit: BoxFit.fill),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(
                            "https://www.kindpng.com/picc/m/53-533328_man-cartoon-suit-businessman-person-manager-male-man.png")),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _auth.currentUser!.displayName.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "${_auth.currentUser!.email}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.teal,
                ),
                title: Text("Home"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.teal,
                ),
                title: Text("Logout"),
                onTap: () {
                  _auth.signOut();
                  Navigator.pop(context);
                  //exit(0);
                },
              ),
              Text(
                "© MSC KIIT",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(
                color: Colors.grey,
                height: 90,
                thickness: 2,
              ),
              Container(
                height: 500,
                child: StreamBuilder<QuerySnapshot>(
                    stream: firestoreInstance
                        .collection("Users")
                        .doc('$uid').collection('Task')
                        .snapshots(),
                    builder: (context, snapshot) {
                      return StaggeredGridView.countBuilder(
                          crossAxisCount: 1,
                          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                          itemCount: task.length,
                          mainAxisSpacing: 10,
                          itemBuilder: (context, int index) {
                            if (task[0].isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/logo.png'),
                                  ),
                                ),
                              );
                            } else {
                              return OutlinedButton(
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 20,
                                  margin: EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: height(0.13),
                                      minWidth: width(1),
                                    ),
                                    child: Container(
                                      // height: 90,
                                      // width: width(1),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: pcol1[index],
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 20, left: 10, right: 10),
                                            child: Text(
                                              "${task[index]}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: height(0.024),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 20, left: 10, bottom: 10),
                                            child: Text(
                                              "${(date[index])}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: height(0.02),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          //Text("${Status[index]}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                onPressed: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: true,
                                    // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor:
                                            Color.fromARGB(255, 48, 48, 54),
                                        title: const Text(
                                          'Update Task',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 250, 251, 252),
                                              fontSize: 22),
                                        ),
                                        content: SingleChildScrollView(
                                          child: Material(
                                            color:
                                                Color.fromARGB(255, 48, 48, 54),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    width: 350,
                                                    height: 50,
                                                    padding: EdgeInsets.only(
                                                        left: 4),
                                                    child: TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText: "Type here",
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey)),
                                                      keyboardType:
                                                          TextInputType
                                                              .visiblePassword,
                                                      obscureText: false,
                                                      onChanged: (value) {
                                                        Task = value;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    MaterialButton(
                                                      onPressed: () {
                                                        _selectDate();
                                                        sdat = _date.toString();
                                                      },
                                                      color: Colors.blue[900],
                                                      child: Text(
                                                        "Select End Date",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Text(
                                                  "Set Priority",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                StatefulBuilder(
                                                  builder:
                                                      (context, setState) =>
                                                          Slider(
                                                    value: _priority,
                                                    max: 10,
                                                    label: (_priority / 10)
                                                        .round()
                                                        .toString(),
                                                    onChanged: (double value) {
                                                      // print("$value");
                                                      setState(() {
                                                        _priority = value;
                                                      });
                                                      //print(_priority.round());
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.image,
                                                            color: Colors.white,
                                                          ),
                                                          tooltip:
                                                              'Add image to task',
                                                          onPressed: () {},
                                                        ),
                                                        Text(
                                                          'Picture',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.person_add,
                                                            color: Colors.white,
                                                          ),
                                                          tooltip:
                                                              'Add collaborators',
                                                          onPressed: () {},
                                                        ),
                                                        Text(
                                                          'Collaborate',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons
                                                                .calendar_today,
                                                            color: Colors.white,
                                                          ),
                                                          tooltip: 'Add meet',
                                                          onPressed: () {
                                                            _launchInWebViewOrVC(
                                                                _url);
                                                          },
                                                        ),
                                                        Text(
                                                          'Meeting',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          MaterialButton(
                                            onPressed: () {
                                              setState(() {
                                                all = all - 1;
                                                if (_priority.toInt() >= 0 &&
                                                    _priority.toInt() < 4) {
                                                  setState(() {
                                                    priority = "green";
                                                  });
                                                } else if (_priority.toInt() >=
                                                        4 &&
                                                    _priority.toInt() <= 7) {
                                                  setState(() {
                                                    priority = "yellow";
                                                  });
                                                } else {
                                                  setState(() {
                                                    priority = "red";
                                                  });
                                                }
                                              });
                                              firestoreInstance
                                                  .collection("Users")
                                                  .doc('$uid')
                                                  .collection('Task')
                                                  .doc('${date[index]}')
                                                  .update({
                                                'Task': Task,
                                                'Date': _date,
                                                'Priority': priority,
                                                'status': false,
                                              });
                                              firestoreInstance
                                                  .collection("Users")
                                                  .doc("$uid")
                                                  .update({'number': all});
                                              Navigator.pop(context);
                                              setState(() {
                                                date.clear();
                                                task.clear();
                                                Status.clear();
                                              });
                                              getdat();
                                            },
                                            color: Colors.blue[900],
                                            child: Text(
                                              "Update",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              setState(() {
                                                all = all - 1;
                                              });
                                              firestoreInstance
                                                  .collection("Users")
                                                  .doc('$uid')
                                                  .collection('Task')
                                                  .doc('${date[index]}').delete();
                                              firestoreInstance
                                                  .collection("Users")
                                                  .doc('$uid').update({'number': all});
                                              Navigator.pop(context);
                                              setState(() {
                                                date.clear();
                                                task.clear();
                                                Status.clear();
                                              });
                                              getdat();
                                            },
                                            color: Colors.blue[900],
                                            child: Text(
                                              "Mark as Done",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          ),
                                        ],
                                        elevation: 24,
                                      );
                                    },
                                  );
                                },

                                //
                              );
                            }
                          });
                    }),
              ),
            ],
          ),
        )),
        floatingActionButton: FloatingActionButton(
          //Floating action button on Scaffold

          onPressed: () {
            showDialog<void>(
              context: context,
              barrierDismissible: true, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Color.fromARGB(255, 48, 48, 54),
                  title: const Text(
                    'Create Task',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  content: SingleChildScrollView(
                    child: Material(
                      child: Container(
                        color: Color.fromARGB(255, 48, 48, 54),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
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
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type here",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: false,
                                  onChanged: (value) {
                                    Task = value;
                                  },
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    _selectDate();
                                    sdat = _date.toString();
                                  },
                                  color: Colors.blue[900],
                                  child: Text(
                                    "Select End Date",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Set Priority",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            StatefulBuilder(
                              builder: (context, setState) => Slider(
                                value: _priority,
                                max: 10,
                                label: (_priority / 10).round().toString(),
                                onChanged: (double value) {
                                  // print("$value");
                                  setState(() {
                                    _priority = value;
                                  });
                                  //print(_priority.round());
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      icon: const Icon(Icons.image),
                                      color: Colors.white,
                                      tooltip: 'Add image to task',
                                      onPressed: () {},
                                    ),
                                    Text('Picture',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      color: Colors.white,
                                      icon: const Icon(Icons.person_add),
                                      tooltip: 'Add collaborators',
                                      onPressed: () {},
                                    ),
                                    Text('Collaborate',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      color: Colors.white,
                                      icon: const Icon(Icons.calendar_today),
                                      tooltip: 'Add meet',
                                      onPressed: () {
                                        _launchInWebViewOrVC(_url);
                                      },
                                    ),
                                    Text('Meeting',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        showNotification();
                        setState(() {
                          all = all + 1;
                          if (_priority.toInt() >= 0 && _priority.toInt() < 4) {
                            setState(() {
                              priority = "green";
                            });
                          } else if (_priority.toInt() >= 4 &&
                              _priority.toInt() <= 7) {
                            setState(() {
                              priority = "yellow";
                            });
                          } else {
                            setState(() {
                              priority = "red";
                            });
                          }
                        });
                        firestoreInstance
                            .collection("Users")
                            .doc('$uid')
                            .collection('Task')
                            .doc('$_date')
                            .set({
                          'Task': Task,
                          'Date': _date,
                          'Priority': priority,
                          'status': false,
                          'sdate': _sdate,
                        });
                        firestoreInstance
                            .collection("$uid")
                            .doc("Data")
                            .update({'number': all});
                        Navigator.pop(context);
                      },
                      color: Colors.teal,
                      child: Text(
                        "Create",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ],
                  elevation: 24,
                );
              },
            );
          },
          backgroundColor: Colors.blue[900],
          child: Icon(Icons.add), //icon inside button
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
            //bottom navigation bar on scaffold
            color: Color.fromARGB(255, 83, 82, 82),
            shape: CircularNotchedRectangle(), //shape of notch
            notchMargin:
                5, //notch margin between floating button and bottom appbar
            child: Container(
              height: height(0.078),
              child: Row(
                //children inside bottom appbar
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile2');
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/calendar');
                    },
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.sensor_door_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/chat');
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.stream,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //Navigator.pushNamed(context, '/str');
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

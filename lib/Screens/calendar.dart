import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/gestures.dart';
class calendar extends StatefulWidget {
  const calendar({Key? key}) : super(key: key);

  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  final _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String username = "";
  String uid = "";
  String Task = "";
  String priority = "";
  double _priority = 0;
  DateTime _sdate=DateTime.now();
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
  }

  Future<void> getdat() async {
    final newUser = _auth.currentUser;
    _sdate=DateTime.now();
    //print(newUser?.uid);
    uid = newUser!.uid;
    print(uid);
    firestoreInstance
        .collection('$uid')
        .doc('Data')
        .snapshots()
        .listen((result) {
      print(result.get("username"));
      username = result.get("username");
      firestoreInstance
          .collection('$uid')
          .doc('All')
          .snapshots()
          .listen((event) {
        all = event.get('number');
      });
    });
    firestoreInstance
        .collection("$uid")
        .doc('Tasks')
        .collection('Data')
        .snapshots()
        .listen((event) {
      for (var list in event.docs) {
        Timestamp timestamp = list.get('Date');
        var result = DateTime.fromMicrosecondsSinceEpoch(
            timestamp.microsecondsSinceEpoch);
        //print(result);
        date.add(result);
        var task1 = list.get('Task');
        task.add(task1);
        var sta = list.get('status');
        Status.add(sta);
        var prio = list.get('Priority');
        //priority.add(prio);
        if (prio == "green") {
          setState(() {
            pcol1.add(Colors.green);
          });
        }
        if (prio == "yellow") {
          setState(() {
            pcol1.add(Colors.amber);
          });
        }
        if (prio == "red") {
          setState(() {
            pcol1.add(Colors.red);
          });
        }
      }
    });
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
  //Gives height and width according to screen size
  double height(double height) {
    return MediaQuery.of(context).size.height * height;
  }

  double width(double width) {
    return MediaQuery.of(context).size.width * width;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color.fromARGB(255, 27, 33, 41),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text("Your Tasks"),
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
                      StreamBuilder<Object>(
                          stream: firestoreInstance
                              .collection('$uid')
                              .doc('Data')
                              .snapshots(),
                          builder: (context, snapshot) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  username,
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
                            );
                          }),
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
          body:SfCalendar(
            view: CalendarView.month,
            backgroundColor: Colors.white,
            dataSource: MeetingDataSource(_getDataSource()),
            monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          )
      ),);
  }
}
List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting(
      'Conference', startTime, endTime, const Color(0xFF0F8644), false));
  return meetings;
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }
  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
  class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  }
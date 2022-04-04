import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class chat extends StatefulWidget {
  const chat({Key? key}) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  final _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  List<String> users=[];
  String uid="";
  @override
  void initState() {
    super.initState();
    firestoreInstance.collection('Users').snapshots().listen((event) {
      for(var i in event.docs){
        print(i.get('username'));
        users.add('${i.get('username')}');
      }
    });
    getdat();
  }
  Future<void> getdat() async {
    final newUser = _auth.currentUser;
    uid = newUser!.uid;
    firestoreInstance.collection('Users').doc('$uid').update({'status':true});
  }
  @override
  void dispose() {
    firestoreInstance.collection('Users').doc('$uid').update({'status':false});
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 27, 33, 41),
        body: SafeArea(child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: firestoreInstance.collection('Users').snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        if(users.isEmpty)
                        {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(child: Text('No Data to show',style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),)),
                          );
                        }
                        else{
                          return SingleChildScrollView(
                            child: ListTile(
                              title: Text('${users[index]}',style: TextStyle(fontSize: 17,color: Colors.white),),
                            ),
                          );
                        }
                      },
                    );
                  }
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}

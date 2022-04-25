import 'package:flutter/material.dart';
class event extends StatefulWidget {
  const event({Key? key}) : super(key: key);

  @override
  State<event> createState() => _eventState();
}

class _eventState extends State<event> {
  @override
  bool _passwordVisible = true;
  String username = "";
  String pass = "";
  String name="";
  String Department="Select Department";
  String Coordinator="";
  String Description="";
  bool paid=false;
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 27, 33, 41),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Events"),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(context: context, builder: (BuildContext bc){
                    return AlertDialog(
                      title: const Text('Authentication'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text("Authenticate yourself to edit or create event"),
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5)),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.06,
                              padding: EdgeInsets.only(left: 4),
                              child: TextFormField(
                                style: TextStyle(fontSize: 18, color: Colors.black),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Your Username",
                                    hintStyle: TextStyle(color: Colors.grey[700])),
                                onChanged: (value) {
                                  username = value;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5)),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.06,
                              padding: EdgeInsets.only(left: 4),
                              child: TextFormField(
                                style: TextStyle(fontSize: 18, color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey[700]),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !_passwordVisible,
                                obscuringCharacter: '*',
                                onChanged: (value) {
                                  pass = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Proceed'),
                          onPressed: () {
                            if(username=="Admin" && pass=="MSCdev!"){
                              Navigator.of(context).pop();
                              showModalBottomSheet(context: context, builder:(BuildContext bs){
                                return Column(
                                  children: [

                                  ],);
                              });
                            }
                            else{
                              showDialog(context: context, builder: (BuildContext bs){
                                return AlertDialog(
                                  title: Text("Wrong credentials"),
                                );
                              });
                            }
                          },
                        ),
                      ],
                      elevation: 24,
                    );
                  });
                },
                child: Icon(Icons.edit,color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

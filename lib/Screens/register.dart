// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  bool _passwordVisible = true;
  String email = "";
  String pass = "";
  String username = "";
  String uid = "";
  @override
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color.fromARGB(255, 20, 24, 30),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.12),
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Text("Email",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.026,
                              color: Colors.white))),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5)),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.06,
                    padding: EdgeInsets.only(left: 4),
                    child: TextFormField(
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.grey[700])),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Username",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.026,
                                color: Colors.white)),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5)),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.06,
                          padding: EdgeInsets.only(left: 4),
                          child: TextFormField(
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Your Username",
                                hintStyle: TextStyle(color: Colors.grey[700])),
                            onChanged: (value) {
                              username = value;
                            },
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 40)),
                        Text("Password",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.026,
                                color: Colors.white)),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5)),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.06,
                          padding: EdgeInsets.only(left: 4),
                          child: TextFormField(
                            style: TextStyle(fontSize: 18, color: Colors.white),
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
                                  color: Colors.white,
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
                            onChanged: (value) {
                              pass = value;
                            },
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 40)),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.062,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(border: Border.all()),
                          //color: Colors.blue[900],
                          child: MaterialButton(
                            onPressed: () async {
                              try {
                                final newUser =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email, password: pass);
                                if (newUser != null) {
                                  //print("Registered");
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('User Registered'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const <Widget>[
                                              Text(
                                                  'Click proceed to update username and receive verification mail'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Proceed'),
                                            onPressed: () async {
                                              final newUser =
                                                  await _auth.currentUser;
                                              uid = newUser!.uid;
                                              await newUser
                                                  .sendEmailVerification();
                                              firestoreInstance
                                                  .collection('Users')
                                                  .doc('$uid')
                                                  .set({
                                                'username': username,
                                                'status':false,
                                              });
                                              _auth.currentUser?.updateDisplayName(username);
                                              firestoreInstance
                                                  .collection('$uid')
                                                  .doc('All')
                                                  .set({
                                                'number': 0,

                                              });
                                              Navigator.of(context)
                                                  .popAndPushNamed('/login');
                                            },
                                          ),
                                        ],
                                        elevation: 24,
                                      );
                                    },
                                  );
                                }
                              } catch (e) {
                                print(e);
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Error Encountered'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text(
                                                "Check password, min 6 charachters needed"),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Proceed'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                      elevation: 24,
                                    );
                                  },
                                );
                              }
                            },
                            color: Colors.blue[900],
                            child: Center(
                                child: Text("REGISTER",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.022,
                                        color: Colors.white))),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(12.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                endIndent:
                                    MediaQuery.of(context).size.width * 0.01,
                                thickness: 2,
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.04,
                                child: Text("or",
                                    style: TextStyle(color: Colors.grey[700]))),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                endIndent:
                                    MediaQuery.of(context).size.height * 0.03,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(12.0)),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                  onPressed: () {
                                    signInWithGoogle();
                                  },
                                  child: CircleAvatar(
                                    foregroundImage:
                                        AssetImage('assets/google.png'),
                                    backgroundColor: Colors.black,
                                    minRadius: 22,
                                    maxRadius: 26,
                                  )),
                              VerticalDivider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              OutlinedButton(
                                  onPressed: () {},
                                  child: CircleAvatar(
                                    foregroundImage:
                                        AssetImage('assets/git.png'),
                                    backgroundColor: Colors.grey,
                                    minRadius: 22,
                                    maxRadius: 26,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.023,
                              color: Color.fromARGB(255, 128, 125, 125))),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text("Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.023,
                                  color: Colors.white)))
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

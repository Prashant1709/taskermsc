import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _auth=FirebaseAuth.instance;
  String email="";
  String pass="";
  @override
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

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
        backgroundColor: Colors.black,
          body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 80),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text("Email-ID",
                            style: TextStyle(fontSize: 18, color: Colors.white)),

                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5)),
                      width: 350,
                      height: 50,
                      padding: EdgeInsets.only(left: 4),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Your Email",
                            hintStyle: TextStyle(color: Colors.grey[700])),
                        onChanged: (value){
                          email=value;
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 40)),
                    Row(
                      children: [
                        Icon(Icons.admin_panel_settings_sharp,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text("Password",
                            style: TextStyle(fontSize: 18, color: Colors.white)),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5)),
                      width: 350,
                      height: 50,
                      padding: EdgeInsets.only(left: 4),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password(>6)",
                            hintStyle: TextStyle(color: Colors.grey[700])),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        obscuringCharacter: '*',
                        onChanged: (value){
                          pass=value;
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 60)),
                    Container(
                      height: 48,
                      width: 355,
                      decoration: BoxDecoration(border: Border.all()),
                      //color: Colors.blue[900],
                      child: MaterialButton(onPressed: () async {
                        try{
                          final user=await _auth.signInWithEmailAndPassword(email: email, password: pass);
                          if(user!=null){
                            print("Logged IN");
                            Navigator.pushNamed(context, '/home');
                          }
                          if(_auth.currentUser==null){
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('User Not Found'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: const <Widget>[
                                        Text('Please click on register to proceed!'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Accept'),
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
                        }catch(e){
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text('Please check the credentials to proceed!'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Accept'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                                elevation: 24,
                              );
                            },
                          );
                          print(e);
                        }

                      },
                        color: Colors.blue[900],
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 16),),
                          Icon(Icons.navigate_next,color: Colors.white,),
                        ],),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            height: 130,
                            endIndent: 10,
                            thickness: 2,
                          ),
                        ),
                        Container(
                            width: 20,
                            child: Text("or",
                                style: TextStyle(color: Colors.grey[700]))),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            height: 30,
                            endIndent: 20,
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                    IntrinsicHeight(
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(onPressed: (){
                              signInWithGoogle();
                          }, child: CircleAvatar(foregroundImage: AssetImage('assets/google.png'),backgroundColor: Colors.black,minRadius: 22,maxRadius: 26,)),
                          VerticalDivider(thickness: 1,color: Colors.grey,),
                          OutlinedButton(onPressed: (){}, child: CircleAvatar(foregroundImage: AssetImage('assets/git.png'),backgroundColor: Colors.grey,minRadius: 22,maxRadius: 26,)),
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
                  Text("Don't have an account?",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 128, 125, 125))),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context,'/regist');
                      },
                      child: Text("Register",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white)))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Password Recovery'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text('Enter registered email to get reset link.'),
                                    TextFormField(
                                      style: TextStyle(fontSize: 18, color: Colors.white),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter Your Email",
                                          hintStyle: TextStyle(color: Colors.grey[700])),
                                      onChanged: (value){
                                        email=value;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Proceed'),
                                  onPressed: () {
                                    _auth.sendPasswordResetEmail(email: email);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                              elevation: 24,
                            );
                          },
                        );
                      },
                      child: Text("Forgot Password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
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

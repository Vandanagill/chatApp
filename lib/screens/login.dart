import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  var authc = FirebaseAuth.instance;

  String email;
  String password;
  bool sspin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: sspin,
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Email",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "email cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "password cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(10),
                  elevation: 10,
                  child: MaterialButton(
                    minWidth: 200,
                    height: 40,
                    child: Text('Sign In'),
                    onPressed: () async {
                      setState(() {
                        sspin = true;
                      });

                      try {
                        var userSignin = await authc.signInWithEmailAndPassword(
                            email: email, password: password);
                        print(userSignin);

                        if (userSignin != null) {
                          Navigator.pushNamed(context, "chat");
                          setState(() {
                            sspin = false;
                          });
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "reg");
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

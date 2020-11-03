import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mychat_app/screens/login.dart';

class MyChat extends StatefulWidget {
  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  var msgtextcontroller = TextEditingController();

  var fs = FirebaseFirestore.instance;
  var authc = FirebaseAuth.instance;

  String chatmsg;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var signInUser = authc.currentUser.email;

    return Scaffold(
        appBar: AppBar(
          title: Text('chat'),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "map");
                  },
                  child: Icon(
                    Icons.map_outlined,
                    size: 26.0,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyLogin()));
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(Icons.exit_to_app)),
                )),
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                builder: (context, snapshot) {
                  print('new data comes');

                  var msg = snapshot.data.docs;
                  // print(msg);
                  // print(msg[0].data());

                  List<Widget> y = [];
                  for (var d in msg) {
                    // print(d.data()['sender']);
                    var msgText = d.data()['text'];
                    var msgSender = d.data()['sender'];
                    var msgWidget = Text("$msgText : $msgSender");

                    y.add(msgWidget);
                  }

                  print(y);

                  return Container(
                    child: Column(
                      children: y,
                    ),
                  );
                },
                stream: fs.collection("chat").snapshots(),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: deviceWidth * 0.70,
                    child: TextField(
                      controller: msgtextcontroller,
                      decoration: InputDecoration(hintText: 'Enter msg ..'),
                      onChanged: (value) {
                        chatmsg = value;
                      },
                    ),
                  ),
                  Container(
                    width: deviceWidth * 0.20,
                    child: FlatButton(
                      child: Text('send'),
                      onPressed: () async {
                        msgtextcontroller.clear();

                        await fs.collection("chat").add({
                          "text": chatmsg,
                          "sender": signInUser,
                        });
                        print(signInUser);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

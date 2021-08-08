
import 'package:application/login.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  final String uid;
  const Profile({required this.uid});

  @override
  _ProfileState createState() => _ProfileState(uid);
}

class _ProfileState extends State<Profile> {
  bool isLoggedIn = false;
  ScrollController _controller=ScrollController();
  final String uid;
  _ProfileState(this.uid);

  // String? get uid => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              doUserLogout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
            },
            child: Text("Log Out"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
        title: Text("Profile"),
      ),
      body: body(),
    ) ;
  }
  // Body Part
  Widget body(){

    var stream=FirebaseFirestore.instance.collection("Users").doc(uid).collection("signup").snapshots();

    return StreamBuilder(
              stream: stream,
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
               switch(snapshot.connectionState){
                 case ConnectionState.none:
                 case ConnectionState.waiting:
                   return center("Please wait....");
                 default:
                   if(snapshot.hasData){
                     if(snapshot.data!.docs.length == 0) {
                       return center(" No Record Found");
                     }else{
                       return ListView.builder(
                           scrollDirection: Axis.vertical,
                           controller: _controller,
                           physics: ScrollPhysics(),
                           itemCount:snapshot.data!.docs.length,
                           itemBuilder: (BuildContext context,int index){
                             String firstName=snapshot.data!.docs[index]["First Name"];
                             String email=snapshot.data!.docs[index]["Email"];
                             String lastName=snapshot.data!.docs[index]["Last Name"];
                             String password=snapshot.data!.docs[index]["Password"];
                             return Text(" $firstName \n $email \n $lastName \n $password");}
                       );

                     }
                   } else{
                     return center("Getting Error");
                   }

               }
              },

            );


  }

  //Center part
  Widget center(String text) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      child: Text('$text',
        style: TextStyle(
          fontSize: size.height * 0.025,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void doUserLogout() async {
    final user = await ParseUser.currentUser() as ParseUser;
    var response = await user.logout();

    if (response.success) {
      showSuccess("User was successfully logout!");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
      setState(() {
        isLoggedIn = false;
      });
    } else {
      showError(response.error!.message);
    }
  }
}

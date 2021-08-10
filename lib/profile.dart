
import 'package:application/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  bool isLoggedIn = false;
  ScrollController _controller=ScrollController();
  final String uid;
  _ProfileState(this.uid);

  // String? get uid => null;

  @override
  Widget build(BuildContext context) {
    var stream=FirebaseFirestore.instance.collection("Users").doc(uid).collection("signup").snapshots();


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          FlatButton.icon(
              onPressed: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login())),
              icon: Icon(Icons.logout), label: Text("Log Out"))
        ],
        title: Text("Profile"),
      ),

      body: StreamBuilder(
            stream: stream,
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
              switch(snapshot.connectionState){
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: Text("Please wait....",
                    style: TextStyle(
                        color: Colors.blue,
                            fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),
                  ));
                default:
                  if(snapshot.hasData){
                    if(snapshot.data!.docs.length == 0) {
                      return Center(child: Text(" No Record Found",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                        ),
                      ));
                    }else{
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          controller: _controller,
                          physics: ScrollPhysics(),
                          itemCount:snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context,int index) {
                            String firstName = snapshot.data!.docs[index]["First Name"];
                            String email = snapshot.data!.docs[index]["Email"];
                            String lastName = snapshot.data!.docs[index]["Last Name"];

                            return Container(
                              height: 130,
                              child: Card(
                                elevation: 10,
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text("$firstName $lastName"),
                                      subtitle: Text("$email"),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.teal,
                                        radius: 34,
                                        child: Text(snapshot.data!.docs[index]["First Name"][0],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                         color: Colors.white,
                                          fontSize: 30,
                                        ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                      IconButton( icon:Icon(Icons.edit),onPressed: ()async{
                                        await showDialog(context: context, builder: (context)=>AlertDialog(
                                          contentPadding: EdgeInsets.all(10),
                                          content: Column(
                                            children: <Widget>[
                                              Text("Edit Profile"),
                                              Expanded(child: TextFormField(
                                                autofocus: true,
                                                autocorrect: true,
                                                decoration: InputDecoration(labelText: "First Name"),
                                              )),
                                              Expanded(child: TextFormField(
                                                autofocus: true,
                                                autocorrect: true,
                                                decoration: InputDecoration(labelText: "Last Name"),
                                              )),
                                              Expanded(child: TextFormField(
                                                autofocus: true,
                                                autocorrect: true,
                                                decoration: InputDecoration(labelText: "Email"),
                                              ))
                                            ],
                                          ),
                                          actions: [
                                            FlatButton(onPressed: (){
                                              Navigator.pop(context);
                                            }, child: Text("Cancel",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                              ),
                                            )),
                                            FlatButton(onPressed: (){

                                              FirebaseFirestore.instance.collection("Users").doc(uid).collection("signup").doc(uid).update({
                                               "First Name":fnameController.text,
                                                "Last Name":lnameController.text,
                                                "Email":emailController.text,
                                              })
                                             .then((value) => Navigator.pop(context));
                                            }, child: Text("Update",
                                            style: TextStyle(
                                              color: Colors.blue
                                            ),
                                            ))
                                          ],
                                        ));

                                      },),
                                        IconButton( icon:Icon(Icons.delete),onPressed: (){
                                         FirebaseFirestore.instance.collection("Users").doc(uid).collection("signup").doc(uid).delete();
                                        },),

                                      ],
                                    ),
                                  ],
                                ),
                              ),

                            );
                          }
                          );

                          }
                  } else{
                    return Text("Getting Error");
                  }
              }
            },

          ),


    ) ;
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

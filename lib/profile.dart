
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var firestoreDB = FirebaseFirestore.instance.collection("Users").snapshots();
  late final String uid;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: StreamBuilder(
        stream: firestoreDB,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, int index) {
                return CustomCard(index: index, snapshot: snapshot.data);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _showDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(8),
        content: Column(
          children: <Widget>[
            Text("About you"),
            Expanded(
              child: TextField(
                autocorrect: true,
                autofocus: true,
                decoration: InputDecoration(labelText: "First Name"),
                controller: fnameController,
              ),
            ),
            Expanded(
              child: TextField(
                autocorrect: true,
                autofocus: true,
                decoration: InputDecoration(labelText: "Last Name"),
                controller: lnameController,
              ),
            ),
            Expanded(
              child: TextField(
                autocorrect: true,
                autofocus: true,
                decoration: InputDecoration(labelText: "Username"),
                controller: emailController,
              ),
            ),
            Expanded(
              child: TextField(
                autocorrect: true,
                autofocus: true,
                decoration: InputDecoration(labelText: "Password"),
                controller: passController,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              fnameController.clear();
              lnameController.clear();
              emailController.clear();
              passController.clear();
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () {
              if (fnameController.text.isNotEmpty &&
                  lnameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  passController.text.isNotEmpty) {
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(uid)
                    .collection("signup")
                    .add({
                  "First Name": fnameController.text,
                  "Last Name": lnameController.text,
                  "Email": emailController.text,
                  "Password": passController.text,
                  "timestamp": DateTime.now(),
                }).then((value) {
                  print(value.documentID);
                  fnameController.clear();
                  lnameController.clear();
                  emailController.clear();
                  passController.clear();
                  Navigator.pop(context);
                  // ignore: invalid_return_type_for_catch_error
                }).catchError((error) => print(error));
              }
            },
            child: Text("Save"),
          )
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

  const CustomCard({Key? key, required this.index, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var timeToDate = DateTime.fromMillisecondsSinceEpoch(
        snapshot.documents[index].data["timestamp"].seconds * 1000);
    var dateFormatted = DateFormat("EEEE,MM,D").format(timeToDate);
    var snapshotData = snapshot.documents[index].data;
    var docId = snapshot.documents[index].documentID;

    TextEditingController fnameController =
        TextEditingController(text: snapshotData["First Name"]);
    TextEditingController lnameController =
        TextEditingController(text: snapshotData["Last Name"]);
    TextEditingController emailController =
        TextEditingController(text: snapshotData[" Email"]);
    TextEditingController passController =
        TextEditingController(text: snapshotData["Password"]);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 170,
          child: Card(
            elevation: 9,
            child: Column(
              children: [
                ListTile(
                  title: Text(snapshot.documents[index].data["title"]),
                  subtitle: Text(snapshot.documents[index].data["Description"]),
                  leading: CircleAvatar(
                    radius: 34,
                    child: Text(snapshot.documents[index].data["title"][0]),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("by:${snapshot.documents[index].data["name"]}"),
                    Text(dateFormatted),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit, size: 15),
                      onPressed: () async {
                        // ignore: unnecessary_statements
                        await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  contentPadding: EdgeInsets.all(10),
                                  content: Column(
                                    children: <Widget>[
                                      Text("About you"),
                                      Expanded(
                                        child: TextField(
                                          autocorrect: true,
                                          autofocus: true,
                                          decoration: InputDecoration(
                                              labelText: "First Name"),
                                          controller: fnameController,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          autocorrect: true,
                                          autofocus: true,
                                          decoration: InputDecoration(
                                              labelText: "Last Name"),
                                          controller: lnameController,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          autocorrect: true,
                                          autofocus: true,
                                          decoration: InputDecoration(
                                              labelText: "Username"),
                                          controller: emailController,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          autocorrect: true,
                                          autofocus: true,
                                          decoration: InputDecoration(
                                              labelText: "Password"),
                                          controller: passController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    MaterialButton(
                                      onPressed: () {
                                        fnameController.clear();
                                        lnameController.clear();
                                        emailController.clear();
                                        passController.clear();
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        if (fnameController.text.isNotEmpty &&
                                            lnameController.text.isNotEmpty &&
                                            emailController.text.isNotEmpty &&
                                            passController.text.isNotEmpty) {
                                          FirebaseFirestore.instance
                                              .collection("Users")
                                              .document(docId)
                                              .updateData({
                                            "First Name": fnameController.text,
                                            "Last Name": lnameController.text,
                                            "Email": emailController.text,
                                            "Password": passController.text,
                                          }).then((value) {
                                            Navigator.pop(context);
                                          });
                                        }
                                      },
                                      child: Text("Update"),
                                    )
                                  ],
                                ));
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 15,
                      ),
                      onPressed: () async {
                        var CollectionReference =
                            FirebaseFirestore.instance.collection("Users");
                        await CollectionReference.document(docId).delete();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

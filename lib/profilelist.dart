// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class ProfileList extends StatefulWidget {
//   const ProfileList({Key? key}) : super(key: key);
//
//   @override
//   _ProfileListState createState() => _ProfileListState();
// }
//
// class _ProfileListState extends State<ProfileList> {
//   late String uid;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: bodyy(),
//     );
//   }
//
//   //body part
//   Widget bodyy(){
//     var stream=FirebaseFirestore.instance.collection("Users").doc(uid).collection("signup").snapshots();
//     return StreamBuilder(
//         stream:stream,
//         builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
//           switch(snapshot.connectionState){
//             case ConnectionState.none:
//             case ConnectionState.waiting:
//               return Text("Please wait...");
//             default:
//               if(snapshot.hasData) {
//                 print(snapshot.data!.docs.length);
//                 if (snapshot.data!.docs.length == 0) {
//                   return Text("No Record Found");
//                 } else {
//                   return Text(snapshot.data!.docs.length.toString());
//                 }
//               }else{
//                 return ListView.builder(
//                     itemCount:snapshot.data!.docs.length,
//                     itemBuilder:(BuildContext context,int index){
//                       String firstName=snapshot.data!.docs[index]["First Name"];
//                       String email=snapshot.data!.docs[index]["Email"];
//                       String lastName=snapshot.data!.docs[index]["Last Name"];
//                       String password=snapshot.data!.docs[index]["Password"];
//                       return Text("$firstName \n $email \n $lastName \n $password");}
//                 );
//               }
//           }
//         }
//     );
// }
//
//
// }

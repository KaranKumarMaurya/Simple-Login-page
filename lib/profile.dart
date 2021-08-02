import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DataBaseService{
  final String uid;
  DataBaseService({required this.uid});
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // final user=Provider.of<MyUser>(context);
    // AuthService authService=AuthService();
    // final uid=user.uid;
    // DataBaseService dataBaseService=DataBaseService(uid:uid);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.exit_to_app,color: Colors.white,),
            label: Text("Sign Out",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.settings,color: Colors.white,),
            label: Text("Setting",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Container(
        // color: Colors.tealAccent,
        // child: FlatButton(
        //   // onPressed: ()async{
        //   //   // dynamic names=await dataBaseService.getCurrentUserData() ;
        //   //   if(names!=null){
        //   //     String firstName=names[0];
        //   //     String lastName=names[1];
        //   //     print("firstName=$firstName");
        //   //     print("lastName=$lastName");
        //   //   }
        //   // }, child: Text("Profle Data"),
        //   color: Colors.teal,
        // ),
      ),
    );
  }

  //get user streams
  // Stream<QuerySnapshot>get users{
  //   return userCollection.snapshot();
  // }
  // Future getCurrentUserData() async{
  //   try{
  //
  //     DocumentSnapshot ds=await userCollection.doc(uid).get();
  //     String firstname=ds.get('firstName');
  //     String lastname=ds.get('lastName');
  //     return [firstname,lastname];
  //   }catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }
}




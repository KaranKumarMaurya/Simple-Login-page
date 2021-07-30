import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget Txt(String Tet){
    return Text(Tet,
      style: TextStyle(
        fontSize: 17,
      ),);
  }
  Widget Details(){
    return Container(
      height: 50,
      width: 370,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

      ),
    );
  }
  @override
  Widget build(BuildContext context) {
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
        width: 600,
        color: Colors.tealAccent,
        child: Column(
          children: <Widget>[
            SizedBox(height: 60,),
            Txt("First Name"),
            Details(),
            SizedBox(height: 20,),
            Txt("Last Name"),
            Details(),
            SizedBox(height: 20,),
            Txt("Email-Id"),
            Details(),
            SizedBox(height: 20,),
            Txt("Address"),
            Details(),

          ],
        ),
      ),
    );
  }
}

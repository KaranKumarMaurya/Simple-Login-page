import 'package:flutter/material.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Widget Details(String label,String hint){
    return
      Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: TextFormField(
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.black
            ),
            hintText: hint,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
            )
        ),
    ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.exit_to_app,color: Colors.white,),
            label: Text("Sign Out",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body:Center(child:
        SingleChildScrollView(
          child: Container(
           height: 800,
               color: Colors.tealAccent,
               child: Column(
                 children: <Widget>[
                 SizedBox(height: 60,),
                  Details("First Name", 'Enter your first name'),
                SizedBox(height: 20,),
                   Details("Last Name", 'Enter your last name'),
                SizedBox(height: 20,),
                   Details("Email-Id", 'Enter your email-id'),
                SizedBox(height: 20,),
                   Details("Address", 'Enter your address'),
                SizedBox(height: 60,),
                   MaterialButton(onPressed: (){},
                     color: Colors.white,
                     child: Text("Submit",
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 20,
                       ),
                     ),
                   )
                 ],
               ),
          ),
        ),
        ),

    );
  }
}

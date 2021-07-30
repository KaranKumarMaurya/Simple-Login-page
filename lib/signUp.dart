import 'package:flutter/material.dart';
class SignUp extends StatefulWidget {


  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,

      body: Center(
        child: Container(
          height: 390,
          width: 350,
          color: Colors.teal,
          child: Form(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: Column(
                children: <Widget>[

                  Row(
                    children: <Widget>[
                      Icon(Icons.account_circle_outlined,size: 25,),
                    Flexible(child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: "Username",
                          labelStyle: TextStyle(color: Colors.black,
                            fontSize: 18,

                          ),
                        hintText: "Enter valid email-id"
                      ),
                    ),),
                ],
              ),
                  SizedBox(height: 20,),
                  Row(

                    children: <Widget>[
                      Icon(Icons.vpn_key,size: 25,),
                      Flexible(child: TextFormField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.black,
                              fontSize: 18,
                            ),
                            hintText: "Password"
                        ),
                      ),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(

                    children: <Widget>[
                      Icon(Icons.vpn_key,size: 25,),
                      Flexible(child: TextFormField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: "Confirm Password",
                            labelStyle: TextStyle(color: Colors.black,
                              fontSize: 18,
                            ),
                            hintText: "Confirm Password"
                        ),
                      ),),
                    ],
                  ),
                  SizedBox(height: 60,),
                  MaterialButton(onPressed: (){},
                    color: Colors.white,
                    child: Text("Sign Up",
                      style: TextStyle(
                    fontSize:20,
                        fontWeight: FontWeight.bold


                  ),),),
          ]
          ),
            ),
        ),
      ),
      )
    );
  }
}

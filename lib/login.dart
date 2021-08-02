
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _LoginState extends State<Login> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();

  void validation() {
    final FormState? _form = _formKey.currentState;
    if (_form!.validate()) {
      print("Yes");
    } else {
      print("No");
    }
  }

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
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.account_circle_outlined,size: 25,),
                          Flexible(child: TextFormField(
                            validator: (value) {
                              if (value == "") {
                                return "Please fill Username";
                              } else if (value!.length < 6) {
                                return "Invalid Username";
                              }
                              return "";
                            },
                            controller: emailController,
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
                            key: _formKey,
                            validator: (value) {
                              if (value == "") {
                                return "Please fill Password";
                              } else if (value!.length < 6) {
                                return "Invalid Password";
                              }
                              return "";
                            },
                            controller: passController,
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

                      SizedBox(height: 60,),
                      MaterialButton(onPressed: () async{
                       // LoginUser();

                      },
                        color: Colors.white,
                        child: Text("Log In",
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
  // Future LoginUser() async{
  //   FirebaseAuth auth=FirebaseAuth.instance;
  //
  //   try{
  //     await auth.createUserWithEmailAndPassword(email:emailController.text
  //         ,password:passController.text).then((signedInUser)=>{print("success")}
  //     );
  //   }catch(e){
  //     print(e);
  //   }
  // }
}

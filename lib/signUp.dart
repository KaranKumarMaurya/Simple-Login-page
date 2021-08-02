
import 'Auth.dart';
import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool obserText = true;

class _SignUpState extends State<SignUp> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  TextEditingController fnameController=TextEditingController();
  TextEditingController lnameController=TextEditingController();

  String firstName ="";
  String lastName ="";
  String email ="";
  String password ="";

  bool loading = false;
  void validation() {
    final FormState? _form = _formKey.currentState;
    if (_form!.validate()) {
      print("Yes");
    } else {
      print("No");
    }
  }

  void submit() async{
    String createAccountData = await createAccount(firstName, lastName, email, password);
    if(createAccountData != null){
      print("User created successfully");
    }
    else{
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,

      body: Center(
        child: Container(
          height: 480,
          width: 350,
          color: Colors.teal,
          child: Form(

            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 60,),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(

                    validator: (value) {
                      if (value == "") {
                        return "Please fill First Name";
                      }
                      return "";
                    },
                    controller: fnameController,
                    onChanged: (value){
                      firstName = value;
                    },
                    decoration: InputDecoration(
                        labelText: "First Name",
                        labelStyle: TextStyle(
                            color: Colors.black
                        ),
                        hintText:"First Name",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                ),
                    SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value == "") {
                        return "Please fill Last Name";
                      }else {
                        return null;
                      }
                    },
                    controller: lnameController,
                    onChanged: (value){
                      lastName= value;
                    },
                    decoration: InputDecoration(
                        labelText: "Last Name",
                        labelStyle: TextStyle(
                            color: Colors.black
                        ),
                        hintText: "Last Name",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: TextFormField(
                        key: _formKey,
                        validator: (value) {
                          if (value == "") {
                            return "Please fill Username";
                          } else if (value!.length < 6) {
                            return "Invalid Username";
                          }
                          return "";
                        },
                        controller: emailController,
                        onChanged: (value){
                          email = value;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "Username",
                            labelStyle: TextStyle(color: Colors.black,
                              fontSize: 18,

                            ),
                          hintText: "Enter valid email-id"
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: TextFormField(

                        validator: (value) {
                          if (value == "") {
                            return "Please fill Password";
                          } else if (value!.length < 6) {
                            return "Invalid Password";
                          }
                          return "";
                        },

                        obscureText: obserText,
                        controller: passController,
                        onChanged: (value){
                          password = value;
                        },

                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obserText = !obserText;
                                });
                                FocusScope.of(context).unfocus();
                              },
                              child: Icon(Icons.visibility, color: Colors.black),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.black,
                              fontSize: 18,
                            ),
                            hintText: "Password"
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    MaterialButton(onPressed: () {
                        submit();
                        // signUpUser();
                        },
                      color:Colors.white,
                      child:
                      Text("Sign Up",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold


                        ),
                      ),
                    ),
          ]
          ),
              ),
            ),
        ),
      ),
      )
    );
  }
}


//Firebase Authentication
// class signUpUser{
// final String uid;
//
// FirebaseAuth auth=FirebaseAuth.instance;
// // User user= await FirebaseAuth.instance.currentUser;
//
// try{
// var signUpCollections = FirebaseFirestore.instance.collection("users");
// await auth.createUserWithEmailAndPassword(email:emailController.text
// ,password:passController.text,).then((signedInUser)=>
// {
// signUpCollections.doc(uid).collection('signup').add({
// 'email-id': emailController.text,
// 'first name':fnameController.text,
// 'last name':lnameController.text,
// }).then((signedInUser) => {
// print("successful"),
// Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login())),
// } ),
// } );
// }catch(e){
// print(e);
// }
// }

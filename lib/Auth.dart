import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> createAccount(
    String firstName, String lastName, String _email, String _password) async {
  try {
    User? user = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password))
        .user;

    await signUpUser(uid: user!.uid)
        .signUpData(firstName, lastName, _email, _password);
    return "null";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email';
    }
    return e.message.toString();
  } catch (e) {
    return e.toString();
  }
}

class signUpUser {
  final String uid;
  signUpUser({required this.uid});
  var signUpCollections = FirebaseFirestore.instance.collection("Users");

  Future signUpData(
      String firstName, String lastName, String email, String password) async {
    return await signUpCollections.doc(uid).collection("signup").add({
      'First Name': firstName,
      'Last Name': lastName,
      'Email': email,
      'Password': password,
    });
  }
}

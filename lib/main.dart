import 'package:application/profile.dart';
import 'package:application/profileprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(providers: [
        ListenableProvider<ProfileProvider>(create: (_)=>ProfileProvider())
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Profile(),
      )
  )
      );

}





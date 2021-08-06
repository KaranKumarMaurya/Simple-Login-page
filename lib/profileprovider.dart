import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier{
  String _uid='';
  String get uid=>_uid;

  void uidSetter(String uId){
    _uid=uId;
  }
}
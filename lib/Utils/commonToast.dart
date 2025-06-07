
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

commonToast({required color,message}){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 12.0
  );
}

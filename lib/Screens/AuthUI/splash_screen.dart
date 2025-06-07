import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final SplashController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/splash.png',fit: BoxFit.fill,width: 220),
      )
    );
  }
}

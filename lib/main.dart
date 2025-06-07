import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Routes/pages.dart';
import 'Utils/commonStyles.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyDGpVvix0bDyceDINXXDhaJzzQbTVQSrxo",
      appId: "1:1001512498454:android:0985186763d5221b6f8c37",
      messagingSenderId: "1001512498454",
      projectId: "buildthis-1af24"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Build This',
      popGesture: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: appColor),
        useMaterial3: true,
      ),
      transitionDuration: const Duration(milliseconds: 450),
      initialRoute: "/",
      getPages: Pages.getPages,
      defaultTransition: Transition.cupertino,
    );
  }
}

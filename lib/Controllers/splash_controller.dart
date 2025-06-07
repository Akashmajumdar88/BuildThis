import 'dart:async';
import 'package:get/get.dart';
import '../Screens/AuthUI/intro_screen.dart';
import '../Screens/dashboard.dart';
import '../Utils/shared_prefernces.dart';

class SplashController extends GetxController {

  late final Timer _timer;

  Future<void> _redirect() async {
    final getUserId = UserLoginDetails();
    var userId = await getUserId.getUserData('id');
    if (userId == null.toString()) {
      _timer = Timer(const Duration(seconds: 3), () => Get.to(const IntroScreen()));
    } else {
      _timer = Timer(const Duration(seconds: 3), () => Get.to(const Dashboard()));
    }
  }

  @override
  void onInit() {
    super.onInit();
    _redirect();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
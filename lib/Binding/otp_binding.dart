import 'package:get/get.dart';
import '../Controllers/otp_controller.dart';

class OtpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }
}
import 'package:get/get.dart';

class Routes {
  static Future<void> splashScreen() async {
    return await Get.offAllNamed("/");
  }
  static Future<void> loginPage() async {
    return await Get.offAllNamed("/LoginScreen");
  }

  static Future<void> signupScreen() async {
    return await Get.toNamed("/SignupScreen");
  }
  static Future<void> forgotPasswordScreen() async {
    return await Get.toNamed("/ForgotPasswordScreen");
  }

  static Future<void> otpScreen() async {
    return await Get.toNamed("/OtpScreen");
  }

  static Future<void> chatDetailsScreen() async {
    return await Get.toNamed("/ChatDetails");
  }
  static Future<void> editPersonalInfoScreen() async {
    return await Get.toNamed("/EditPersonalInfo");
  }
  static Future<void> allUserScreen() async {
    return await Get.toNamed("/UsersScreen");
  }
}
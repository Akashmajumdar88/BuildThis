import 'package:get/get.dart';
import '../Binding/allUser_binding.dart';
import '../Binding/chatDetails_binding.dart';
import '../Binding/editPersonalInfo_binding.dart';
import '../Binding/forgotPassword_binding.dart';
import '../Binding/login_binding.dart';
import '../Binding/otp_binding.dart';
import '../Binding/signup_binding.dart';
import '../Binding/splash_binding.dart';
import '../Screens/AuthUI/forgotPassword_screen.dart';
import '../Screens/AuthUI/login_screen.dart';
import '../Screens/AuthUI/otp_screen.dart';
import '../Screens/AuthUI/edit_profile.dart';
import '../Screens/AuthUI/signup_screen.dart';
import '../Screens/AuthUI/splash_screen.dart';
import '../Screens/Chat/chatDetails_screen.dart';
import '../Screens/OtherUser/users_screen.dart';

class Pages {
  static final List<GetPage<dynamic>> getPages = [
    GetPage(
      name: "/",
      page: () => SplashScreen(),
      popGesture: true,
      binding: SplashBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/LoginScreen",
      page: () => LoginScreen(),
      popGesture: true,
      binding: LoginBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/SignupScreen",
      page: () => SignupScreen(),
      popGesture: true,
      binding: SignupBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/ForgotPasswordScreen",
      page: () => ForgotPasswordScreen(),
      popGesture: true,
      binding: ForgotPasswordBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/OtpScreen",
      page: () => OtpScreen(),
      popGesture: true,
      binding: OtpBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/EditPersonalInfo",
      page: () => EditPersonalInfo(),
      popGesture: true,
      binding: EditPersonalInfoBinding(),
      showCupertinoParallax: true,
    ),
    GetPage(
      name: "/UsersScreen",
      page: () => UsersScreen(),
      popGesture: true,
      binding: AllUserBinding(),
      showCupertinoParallax: true,
    ),
  ];
}
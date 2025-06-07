
import 'package:get/get.dart';
import '../Controllers/allUser_controller.dart';

class AllUserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllUserController());
  }
}
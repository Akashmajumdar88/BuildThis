
import 'package:get/get.dart';
import '../Controllers/allProject_controller.dart';

class AllProjectBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllProjectController());
  }
}
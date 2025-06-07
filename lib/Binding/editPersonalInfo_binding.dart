
import 'package:get/get.dart';
import '../Controllers/editPersonalInfo_controller.dart';

class EditPersonalInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditPersonalInfoController());
  }
}
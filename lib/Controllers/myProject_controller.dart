
import 'package:get/get.dart';
import '../ApiServies/users/all_user_list.dart';

class MyProjectController extends GetxController {

  final myProjectList = Get.put(AllUserApiServices());

  @override
  void onInit() async {
    super.onInit();
    await myProjectList.getMyProjectApi();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
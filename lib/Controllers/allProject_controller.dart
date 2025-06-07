
import 'package:get/get.dart';
import '../ApiServies/ProjectApi/allProject_api.dart';

class AllProjectController extends GetxController {
  final allProjectList = Get.put(AllProjectUserApiServices());

  @override
  void onInit() async{
    super.onInit();
    allProjectList.getAllProjectApiService5();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
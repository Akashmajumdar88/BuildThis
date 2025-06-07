
import 'package:buildthis/Screens/Project/projectDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/allProject_controller.dart';
import '../../Utils/commonStyles.dart';

class ShowAllProjects extends StatelessWidget {
  ShowAllProjects({Key? key}) : super(key: key);

  final double _height = Get.height,_width = Get.width;
  AllProjectController? _allProjectController;
  @override
  Widget build(BuildContext context) {
    _allProjectController ??= Get.find<AllProjectController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("All Projects",style: TextStyles.appBarTitle),
      ),
      body: Container(
        width: _width,
        decoration: const BoxDecoration(
            color: Color(0xFFF9F9F9),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                topLeft: Radius.circular(50)
            )
        ),
        child: Column(
          children: [
            SizedBox(height: _height * 0.02),
            Container(
              width: 40,
              height: 8,
              decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(6)
              ),
            ),
            SizedBox(height: _height * 0.01),
            Expanded(
              child: Obx((){
                if (_allProjectController!.allProjectList.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (_allProjectController!.allProjectList.getAllProjectList5.isEmpty) {
                  return const Center(child: Text("No projects available."));
                }
                return ListView.builder(
                  itemCount: _allProjectController!.allProjectList.getAllProjectList5.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = _allProjectController!.allProjectList.getAllProjectList5[index];
                    String startDateStr = data.start;
                    String endDateStr = data.end;
                    DateTime startDate = DateTime.parse(startDateStr);
                    DateTime endDate = DateTime.parse(endDateStr);
                    Duration difference = endDate.difference(startDate);
                    int daysDifference = difference.inDays;
                    return GestureDetector(
                      onTap: () {
                        Get.to(Projectdetails(id: data.id.toString(),name: data.name.toString()));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFFFFFFF),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(data.name,style: TextStyles.cardTitle),
                                data.prImage != "" ?
                                ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(25), // Image radius
                                    child: Image.network(data.prImage, fit: BoxFit.fill),
                                  ),
                                ) :
                                Image.asset('assets/placeholder.png',fit: BoxFit.fill,width: 50,height: 50)
                              ],
                            ),
                            SizedBox(height: _height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Status",style: TextStyles.mulish10W300),
                                Text("Timeline",style: TextStyles.mulish10W300),
                              ],
                            ),
                            SizedBox(height: _height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 20,
                                  width: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(data.status,style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500)),
                                ),
                                Container(
                                  height: 20,
                                  width: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text("$daysDifference Days",style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

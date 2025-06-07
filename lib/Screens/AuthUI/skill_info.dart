
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ApiServies/ProjectApi/myProject.dart';
import '../../ApiServies/auth/updateProfile_api.dart';
import '../../Utils/commonButton.dart';
import '../../Utils/commonStyles.dart';

class skill_screen extends StatefulWidget {
  skill_screen({Key? key}) : super(key: key);

  @override
  State<skill_screen> createState() => _skill_screenState();
}

class _skill_screenState extends State<skill_screen> {

  final skillList = Get.put(ProjectApiServices());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMySkillApi();
  }
  Future<void> getMySkillApi() async {
    try {
      skillList.getMySkillApi();
    } catch (e) {
      print("Error fetching skills: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Skills",style: TextStyles.appBarTitle),
      ),
      body: Obx((){
        if (skillList.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (skillList.getMySkillList.isEmpty) {
          return const Center(child: Text("No Skills available."));
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          itemCount: skillList.getMySkillList.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var data = skillList.getMySkillList[index];
            return Row(
              children: [
                Flexible(
                  child: Container(
                    height: 35,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: appColor,
                        border: Border.all(color: Colors.grey,width: 0.5)
                    ),
                    child: Text(data.skillName,style: TextStyles.buttonStyle),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                    onTap: () {
                      onTapDeleteSkill(context,"${data.id}");
                    },
                    child: const Icon(Icons.delete_forever,color: Colors.red,size: 35)
                )
              ],
            );
          },
        );
      }),
    );
  }

  onTapDeleteSkill(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: 165,
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Are You Sure?", style: TextStyles.appBarTitle),
                const SizedBox(height: 20),
                Text("You won't be able to revert this!", style: TextStyles.labelStyle),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: ()async {
                        await UpdateProfileApiServices().deleteSkillApi(id: id);
                        getMySkillApi();
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                            color: appColor,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Text("Yes, Delete it!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14)),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()async {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 80,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue,width: 0.5),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Text("Cancel",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500,fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

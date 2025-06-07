import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utils/commonStyles.dart';
import 'skill_info.dart';

class PreferenceInfo extends StatelessWidget {
  PreferenceInfo({Key? key}) : super(key: key);
  final double _height = Get.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("My Profile",style: TextStyles.appBarTitle),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Project Preferences",style: TextStyles.nunito16W500),
              SizedBox(height: _height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(color: appColor),
                      color: Colors.white,
                    ),
                    child: GestureDetector(
                        onTap : (){
                         // Get.to(AcademicInfo());
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.circle,color: appColor,size: 10),
                            SizedBox(width: 10.0),
                            Text("Prev",
                                style: TextStyle(color: appColor,fontSize: 16,fontWeight: FontWeight.w600)),
                          ],
                        )
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Color(0xFFF2530A),
                    ),
                    child: GestureDetector(
                        onTap : (){
                          // Get.to(PreferenceInfo());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Save",style: TextStyles.buttonStyle),
                            const SizedBox(width: 10.0),
                            const Icon(Icons.circle,color: Colors.white,size: 10)
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}

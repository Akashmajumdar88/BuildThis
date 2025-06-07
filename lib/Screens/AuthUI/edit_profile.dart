
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../ApiServies/auth/updateProfile_api.dart';
import '../../Controllers/editPersonalInfo_controller.dart';
import '../../Utils/commonButton.dart';
import '../../Utils/commonFields.dart';
import '../../Utils/commonStyles.dart';
import '../../Utils/commonToast.dart';
import '../../Utils/shared_prefernces.dart';

class EditPersonalInfo extends StatelessWidget {
  EditPersonalInfo({Key? key}) : super(key: key);

  ImagePicker picker = ImagePicker();
  final double _height = Get.height,_width = Get.width;
  EditPersonalInfoController? _editPersonalInfoController;
  final validKey = GlobalKey<FormState>();
  final UpdateProfileApiServices _updateProfileService = Get.put(UpdateProfileApiServices());
  @override
  Widget build(BuildContext context) {
    _editPersonalInfoController ??= Get.find<EditPersonalInfoController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Edit Profile",style: TextStyles.appBarTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Form(
          key: validKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Personal Information",style: TextStyles.nunito16W500),
              SizedBox(height: _height * 0.02),
              Obx(()=>DottedBorder(
                  borderType: BorderType.Circle,
                  radius: const Radius.circular(12),
                  child: Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: _editPersonalInfoController!.profileImage.value == null ?
                    GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            barrierColor: Colors.red[50],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            enableDrag: false,
                            Container(
                              height: 120,
                              color: Colors.grey,
                              child: Wrap(
                                children: <Widget>[
                                  ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const Text('Gallery'),
                                      onTap: () async {
                                        _editPersonalInfoController!.profileImage.value = await picker.pickImage(source: ImageSource.gallery);
                                        Get.back();
                                      }),
                                  ListTile(
                                    leading: const Icon(Icons.photo_camera),
                                    title: const Text('Camera'),
                                    onTap: () async {
                                      _editPersonalInfoController!.profileImage.value = await picker.pickImage(source: ImageSource.camera);
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: const Text("Upload\nProfile")) :
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(File(_editPersonalInfoController!.profileImage.value!.path),height: 80,fit: BoxFit.fill,width: 80)),
                  )
              )),
              SizedBox(height: _height * 0.02),
              Text("Full Name",style: TextStyles.labelStyle),
              SizedBox(height: _height * 0.005),
              CommonTextField(
                  inputType: TextInputType.text,
                  validation: (nameValid) {
                    if (nameValid!.isEmpty) {
                      return "Please enter full name";
                    } else {
                      return null;
                    }
                  },
                  onPressed: () {},
                  cont: _editPersonalInfoController!.fullNameController,
                  hintText: "Full Name"),
              SizedBox(height: _height * 0.02),
              Text("User Name",style: TextStyles.labelStyle),
              SizedBox(height: _height * 0.005),
              CommonTextField(
                  inputType: TextInputType.text,
                  validation: (nameValid) {
                    if (nameValid!.isEmpty) {
                      return "Please enter user name";
                    } else {
                      return null;
                    }
                  },
                  onPressed: () {},
                  cont: _editPersonalInfoController!.userNameController,
                  hintText: "User Name"),
              SizedBox(height: _height * 0.02),
              Text("Date of Birth",style: TextStyles.labelStyle),
              SizedBox(height: _height * 0.005),
              CommonTextField(
                  inputType: TextInputType.text,
                  validation: (nameValid) {
                    if (nameValid!.isEmpty) {
                      return "Please enter birth";
                    } else {
                      return null;
                    }
                  },
                  read: true,
                  onPressed: ()async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2028),
                    );
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      _editPersonalInfoController!.birthController.text = formattedDate;
                    }
                  },
                  cont: _editPersonalInfoController!.birthController,
                  sufix: const Icon(Icons.calendar_month,color: Colors.grey,),
                  hintText: "Date of Birth"),
              SizedBox(height: _height * 0.02),
              Text("City",style: TextStyles.labelStyle),
              SizedBox(height: _height * 0.005),
              CommonTextField(
                  inputType: TextInputType.text,
                  validation: (nameValid) {
                    if (nameValid!.isEmpty) {
                      return "Please enter Address";
                    } else {
                      return null;
                    }
                  },
                  onPressed: () {},
                  cont: _editPersonalInfoController!.addressController,
                  hintText: "Address"),
              SizedBox(height: _height * 0.02),
              Text("Language",style: TextStyles.labelStyle),
              SizedBox(height: _height * 0.005),
              CommonTextField(
                  inputType: TextInputType.text,
                  validation: (nameValid) {
                    if (nameValid!.isEmpty) {
                      return "Please enter Language";
                    } else {
                      return null;
                    }
                  },
                  onPressed: () {},
                  cont: _editPersonalInfoController!.languageController,
                  hintText: "Hindi,English"),
              SizedBox(height: _height * 0.02),
              Text("Bio Description",style: TextStyles.labelStyle),
              SizedBox(height: _height * 0.005),
              CommonTextField(
                  inputType: TextInputType.text,
                  validation: (nameValid) {
                    if (nameValid!.isEmpty) {
                      return "Please enter Bio Description";
                    } else {
                      return null;
                    }
                  },
                  maxline: 2,
                  onPressed: () {},
                  cont: _editPersonalInfoController!.descriptionController,
                  hintText: "Description"),
              SizedBox(height: _height * 0.02),
              Obx(() {
                return _updateProfileService.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButtonIcon(
                  width: _width,
                  height: 40,
                  title: "Update",
                  onPressed: ()async {
                    String userName = '';
                    final getUserDetail = UserLoginDetails();
                    if (validKey.currentState!.validate()) {
                      if(_editPersonalInfoController!.profileImage.value == null){
                        commonToast(color: appColor,message: "Select Image");
                      }else{
                        _updateProfileService.updateProfile(
                          fullName: _editPersonalInfoController!.fullNameController.text,
                          userName: _editPersonalInfoController!.userNameController.text,
                          date: _editPersonalInfoController!.birthController.text,
                          city: _editPersonalInfoController!.addressController.text,
                          language: _editPersonalInfoController!.languageController.text,
                          bio: _editPersonalInfoController!.descriptionController.text,
                          profile: _editPersonalInfoController!.profileImage.value!.path,
                        );
                        userName = _editPersonalInfoController!.fullNameController.text;
                        await getUserDetail.setUserData("name", userName);
                      }
                    }
                  },
                );
              }),
              SizedBox(height: _height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}

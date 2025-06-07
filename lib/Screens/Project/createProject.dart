
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../ApiServies/ProjectApi/createProjectApi.dart';
import '../../Utils/commonButton.dart';
import '../../Utils/commonFields.dart';
import '../../Utils/commonStyles.dart';
import '../../Utils/commonToast.dart';

class CreateProject extends StatefulWidget {
  CreateProject({Key? key}) : super(key: key);

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  TextEditingController projectName = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController description = TextEditingController();
  final CreateProjectApiServices _createProjectService = Get.put(CreateProjectApiServices());
  ImagePicker picker = ImagePicker();
  final double _height = Get.height,_width = Get.width;
  String? categoryValue;
  String? skillValue;
  final validKey = GlobalKey<FormState>();
  File? _imageFile;
  @override
  DateTime? _lastBackPressed;
  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastBackPressed == null || now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }
  final List<Map<String, dynamic>> skills = [
    {"label": "Animator", "id": "Animator", "isSelected": false},
    { "label": "Game music composer", "id": "Game music composer","isSelected": false },
    { "label": "Graphic designer", "id": "Graphic designer" ,"isSelected": false},
    { "label": "App developer", "id": "App developer" ,"isSelected": false},
    { "label": "Roboticist", "id": "Roboticist" ,"isSelected": false},
    { "label": "System architect", "id": "System architect" ,"isSelected": false},
    { "label": "UX UI designer", "id": "UX UI designer" ,"isSelected": false},
    { "label": "Data Analytics", "id": "Data Analytics" ,"isSelected": false},
    { "label": "Software developer", "id": "Software developer" ,"isSelected": false},
    { "label": "Other", "id": "Other" ,"isSelected": false}

  ];
  List<String> selectedSkills = [];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text("Create Project",style: TextStyles.appBarTitle),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: validKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: _height * 0.005),
                DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    child: Container(
                      height: 80,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: _imageFile == null ?
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
                                          final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                          setState(() {
                                            if (pickedFile != null) {
                                              _imageFile = File(pickedFile.path);
                                            } else {
                                              print('No image selected.');
                                            }
                                          });
                                          Get.back();
                                        }),
                                    ListTile(
                                      leading: const Icon(Icons.photo_camera),
                                      title: const Text('Camera'),
                                      onTap: () async {
                                        final pickedFile = await picker.pickImage(source: ImageSource.camera);
                                        setState(() {
                                          if (pickedFile != null) {
                                            _imageFile = File(pickedFile.path);
                                          } else {
                                            print('No image selected.');
                                          }
                                        });
                                        Get.back();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: const Text("Upload\nLogo")):
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(File(_imageFile!.path),height: 80,fit: BoxFit.fill,width: 100)),
                    )
                ),
                SizedBox(height: _height * 0.02),
                Text("Project Name",style: TextStyles.labelStyle),
                SizedBox(height: _height * 0.005),
                CommonTextField(
                    inputType: TextInputType.text,
                    validation: (nameValid) {
                      if (nameValid!.isEmpty) {
                        return "Please enter project name";
                      } else {
                        return null;
                      }
                    },
                    onPressed: () {},
                    cont: projectName,
                    hintText: "Project Name"),
                SizedBox(height: _height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: _width * 0.40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Start Date",style: TextStyles.labelStyle),
                          SizedBox(height: _height * 0.005),
                          CommonTextField(
                              inputType: TextInputType.text,
                              validation: (nameValid) {
                                if (nameValid!.isEmpty) {
                                  return "Please enter start time";
                                } else {
                                  return null;
                                }
                              },
                              onPressed: ()async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2024),
                                  lastDate: DateTime(2028),
                                );
                                if (pickedDate != null) {
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  startDate.text = formattedDate;
                                }
                              },
                              read: true,
                              cont: startDate,
                              hintText: "Start Date"),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: _width * 0.40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("End Date",style: TextStyles.labelStyle),
                          SizedBox(height: _height * 0.005),
                          CommonTextField(
                              inputType: TextInputType.text,
                              validation: (nameValid) {
                                if (nameValid!.isEmpty) {
                                  return "Please enter end date";
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
                                  endDate.text = formattedDate;
                                }
                              },
                              cont: endDate,
                              hintText: "End Date"),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: _height * 0.02),
                Text("Category",style: TextStyles.labelStyle),
                SizedBox(height: _height * 0.005),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(14),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Color(0xFFD6D3D0), width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:  const BorderSide(color: Color(0xFFD6D3D0), width: 1.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Select Vehicle Type",
                        hintStyle:  TextStyles.hintStyle,
                        border: const OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey),gapPadding: 0)
                    ),
                    value: categoryValue,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select Vehicle Type';
                      }
                      return null;
                    },
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Text('Category',style: TextStyles.hintStyle
                      ),
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down_sharp,color: Colors.grey,),
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      categoryValue = newValue;
                    },
                    items: <String>['Augmented Reality (AR)','Animation','App-Development','Virtual Reality (VR)','Game-Development','Web-Development','Machine learning/AI','Robotics','Other']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(value,
                              style: TextStyles.fillStyle
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: _height * 0.02),
                Text("Skills",style: TextStyles.labelStyle),
                SizedBox(height: _height * 0.005),
                GestureDetector(
                  onTap: () {
                    onAddSkillGroup(context, (List<String> selected) {
                      setState(() {
                        selectedSkills = selected;
                      });
                    });
                  },
                  child: Container(
                    width: _width,
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFFD6D3D0))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(selectedSkills.isEmpty ? "Select skills" : selectedSkills.join(", "),style: TextStyles.hintStyle),
                    ),
                  ),
                ),
                SizedBox(height: _height * 0.02),
                Text("Project Description",style: TextStyles.labelStyle),
                SizedBox(height: _height * 0.005),
                CommonTextField(
                    inputType: TextInputType.text,
                    maxline: 2,
                    validation: (nameValid) {
                      if (nameValid!.isEmpty) {
                        return "Please enter project description";
                      } else {
                        return null;
                      }
                    },
                    cont: description,
                    onPressed: () {},
                    hintText: "Project Description"),
                SizedBox(height: _height * 0.02),
                Obx((){
                  return _createProjectService.isLoading.value ?
                  const CircularProgressIndicator() :
                  CustomButtonIcon(
                    width: _width,
                    height: 40,
                    title: "Create Project",
                    onPressed: (){
                      final selectedSkills = skills.where((skill) => skill["isSelected"] == true).map((skill) => {
                        "label": skill["label"],
                        "id": skill["id"],
                      }).toList();
                      if(selectedSkills.isEmpty) {
                        commonToast(color: Colors.red, message: "Please select at least one skill.");
                        return;
                      }
                      if(validKey.currentState!.validate()){
                        CreateProjectApiServices().createProject(
                            imageFile: _imageFile!,
                            projectName: projectName.text,
                            category: categoryValue.toString(),
                            skills: selectedSkills,
                            startDate: startDate.text,
                            endDate: endDate.text,
                            description: description.text,
                            tagBy: "",
                            context: context
                        ).whenComplete(() {
                          projectName.clear();
                          endDate.clear();
                          startDate.clear();
                        },);
                      }
                    },
                  );
                }),
                SizedBox(height: _height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
  onAddSkillGroup(BuildContext context, Function(List<String>) onSkillsSelected) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                height: 350,
                width: _width,
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Add Skill",style: TextStyles.appBarTitle),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.cancel_outlined,color: Colors.grey,size: 24),
                        ),
                      ],
                    ),
                    SizedBox(height: _height * 0.01),
                    SizedBox(
                      height: 250,
                      child: ListView(
                        children: skills.map((skill) {
                          return CheckboxListTile(
                            title: Text(skill["label"]),
                            value: skill["isSelected"],
                            onChanged: (bool? value) {
                              setState(() {
                                skill["isSelected"] = value!;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: _height * 0.01),
                    Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            List<String> tempSelectedSkills = skills
                                .where((skill) => skill["isSelected"] == true)
                                .map<String>((skill) => skill["label"].toString())
                                .toList();
                            onSkillsSelected(tempSelectedSkills);
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                color: appColor,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: const Text("Ok",style: TextStyle(color: Colors.white,fontSize: 14),)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

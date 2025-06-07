
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../ApiServies/ProjectApi/myProject.dart';
import '../../ApiServies/auth/myProfile_api.dart';
import '../../ApiServies/auth/updateProfile_api.dart';
import '../../Controllers/myProject_controller.dart';
import '../../Model/myProfile_model.dart';
import '../../Routes/routes.dart';
import '../../Utils/commonButton.dart';
import '../../Utils/commonFields.dart';
import '../../Utils/commonStyles.dart';
import '../../Utils/commonToast.dart';
import '../Project/MyProject.dart';
import '../Project/projectDetails.dart';
import 'skill_info.dart';
import 'certificate_screen.dart';

class Myprofile extends StatefulWidget {
  Myprofile({Key? key}) : super(key: key);

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  final double _height = Get.height,_width = Get.width;
  final projectList = Get.put(ProjectApiServices());
  final skillList = Get.put(ProjectApiServices());
  final myCertificateList = Get.put(UpdateProfileApiServices());


  MyProfileData profileData = MyProfileData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }
  load(){
    GetUserDetailsService().getUserDetails().then((value) => {
      setState(() {
        profileData = value.data!;
      })
    });
    setState(() {
      projectList.getMyProjectApi();
      skillList.getMySkillApi();
      myCertificateList.getCertificateApi();
    });
  }

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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color(0xFF0172BD),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(200),
                        bottomLeft: Radius.circular(200))
                ),
                child: Container(
                  height: 220,
                  margin: const EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Color(0xFFF2530A),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(200),
                          bottomLeft: Radius.circular(200))
                  ),
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF7773B),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(200),
                            bottomLeft: Radius.circular(200))
                    ),
                    child: Container(
                      height: 180,
                      margin: const EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF9996C),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(200),
                              bottomLeft: Radius.circular(200))
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: 140,
                        margin: const EdgeInsets.only(bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Color(0xFFFBBB9D),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(200),
                                bottomLeft: Radius.circular(200))
                        ),
                        child: Text("My Profile",style: TextStyles.appBarTitle),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: _height *0.02),
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: "${profileData.prImage}",
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/placeholder.png',
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                  ),
                  fit: BoxFit.cover,
                  height: 70,
                  width: 70,
                ),
              ),
              SizedBox(height: _height *0.01),
              Text(profileData.fullName ?? " ",style: GoogleFonts.manrope(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600)),
              Text(profileData.email ?? " ",style: GoogleFonts.manrope(fontSize: 12,color: Colors.blue,fontWeight: FontWeight.w400)),
              GestureDetector(
                onTap: () {
                  Routes.editPersonalInfoScreen().then((value) => load());
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Icon(Icons.edit,color: Colors.grey,size: 20)
                    ],
                  ),
                ),
              ),
              SizedBox(height: _height *0.03),
              Container(
                width: _width,
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                decoration: BoxDecoration(
                    color: const Color(0xFFFCFCFC),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Personal Information",style: GoogleFonts.manrope(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600)),
                    SizedBox(height: _height *0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("User Name",style: GoogleFonts.manrope(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w300)),
                        Text(profileData.userName ?? "NA",style: GoogleFonts.manrope(fontSize: 12,color: const Color(0xFF999999),fontWeight: FontWeight.w400)),
                      ],
                    ),
                    SizedBox(height: _height *0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date of birth",style: GoogleFonts.manrope(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w300)),
                        Text(profileData.dob ?? "NA",style: GoogleFonts.manrope(fontSize: 12,color: const Color(0xFF999999),fontWeight: FontWeight.w400)),
                      ],
                    ),
                    SizedBox(height: _height *0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("City",style: GoogleFonts.manrope(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w300)),
                        Text(profileData.city ?? "NA",style: GoogleFonts.manrope(fontSize: 12,color: const Color(0xFF999999),fontWeight: FontWeight.w400)),
                      ],
                    ),
                    SizedBox(height: _height *0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Language",style: GoogleFonts.manrope(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w300)),
                        Text(profileData.language ?? "NA",style: GoogleFonts.manrope(fontSize: 12,color: const Color(0xFF999999),fontWeight: FontWeight.w400)),
                      ],
                    ),
                    SizedBox(height: _height *0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Bio",style: GoogleFonts.manrope(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w300)),
                        Flexible(child: Text(profileData.bio ?? "NA",style: GoogleFonts.manrope(fontSize: 12,color: const Color(0xFF999999),fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: _height *0.03),
              Container(
                width: _width,
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                decoration: BoxDecoration(
                    color: const Color(0xFFFCFCFC),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Skills",style: GoogleFonts.manrope(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600)),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => skill_screen())).then((value) => load());
                            },
                            child: const Icon(Icons.edit,color: Color(0xFF999999),size: 20)),
                        const SizedBox(width: 20),
                        GestureDetector(
                            onTap: () {
                              onTapAddSkill(context);
                            },
                            child: const Icon(Icons.add_circle_outline,color: Color(0xFF999999),size: 20)),
                      ],
                    ),
                    skillList.getMySkillList.isEmpty ?
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(child: Text("Add Skills")),
                    ) :
                    ListView.builder(
                      itemCount: skillList.getMySkillList.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = skillList.getMySkillList[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color(0xFFFDDDCE),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          child: Text(data.skillName,style: GoogleFonts.manrope(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w500)),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: _height *0.03),
              Container(
                width: _width,
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                decoration: BoxDecoration(
                    color: const Color(0xFFFCFCFC),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Certifications",style: GoogleFonts.manrope(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600)),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CertificateScreen())).then((value) => load());
                            },
                            child: const Icon(Icons.edit,color: Color(0xFF999999),size: 20)),
                        const SizedBox(width: 20),
                        GestureDetector(
                            onTap: () {
                              onTapAddCertificate(context);
                            },
                            child: const Icon(Icons.add_circle_outline,color: Color(0xFF999999),size: 20)),
                      ],
                    ),
                    myCertificateList.getMyCertificateList.isEmpty ?
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(child: Text("Add Certificates")),
                    ) :
                    ListView.builder(
                      itemCount: myCertificateList.getMyCertificateList.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = myCertificateList.getMyCertificateList[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color(0xFFFDDDCE),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          child: Text(data.certificateName,style: GoogleFonts.manrope(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w500)),
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: _height *0.03),
              projectList.getMyProjectList.isEmpty ?
              const SizedBox() :
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("My Projects",style: TextStyles.cardTitle),
                    GestureDetector(
                      onTap: () {
                        Get.to(myProject_screen());
                        Get.put(MyProjectController());
                      },
                      child: Row(
                        children: [
                          Text("See All ",style: TextStyles.homeSubtitle),
                          const Icon(Icons.arrow_forward_ios,size: 16,color: Color(0xFF999999),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: _height * 0.02),
              projectList.getMyProjectList.isEmpty ?
              const SizedBox() :
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  height: 110,
                  child: ListView.builder(
                    itemCount: projectList.getMyProjectList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = projectList.getMyProjectList[index];
                      // String startDateStr = data.start;
                      // String endDateStr = data.end;
                      // DateTime startDate = DateTime.parse(startDateStr);
                      // DateTime endDate = DateTime.parse(endDateStr);
                      // Duration difference = endDate.difference(startDate);
                      // int daysDifference = difference.inDays;
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => Projectdetails(name: data.projectName,id: "${data.id}"));
                        },
                        child: SizedBox(
                          width: 180,
                          child: Card(
                            color: const Color(0xFFFEEEE7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.projectName,style: TextStyles.title),
                                  SizedBox(height: _height * 0.005),
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
                                        child: const Text("324 Days",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: _height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
  onTapAddCertificate(context) {
    TextEditingController certificateController = TextEditingController();
    final validKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: 230,
            width: _width,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add New Certificates",style: TextStyles.appBarTitle),
                SizedBox(height: _height * 0.02),
                Text("Certificates Name",style: TextStyles.labelStyle),
                SizedBox(height: _height * 0.02),
                Form(
                    key: validKey,
                    child: CommonTextField(
                        inputType: TextInputType.text,
                        validation: (nameValid) {
                          if (nameValid!.isEmpty) {
                            return "Please enter certificate";
                          } else {
                            return null;
                          }
                        },
                        onPressed: () {},
                        cont: certificateController,
                        hintText: "Enter certificate name")),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButtonIcon(
                      width: 80,
                      height: 35,
                      title: "Close",
                      onPressed: () async{
                        Navigator.pop(context);
                      },
                    ),
                    CustomButtonIcon(
                      width: 80,
                      height: 35,
                      title: "Add",
                      onPressed: () async{
                        if(validKey.currentState!.validate()){
                          UpdateProfileApiServices().createCertificateApi(
                              certificate: certificateController.text
                          ).whenComplete((){
                            Navigator.pop(context);
                            load();
                          });
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  onTapAddSkill(BuildContext context) {
    final List<Map<String, dynamic>> skills = [
      {"label": "Animator", "id": "Animator", "isSelected": false},
      { "label": "Game music composer", "id": "Game music composer","isSelected": false },
      { "label": "Graphic designer", "id": "Graphic designer" ,"isSelected": false},
      { "label": "App developer", "id": "App developer" ,"isSelected": false},
      { "label": "Roboticist", "id": "Roboticist" ,"isSelected": false},
      { "label": "System architect", "id": "System architect" ,"isSelected": false},
      { "label": "UX UI designer", "id": "UX UI designer" ,"isSelected": false},
      { "label": "Software developer", "id": "Software developer" ,"isSelected": false},
      { "label": "Other", "id": "Other" ,"isSelected": false}
    ];
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 300,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Add New Skill", style: TextStyles.appBarTitle),
                    const SizedBox(height: 16),
                    Expanded(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButtonIcon(
                          width: 80,
                          height: 35,
                          title: "Close",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CustomButtonIcon(
                          width: 80,
                          height: 35,
                          title: "Add",
                          onPressed: () {
                            final selectedSkills = skills.where((skill) => skill["isSelected"] == true).map((skill) => {
                              "label": skill["label"],
                              "id": skill["id"],
                            }).toList();
                            if (selectedSkills.isEmpty) {
                              commonToast(color: Colors.red, message: "Please select at least one skill.");
                              return;
                            }
                            ProjectApiServices().createSkills(skills: selectedSkills).whenComplete(() {
                              Navigator.pop(context);
                              load();
                            });
                          },
                        ),
                      ],
                    )
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
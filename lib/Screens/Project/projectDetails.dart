
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ApiServies/ProjectApi/projectDetails_api.dart';
import '../../ApiServies/auth/updateProfile_api.dart';
import '../../Model/projectDetailsModal.dart';
import '../../Utils/commonStyles.dart';
import '../../Utils/shared_prefernces.dart';

class Projectdetails extends StatefulWidget {
  String id,name;
  Projectdetails({Key? key,required this.id,required this.name}) : super(key: key);

  @override
  State<Projectdetails> createState() => _ProjectdetailsState();
}

class _ProjectdetailsState extends State<Projectdetails> {

  DataProject projectData = DataProject();
  List<String> labels = [];
  bool loader = false;
  final _getUserDetail = UserLoginDetails();
  String ids = '';
  load()async{
    ids = await   _getUserDetail.getUserData('id');
    ProjectData().projectDetailsApi(id: widget.id).then((value) =>{
      setState(() {
        projectData = value.data!;
        if(projectData.skillsName == null){
        }else{
          String jsonString = "${projectData.skillsName}";
          List<dynamic> jsonData = jsonDecode(jsonString);
          labels = jsonData.map((item) => item['label'] as String).toList();
        }
        loader = true;
      })
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    String text = "$labels";
    String cleanedText = text.replaceAll(RegExp(r'[\[\]]'), '');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.name,style: TextStyles.appBarTitle),
      ),
      body: loader == false ? const Center(child: CircularProgressIndicator()) :
      SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: CachedNetworkImage(
                imageUrl: "http://13.200.129.19:4500/${projectData.logo}",
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/placeholder.png',
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                ),
                fit: BoxFit.fill,
                height: 300,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.note,color: Colors.black,size: 24),
                      const SizedBox(width: 10),
                      Text("Status",style: TextStyles.inder14W800),
                      const Spacer(),
                      Text(projectData.status == null ? "" : "${projectData.status}",style: TextStyles.homeSubtitle),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month,color: Colors.black,size: 24),
                      const SizedBox(width: 10),
                      Text("Timeline",style: TextStyles.inder14W800),
                      const Spacer(),
                      Text(projectData.startDate == null ? "" : "${projectData.startDate}",style: TextStyles.homeSubtitle),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Icon(Icons.bookmark,color: Colors.black,size: 24),
                      const SizedBox(width: 10),
                      Text("Skills",style: TextStyles.inder14W800),
                      const Spacer(),
                      Flexible(child: Text(cleanedText,style: TextStyles.homeSubtitle)),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Icon(Icons.message,color: Colors.black,size: 24),
                      const SizedBox(width: 10),
                      Text("Description",style: TextStyles.inder14W800),
                      const Spacer(),
                      Flexible(child: Text(projectData.description == null ? "" : "${projectData.description}", style: TextStyles.homeSubtitle)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ids == projectData.createdBy.toString() ?
                  const SizedBox() :
                  GestureDetector(
                    onTap: () {
                      UpdateProfileApiServices().interestedProjectApi(
                          projectCreateId: "${projectData.id}",
                          projectId: widget.id,
                      context: context);
                    },
                    child: Container(
                      height: 35,
                      width: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: appColor,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_add_alt_1,size: 24,color: Colors.white),
                          Text(" Interested",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

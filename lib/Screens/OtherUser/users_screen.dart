import 'package:buildthis/Screens/OtherUser/userProfile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../ApiServies/users/all_user_list.dart';
import '../../Controllers/allUser_controller.dart';
import '../../Model/projectModel.dart';
import '../../Utils/commonStyles.dart';
import '../../Utils/commonToast.dart';
import '../../Utils/shared_prefernces.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  AllUserController? _allUserController;

  final double _height = Get.height,_width = Get.width;
  final _getUserDetail = UserLoginDetails();
  int? projectId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ddd();
  }
  String name = '';
  String logo = '';
  Future<void> ddd ()async{
    name = await _getUserDetail.getUserData('name');
    logo = await _getUserDetail.getUserData('logo');
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    _allUserController ??= Get.find<AllUserController>();
    DateTime? lastBackPressed;
    Future<bool> onWillPop() async {
      final now = DateTime.now();
      if (lastBackPressed == null || now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
        lastBackPressed = now;
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
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(name,style: TextStyles.homeTitle),
            leadingWidth: 60,
            leading: Row(
              children: [
                const SizedBox(width: 10),
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: logo.isNotEmpty == true ? logo : 'assets/placeholder.png',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/placeholder.png',
                      fit: BoxFit.cover,
                      width: 45,
                      height: 45,
                    ),
                    fit: BoxFit.cover,
                    height: 45,
                    width: 45,
                  ),
                ),
              ],
            ),
          ),
           body: Column(
             children: [
               SizedBox(height: _height * 0.02),
               Obx(() {
                 return Container(
                   margin: const EdgeInsets.symmetric(horizontal: 30),
                   child: DropdownButtonHideUnderline(
                     child: DropdownButtonFormField<String>(
                       decoration: InputDecoration(
                         isDense: true,
                         contentPadding: const EdgeInsets.all(10),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(4),
                           borderSide: const BorderSide(color: Color(0xFFD6D3D0), width: 1.0),
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(4),
                           borderSide: const BorderSide(color: Color(0xFFD6D3D0), width: 1.0),
                         ),
                         filled: true,
                         fillColor: Colors.white,
                         hintText: "",
                         hintStyle: TextStyles.hintStyle,
                         border: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey), gapPadding: 0),
                       ),
                       value: _allUserController!.categoryValue.value,
                       hint: Padding(
                         padding: const EdgeInsets.only(left: 0.0),
                         child: Text('Select Project', style: TextStyles.hintStyle),
                       ),
                       icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
                       isExpanded: true,
                       onChanged: (String? newValue) {
                         _allUserController!.categoryValue.value = newValue;
                         var selectedProject = _allUserController!.projectList.getMyProjectList.firstWhere(
                                 (project) => project.projectName == newValue,
                             orElse: () => MyProjectModel(projectName: '', id: 0, status: ''));
                         _allUserController!.assignProjectListByUser.assignProjectAllUserApi(
                           id: selectedProject.id,
                         );
                         projectId = selectedProject.id;
                       },
                       items: _allUserController!.projectList.getMyProjectList
                           .map<DropdownMenuItem<String>>((MyProjectModel project) {
                         return DropdownMenuItem<String>(
                           value: project.projectName, // Display the project name
                           child: Padding(
                             padding: const EdgeInsets.only(left: 8.0),
                             child: Text(project.projectName, style: TextStyles.fillStyle), // Display the project name
                           ),
                         );
                       }).toList(),
                     ),
                   ),
                 );
               }),
               SizedBox(height: _height * 0.02),
               GestureDetector(
                 onTap: () {
                   if(_allUserController!.categoryValue.value == null){
                     commonToast(color: appColor,message: "Please Select Project");
                     return;
                   }
                   if(_allUserController!.selectedIndexes.isEmpty){
                     commonToast(color: appColor,message: "Please Select User");
                     return;
                   }
                   List<Map<String, dynamic>> selectedData = _allUserController!.selectedIndexes.map((index) => {
                     "id": _allUserController!.allUserList.getAllStateList[index].id,
                     "label": _allUserController!.allUserList.getAllStateList[index].fullName,
                     "profile": _allUserController!.allUserList.getAllStateList[index].prImage,
                     "skill_names": _allUserController!.allUserList.getAllStateList[index].skillNames,
                   }).toList();
                   AllUserApiServices().createInviteProjectApi(
                       body: selectedData,
                       projectId: projectId.toString(),
                       context: context);
                 },
                 child: Container(
                   height: 40,
                   width: _width,
                   alignment: Alignment.center,
                   margin: const EdgeInsets.symmetric(horizontal: 30),
                   decoration: BoxDecoration(
                       color: Colors.blue,
                       borderRadius: BorderRadius.circular(5)
                   ),
                   child: const Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(Icons.person_add_alt_1,size: 24,color: Colors.white),
                       Text(" Invite",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500))
                     ],
                   ),
                 ),
               ),
               SizedBox(height: _height * 0.02),
               Container(
                   width: _width,
                   height: 450,
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
                         child: Obx(() {
                           if (_allUserController!.allUserList.isLoading.value) {
                             return const Center(child: CircularProgressIndicator());
                           }
                           if (_allUserController!.allUserList.getAllStateList.isEmpty) {
                             return const Center(child: Text("No users found."));
                           }
                           return ListView.builder(
                             itemCount: _allUserController!.allUserList.getAllStateList.length,
                             shrinkWrap: true,
                             physics: const ScrollPhysics(),
                             itemBuilder: (context, index) {
                               var data = _allUserController!.allUserList.getAllStateList[index];
                               bool isSelected = _allUserController!.selectedIndexes.contains(index);
                               var userData;
                               if (_allUserController!.assignProjectListByUser.getAssignAllProjectList.isNotEmpty && index < _allUserController!.assignProjectListByUser.getAssignAllProjectList.length) {
                                 userData = _allUserController!.assignProjectListByUser.getAssignAllProjectList[index];
                               }
                               if (_allUserController!.assignProjectListByUser.getAssignAllProjectList.isEmpty || userData == null || userData.userId.toString() == data.id.toString()) {
                                 return Container(
                                   padding: const EdgeInsets.symmetric(vertical: 5),
                                   margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     color: Colors.white,
                                   ),
                                   child: ListTile(
                                     contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                     title: Text(
                                       data.fullName,
                                       style: GoogleFonts.manrope(
                                           fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
                                     ),
                                     subtitle: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text("Skill: ${data.skillNames}",
                                             style: GoogleFonts.manrope(
                                                 fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400)),
                                       ],
                                     ),
                                     leading: ClipOval(
                                       child: CachedNetworkImage(
                                         imageUrl: data.prImage,
                                         placeholder: (context, url) => const Center(
                                           child: CircularProgressIndicator(),
                                         ),
                                         errorWidget: (context, url, error) => Image.asset(
                                           'assets/placeholder.png',
                                           fit: BoxFit.cover,
                                           width: 50,
                                           height: 50,
                                         ),
                                         fit: BoxFit.cover,
                                         height: 50,
                                         width: 50,
                                       ),
                                     ),
                                     trailing: Checkbox(
                                       value: isSelected,
                                       onChanged: (bool? isChecked) {
                                         setState(() {
                                           if (isChecked == true) {
                                             _allUserController!.selectedIndexes.add(index);
                                           } else {
                                             _allUserController!.selectedIndexes.remove(index);
                                           }
                                         });
                                       },
                                     ),
                                     onTap: () {
                                       Get.to(() => UserProfileScreen(id: data.id.toString()))!.then((_) {
                                         _allUserController!.searchController.clear();
                                         _allUserController!.resetUserList();
                                       });
                                     },
                                   ),
                                 );
                               } else {
                                 return const SizedBox();
                               }
                             },
                           );
                         }),
                       )
                     ],
                   ))
             ],
           ),
        ),
      ),
    );
  }

}

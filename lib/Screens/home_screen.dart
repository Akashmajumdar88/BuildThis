import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/allProject_controller.dart';
import '../Controllers/home_controller.dart';
import '../Controllers/myProject_controller.dart';
import '../Utils/commonStyles.dart';
import '../Utils/drawerUI.dart';
import '../Utils/shared_prefernces.dart';
import 'Project/MyProject.dart';
import 'Project/projectDetails.dart';
import 'Project/view_all_Projects.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController? _homeController;
  final _getUserDetail = UserLoginDetails();
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
    _homeController ??= Get.find<HomeController>();
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
    final double _height = Get.height,_width = Get.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(name,style: TextStyles.homeTitle),
            leadingWidth: 95,
            leading: Row(
              children: [
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(Icons.menu,color: Colors.black,size: 30),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                    );
                  },
                ),
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: logo.isNotEmpty == true ? logo : 'assets/placeholder.png',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/placeholder.png',
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                    ),
                    fit: BoxFit.cover,
                    height: 40,
                    width: 40,
                  ),
                ),
              ],
            ),
          ),
          drawer: MyDrawer().getDrawer(context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: _height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _homeController!.searchController,
                    onChanged: (value) {
                      _homeController!.filterUsers(value);
                      _homeController!.filterAllProjectData(value);
                    },
                    onEditingComplete: () {
                      _homeController!.resetUserList();
                      _homeController!.resetAllProjectList();
                      _homeController!.searchController.clear();
                    },
                    decoration:InputDecoration(
                      hintText: "Search Project",
                      hintStyle: TextStyles.hintStyle,
                      fillColor: const Color(0xFFF9F9F9),
                      filled: true,
                      prefixIcon: const Icon(Icons.search_rounded,color: Color(0xFF999999),size: 20),
                      contentPadding: const EdgeInsets.all(14.0),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Color(0xFFF9F9F9), width: 0.4)),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFF9F9F9), width: 0.4),
                          borderRadius: BorderRadius.circular(4.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFF9F9F9), width: 0.4),
                          borderRadius: BorderRadius.circular(4.0)),
                    ),
                  ),
                ),
                SizedBox(height: _height * 0.02),
                Obx((){
                  if (_homeController!.filteredMyProjectList.isEmpty) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("My Projects",style: TextStyles.cardTitle),
                        InkWell(
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
                  );
                }),
                SizedBox(height: _height * 0.02),
                Obx((){
                  if (_homeController!.filteredMyProjectList.isEmpty) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      height: 130,
                      child: Obx((){
                        if (_homeController!.myProjectList.isLoading.value) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (_homeController!.filteredMyProjectList.isEmpty) {
                          return const SizedBox();
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _homeController!.filteredMyProjectList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = _homeController!.filteredMyProjectList[index];
                            String startDateStr = data.start;
                            String endDateStr = data.end;
                            DateTime startDate = DateTime.parse(startDateStr);
                            DateTime endDate = DateTime.parse(endDateStr);
                            Duration difference = endDate.difference(startDate);
                            int daysDifference = difference.inDays;
                            return InkWell(
                              onTap: () {
                                Get.to(() => Projectdetails(id: data.id.toString(),name: data.name.toString()))!.then((_) {
                                  _homeController!.resetUserList();
                                  _homeController!.resetAllProjectList();
                                  _homeController!.searchController.clear();
                                });
                              },
                              child: SizedBox(
                                width: 200,
                                child: Card(
                                  color: const Color(0xFFFEEEE7),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(child: Text(data.name,style: TextStyles.cardTitle)),
                                            ClipOval(
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
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  );
                }),
                SizedBox(height: _height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Projects",style: TextStyles.cardTitle),
                      InkWell(
                        onTap: () {
                          Get.to(ShowAllProjects());
                          Get.put(AllProjectController());
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
                Container(
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
                      Obx((){
                        if (_homeController!.allProjectList.isLoading.value) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (_homeController!.filteredAllProjectList.isEmpty) {
                          return const Center(child: Text("No projects available."));
                        }
                        return ListView.builder(
                          itemCount: _homeController!.filteredAllProjectList.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = _homeController!.filteredAllProjectList[index];
                            String startDateStr = data.start;
                            String endDateStr = data.end;
                            DateTime startDate = DateTime.parse(startDateStr);
                            DateTime endDate = DateTime.parse(endDateStr);
                            Duration difference = endDate.difference(startDate);
                            int daysDifference = difference.inDays;
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => Projectdetails(id: data.id.toString(),name: data.name.toString()))!.then((_) {
                                  _homeController!.resetUserList();
                                  _homeController!.resetAllProjectList();
                                  _homeController!.searchController.clear();
                                });
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
                                        ClipOval(
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
                                          child:  Text(data.status,style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500)),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../ApiServies/ProjectApi/myProject.dart';
import '../../ApiServies/users/all_user_list.dart';
import '../../Utils/commonFields.dart';
import '../../Utils/commonStyles.dart';
import '../../Utils/shared_prefernces.dart';
import 'chatDetails_screen.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin{
  final double _height = Get.height,_width = Get.width;
  final _getUserDetail = UserLoginDetails();
  final projectList = Get.put(ProjectApiServices());
  final allUserList = Get.put(AllUserApiServices());
  TextEditingController searchController = TextEditingController();
  String name = '';
  String logo = '';
  String userId = '';
  late TabController _tabController;
  Future<void> ddd ()async{
    name = await _getUserDetail.getUserData('name');
    logo = await _getUserDetail.getUserData('logo');
    userId = await _getUserDetail.getUserData('id');
    projectList.getMyProjectApi();
    allUserList.getAllUserApi();
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ddd();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

  Future<void> addUserIfNotExists(String uid, String name,String url) async {
    try {
      DocumentReference userRef = FirebaseFirestore.instance.collection("userChats").doc("$userId,buildThis");
      DocumentSnapshot userSnapshot = await userRef.get();
      // if (userSnapshot.exists) {
      //   print("User already exists in the database!");
      // } else {
        await userRef.set({
          "uid": uid,
          "displayName": name,
          "photoURL": url,
          "date": FieldValue.serverTimestamp(),
        });
        print("User added successfully!");
      // }
    } catch (e) {
      print("Error adding user: $e");
    }
  }

  void addUserToUserChats(String newUserId, String newUserName, String? newUserPhotoUrl) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<String> ids = [userId, newUserId];
    ids.sort();
    String combinedId = "${ids[0]},${ids[1]}";
    DocumentReference userChatDoc = firestore.collection('userChats').doc(newUserId);
    Map<String, dynamic> newUserData = {
      "uid": newUserId,
      "displayName": newUserName,
      "photoURL": newUserPhotoUrl ?? null,
      "date": DateTime.now().millisecondsSinceEpoch,
    };

    userChatDoc.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        // If the document exists, update it by adding the new user info
        userChatDoc.update({
          "userInfo": FieldValue.arrayUnion([newUserData])
        }).then((_) {
          print("User added successfully!");
        }).catchError((error) {
          print("Error adding user: $error");
        });
      } else {
        // If the document doesn't exist, create it
        userChatDoc.set({
          "combinedId": combinedId,
          "userInfo": [newUserData]
        }).then((_) {
          print("New chat document created and user added!");
        }).catchError((error) {
          print("Error creating document: $error");
        });
      }
    });
  }


  // void addUserIfNotExists(String uid, String name,String url) async {
  //   final time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  //   await FirebaseFirestore.instance.collection('userChats').doc("$userId,buildThis").update({
  //     'userInfo': FieldValue.arrayUnion([
  //       {
  //         'uid': uid,
  //         'displayName': name,
  //         'photoURL': url,
  //         'date': time,
  //       }
  //     ])
  //   });
  // }

  String? selectedUserId;
  String? selectedUserName;
  String? selectedUserUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
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
            bottom: TabBar(
              controller: _tabController,
              unselectedLabelStyle: const TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 14),
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: [
                Container(
                  decoration: BoxDecoration(
                      color: _tabController.index == 0 ? Colors.green : Colors.blue,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Tab(
                      child: SizedBox(
                        width: _width /2,
                        child: const Tab(child: Text("People")),
                      )
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: _tabController.index == 1 ? Colors.green : Colors.blue,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Tab(
                      child: SizedBox(
                        width: _width /2 ,
                        child: const Tab(child: Text("Projects")),
                      )
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: _height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.trim().isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        return allUserList.getAllStateList
                            .map((e) => e.fullName.toString()) // Assuming 'fullName' is the display name
                            .where((String option) {
                          return option.toLowerCase().contains(textEditingValue.text.trim().toLowerCase());
                        });
                      },
                      onSelected: (String value) {
                        final selectedUser = allUserList.getAllStateList.firstWhere(
                              (user) => user.fullName.toString() == value,
                        );

                        if (selectedUser != null) {
                          setState(() {
                            selectedUserId = selectedUser.id.toString(); // Assuming 'id' is the user's ID
                            selectedUserName = selectedUser.fullName.toString();
                            selectedUserUrl = selectedUser.prImage.toString(); // Assuming 'url' is the user's profile URL
                          });
                          addUserIfNotExists(selectedUserId!, selectedUserName!, selectedUserUrl!);
                        }
                      },
                      fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                        return TextField(
                          controller: fieldTextEditingController,
                          focusNode: focusNode,
                          onEditingComplete: () {
                            fieldTextEditingController.clear();
                          },
                          decoration: InputDecoration(
                            hintText: 'Search User',
                            prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF999999), size: 20),
                            contentPadding: const EdgeInsets.all(14.0),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(color: Color(0xFFF9F9F9), width: 0.4),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFFF9F9F9), width: 0.4),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xFFF9F9F9), width: 0.4),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                        );
                      },
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
                            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection('userChats')
                                    .doc("$userId,buildThis") // Change this dynamically based on the user
                                    .snapshots(),
                                builder: (context, snapshot){
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                  if (!snapshot.hasData || !snapshot.data!.exists) {
                                    return const Center(child: Text("No chats found"));
                                  }
                                  var data = snapshot.data!.data();
                                  if (data == null || !data.containsKey('userInfo')) {
                                    return const Center(child: Text("No user data available"));
                                  }
                                  var userInfoList = data['userInfo'] as List<dynamic>;
                                  return ListView.builder(
                                    itemCount: userInfoList.length,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var data = userInfoList[index];
                                      return userId == data['uid'].toString() ?
                                      const SizedBox() :
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                                        child: ListTile(
                                          title: Text("${data['displayName']}",style: TextStyles.inder12W700),
                                          leading: ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl: logo.isNotEmpty == true ? "${data['photoURL']}" : 'assets/placeholder.png',
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
                                          onTap: () {
                                            Get.to(ChatDetailsScreen(
                                              name: data['displayName'],
                                              userId: userId,
                                              senderId: data['uid'].toString(),
                                              imageUrl: "${data['photoURL']}",
                                              myImage: logo,
                                            ));
                                          },
                                        ),
                                      );
                                    },
                                  );
                                }
                            ),
                          ],
                        )
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: _height * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text("Search User",style: TextStyles.cardTitle),
                    ),
                    SizedBox(height: _height * 0.01),
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
                            ListView.builder(
                              itemCount: 1,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                                  child: ListTile(
                                    title: Text("Haley James",style: TextStyles.inder12W700),
                                    subtitle: Text("Stand up for what you believe in",style: TextStyles.inder12W400),
                                    leading: Container(
                                      height: 35,
                                      width: 35,
                                      alignment: Alignment.bottomCenter,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: appColor
                                      ),
                                      child: const Icon(Icons.person,color: Colors.white,size: 30),
                                    ),
                                    onTap: () {
                                      // Get.to(ChatDetailsScreen(name: "akash",));
                                    },
                                  ),
                                );
                              },),
                          ],
                        )
                    )
                  ],
                ),
              )
            ],
          ),
          floatingActionButton: GestureDetector(
            onTap: () {
              onAddNewGroup(context);
            },
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              child: Icon(Icons.add,color: Colors.white,size: 24),
            ),
          ),
        ),
      ),
    );
  }
  onAddNewGroup(context) {
    TextEditingController nameController = TextEditingController();
    ImagePicker picker = ImagePicker();
    String? categoryValue;
    showDialog(
      context: context,
      builder: (context) {
        File? imageFile;
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                height: 350,
                width: _width,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Create Group",style: TextStyles.appBarTitle),
                    SizedBox(height: _height * 0.01),
                    DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: Container(
                          height: 60,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: imageFile == null ?
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
                                                  imageFile = File(pickedFile.path);
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
                                                imageFile = File(pickedFile.path);
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
                              child: Image.file(File(imageFile!.path),height: 60,fit: BoxFit.fill,width: 80)),
                        )
                    ),
                    SizedBox(height: _height * 0.01),
                    Text("Project Name",style: TextStyles.labelStyle),
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
                            hintText: "Select project name",
                            hintStyle:  TextStyles.hintStyle,
                            border: const OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey),gapPadding: 0)
                        ),
                        value: categoryValue,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Select project name';
                          }
                          return null;
                        },
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text('Project Name',style: TextStyles.hintStyle
                          ),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down_sharp,color: Colors.grey,),
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          categoryValue = newValue;
                        },
                        items: projectList.getMyProjectList.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value.projectName,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(value.projectName,
                                  style: TextStyles.fillStyle
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: _height * 0.01),
                    Text("Group Name",style: TextStyles.labelStyle),
                    CommonTextField(
                        inputType: TextInputType.text,
                        validation: (nameValid) {
                          if (nameValid!.isEmpty) {
                            return "Please enter group name";
                          } else {
                            return null;
                          }
                        },
                        onPressed: () {},
                        cont: nameController,
                        hintText: "Enter group name"),
                    SizedBox(height: _height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blue,width: 0.5),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: const Text("Close",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500,fontSize: 14)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: const Text("Create",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14)),
                          ),
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
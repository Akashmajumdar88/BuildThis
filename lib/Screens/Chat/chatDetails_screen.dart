
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../Utils/commonStyles.dart';

class ChatDetailsScreen extends StatefulWidget {
  String name,userId,senderId,imageUrl,myImage;
  ChatDetailsScreen({Key? key,
    required this.name,
    required this.userId,
    required this.senderId,
    required this.imageUrl,
    required this.myImage
  }) : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final double _height = Get.height,_width = Get.width;
  final TextEditingController messageController = TextEditingController();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  void handleSend(String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final uuid = const Uuid().v4();
    await FirebaseFirestore.instance.collection('chats').doc(getChatDocumentId(widget.userId, widget.senderId)).update({
          'messages': FieldValue.arrayUnion([
            {
              'id': uuid,
              'text': msg,
              'senderId': widget.userId,
              'date': time,
              'seen': false,
            }
          ])
        });
    messageController.clear();
  }

  String getChatDocumentId(String userId1, String userId2) {
    return int.parse(userId1) > int.parse(userId2)
        ? '$userId1,$userId2'
        : '$userId2,$userId1';
  }

  String getTimeFromTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return "${dateTime.hour}:${dateTime.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFFD9D9D9),
                    child: Icon(Icons.arrow_back,color: Colors.black,size: 20),
                  ),
                ),
                Text(widget.name,style: TextStyles.inder14W800),
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl.isNotEmpty == true ? widget.imageUrl : 'assets/placeholder.png',
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
                )
              ],
            ),
          ),
          SizedBox(height: _height * 0.03),
          Expanded(
            child: Container(
              width: _width,
              padding: const EdgeInsets.only(bottom: 35),
              decoration: const BoxDecoration(
                  color: Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)
                  )
              ),
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: _fireStore.collection('chats').
                  doc(getChatDocumentId(widget.userId, widget.senderId)).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Center(child: Text("No chats found"));
                    }
                    var data = snapshot.data!.data();
                    if (data == null || !data.containsKey('messages')) {
                      return const Center(child: Text("No user data available"));
                    }
                    var userInfoList = data['messages'];
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: userInfoList.length,
                      itemBuilder: (context, index) {
                        final msg = userInfoList[index];
                        String time = getTimeFromTimestamp(msg['date']);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            widget.userId.toString() == msg['senderId'].toString() ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                        decoration: const BoxDecoration(
                                          color:  Color(0xFFF7773B),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                          ),
                                        ),
                                        child: Text("${msg['text']}",style: GoogleFonts.inder(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400)),
                                      ),
                                    ),
                                    Text(time, style: GoogleFonts.inder(color: Colors.black,fontSize: 10,fontWeight: FontWeight.w400)),
                                  ],
                                ),
                                const SizedBox(width: 10.0),
                                ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: widget.myImage.isNotEmpty == true ? widget.myImage : 'assets/placeholder.png',
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
                            ) :
                            const SizedBox(),
                            const SizedBox(height: 10),
                            widget.userId.toString() != msg['senderId'].toString() ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: widget.imageUrl.isNotEmpty == true ? widget.imageUrl : 'assets/placeholder.png',
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
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFECECEC),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15)
                                        ),
                                      ),
                                      child: Text("${msg['text']}",style: GoogleFonts.inder(color: const Color(0xFF1F2024),fontSize: 14,fontWeight: FontWeight.w400)),
                                    ),
                                    Text(time, style: GoogleFonts.inder(color: Colors.black,fontSize: 10,fontWeight: FontWeight.w400)),
                                  ],
                                )
                              ],
                            ) :
                            const SizedBox(),
                          ],
                        );
                      },);
                  },),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 40,
        width: _width,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.zero)
        ),
        child: Row(
          children: [
            const SizedBox(width: 10.0),
            Flexible(
              child: TextFormField(
                controller: messageController,
                style: TextStyles.fillStyle,
                decoration:InputDecoration(
                  hintText: "Type a message",
                  focusColor: const Color(0xFFF8F9FE),
                  hintStyle: TextStyles.hintStyle,
                  contentPadding: const EdgeInsets.all(10.0),
                  focusedBorder:  OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: backgroundColor)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: backgroundColor),
                      borderRadius: BorderRadius.circular(25.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: backgroundColor),
                      borderRadius: BorderRadius.circular(25.0)),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            InkWell(
              onTap: () {
                if(messageController.text.isNotEmpty){
                  handleSend(messageController.text);
                }
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: appColor,
                child: Icon(Icons.send,size: 20,color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

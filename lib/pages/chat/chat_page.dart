import 'package:fends_mobile/constants/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatelessWidget {
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        bottomOpacity: 0.5,
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
        title: _avatar(),
        // backgroundColor: Color(0xFFFFFFFF),
        leading: InkWell(
          onTap: () {}, //TODO: chuyen ve trang truoc do
          child: Icon(
            Icons.arrow_back,
            size: 35,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SizedBox(
        // height: MediaQuery.of(context).size.height - 200,
        width: screenWidth,
        child: Column(
          children: [
            Expanded(child: _chatList()),
            chatInputField(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget chatInputField() {
    return Center(
      child: Container(
        width: screenWidth,
        padding: const EdgeInsets.only(top: 5, left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              color: Color(0xFF444444),
              size: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                // width: 270 * screenWidth / 360,
                height: 50,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF1F1F1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.only(top: 3, left: 20),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Soạn tin nhắn",
                      ),
                      style: TextStyle(
                        color: Color(0xFF7C7C7C),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0.05,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const MaterialButton(
              padding: EdgeInsets.all(0.0),
              height: 45,
              onPressed: sendMessage,
              shape: CircleBorder(),
              color: Color(0xFFF2F9A1),
              child: Icon(
                Icons.send,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _chatList() {
    return ListView(children: isUser.map((e) => _chatItem(e)).toList());
  }

  final List<bool> isUser = [
    true,
    false,
    true,
    true,
    false,
    false,
    true,
    true,
    false,
    false,
    true,
    true,
    false
  ];

  Widget _chatItem(bool isUser) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (isUser)
            ChatBubble(
              message: 'Đây là trang tin nhắn',
              isUser: isUser,
            )
          else
            Row(
              children: [
                CircleAvatar(
                  radius: 21.0,
                  backgroundImage: NetworkImage(
                      "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?t=st=1710694790~exp=1710698390~hmac=ed25e3a0b39a650a48df120fe1c0d96708187933aaee78f558b547bdb0845df9&w=740"),
                ),
                SizedBox(
                  width: 10,
                ),
                ChatBubble(
                  message: 'Đây là trang tin nhắn',
                  isUser: isUser,
                ),
              ],
            ),
          const SizedBox(
            height: 5,
          ),
          Text(
              textAlign: TextAlign.start,
              // Thời gian gửi,
              "11:30"),
        ],
      ),
    );
  }

  Widget _avatar() {
    return Container(
      width: screenWidth,
      alignment: Alignment.centerLeft,
      child: Row(children: [
        CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(
              "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?t=st=1710694790~exp=1710698390~hmac=ed25e3a0b39a650a48df120fe1c0d96708187933aaee78f558b547bdb0845df9&w=740"),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          'Warren',
          style: TextStyle(
            color: Color(0xFF3D003E),
            fontSize: 24,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ]),
    );
  }
}

void sendMessage() async {
  //TODO: sendMessage Controller
}

class ChatBubble extends StatelessWidget {
  final String message;
  bool isUser;
  ChatBubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 5,
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          color: isUser ? const Color(0xFFF2F9A1) : const Color(0xFFD9D9D9),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

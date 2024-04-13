import 'package:fends_mobile/networks/user_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../app_config.dart';
import '../../models/user.dart';

class UpdateInfoPage extends StatefulWidget {
  late User user;
  Function() callback;
  UpdateInfoPage({super.key, required this.user, required this.callback});
  @override
  State<UpdateInfoPage> createState() => _UpdateInfoPageState();
}

class _UpdateInfoPageState extends State<UpdateInfoPage> {
  late double screenWidth;
  late double screenHeight;
  int _page = 1;

  late TextEditingController _fullnameController =
      TextEditingController(text: widget.user.full_name.toString());

  late TextEditingController _emailController =
      TextEditingController(text: widget.user.email);
  late TextEditingController _phoneController =
      TextEditingController(text: widget.user.phone);

  late DateTime _birthdayController = widget.user.birthday ?? DateTime.now();
  late String? _isFemaleController = widget.user!.is_female != null
      ? (widget.user!.is_female! ? 'Nữ' : 'Nam')
      : null;

  late TextEditingController _oldPasswordController = TextEditingController();
  late TextEditingController _newPasswordController = TextEditingController();
  late TextEditingController _renewPasswordController = TextEditingController();

  late XFile? _image = null;

  @override
  void initState() {
    super.initState();
    _image = null;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xFFEEE8DA),
        appBar: headerForDetail("Tài khoản"),
        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              _page = 1;
                            });
                          },
                          child: _tabItem("Thông tin", _page == 1)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              _page = 2;
                            });
                          },
                          child: _tabItem("Mật khẩu", _page == 2)),
                    ],
                  ),
                ),
                _page == 1 ? _updateInfo() : _updatePassword()
              ],
            ),
          ),
        ));
  }

  Widget _tabItem(String title, bool isChoice) {
    return Container(
      width: 130,
      padding: EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: isChoice ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFF939393)),
          borderRadius: title == "Thông tin"
              ? BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: !isChoice ? Colors.black : Colors.white,
          fontSize: 16,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          height: 0,
        ),
      ),
    );
  }

  Widget _updateInfo() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(child: _avatarPicker()),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              'Họ và tên',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: TextFormField(
              controller: _fullnameController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFFC3C3C3))),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xFFC3C3C3)),
                  )),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              'Email',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFFC3C3C3))),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xFFC3C3C3)),
                  )),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              'Số điện thoại',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFFC3C3C3))),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xFFC3C3C3)),
                  )),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              'Ngày sinh',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: TextFormField(
              controller: TextEditingController(
                text:
                    "${_birthdayController?.day}/${_birthdayController?.month}/${_birthdayController?.year}",
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xFFC3C3C3))),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xFFC3C3C3)),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              'Giới tính',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          genderContainerState(),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () async {
              var success = await UserRequest.updateUser(
                _fullnameController.text,
                _birthdayController,
                _isFemaleController.toString(),
                _emailController.text,
                _phoneController.text,
                src: _image,
              );

              if (success && context.mounted) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shadowColor: Colors.grey[300],
                      alignment: Alignment.center,
                      content: Text(
                        "Chỉnh sửa thông tin thành công",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    );
                  },
                );
                Future.delayed(Duration(seconds: 1), () {
                  widget.callback();
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              }
            },
            child: Container(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: Row(children: [Expanded(child: _submitButton())])),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Stack _avatarPicker() {
    return Stack(
      children: [
        _image == null
            ? Container(
                width: 150,
                height: 150,
                child: widget.user.avatar != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(
                            "${AppConfig.IMAGE_API_URL}${widget.user.avatar as String}"),
                      )
                    : CircleAvatar())
            : Container(
                width: 150,
                height: 150,
                child: CircleAvatar(
                  backgroundImage: FileImage(File(_image!.path)),
                ),
              ),
        Positioned(
          top: 1,
          right: 1,
          child: Container(
            child: IconButton(
              icon: Icon(Icons.add_a_photo, color: Colors.black),
              onPressed: () {
                _pickImage(ImageSource.gallery);
              },
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    50,
                  ),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 4),
                    color: Colors.black.withOpacity(
                      0.3,
                    ),
                    blurRadius: 3,
                  ),
                ]),
          ),
        ),
      ],
    );
  }

  Widget _updatePassword() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              'Đổi mật khẩu',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              'Mật khẩu hiện tại',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: TextFormField(
              controller: _oldPasswordController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFFC3C3C3))),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xFFC3C3C3)),
                  )),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              'Mật khẩu mới',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFFC3C3C3))),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xFFC3C3C3)),
                  )),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              'Nhập lại mật khẩu mới',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: TextFormField(
              controller: _renewPasswordController,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFFC3C3C3))),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xFFC3C3C3)),
                  )),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Row(children: [Expanded(child: _submitButton())])),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(color: Colors.black),
      child: Text(
        'Lưu',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
          height: 0,
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _birthdayController,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _birthdayController) {
      setState(() {
        _birthdayController = pickedDate;
      });
    }
  }

  void _pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    _image = (await _imagePicker.pickImage(source: source))!;
    setState(() {});
  }

  Widget genderContainerState() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFC3C3C3)),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: RadioListTile<String>(
                title: const Text('Nam'),
                value: 'Nam',
                groupValue: _isFemaleController,
                onChanged: (String? value) {
                  setState(() {
                    _isFemaleController = value!;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFC3C3C3)),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: RadioListTile<String>(
                title: const Text('Nữ'),
                value: 'Nữ',
                groupValue: _isFemaleController,
                onChanged: (String? value) {
                  setState(() {
                    _isFemaleController = value!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar headerForDetail([String? title]) {
    return AppBar(
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new)),
      backgroundColor: Color(0xFFEEE8DA),
      centerTitle: true,
      title: title != null
          ? Text(
              title ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            )
          : const SizedBox(),
    );
  }
}

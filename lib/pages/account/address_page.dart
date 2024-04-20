import 'package:fends_mobile/models/address.dart';
import 'package:fends_mobile/networks/address_request.dart';
import 'package:fends_mobile/networks/user_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../app_config.dart';
import '../../models/user.dart';

class AddressPage extends StatefulWidget {
  late User user;

  AddressPage({super.key, required this.user});
  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  late double screenWidth;
  late double screenHeight;
  late List<Address> addresses;
  bool isLoading = true;
  int _page = 1;

  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  Future<void> _getAddresses() async {
    addresses = await AddressRequset.getAddresses();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xFFEEE8DA),
        appBar: headerForDetail("Tài khoản"),
        body: isLoading
            ? Center(
                child: Container(
                    width: 50, height: 50, child: CircularProgressIndicator()))
            : Container(
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
                                child: _tabItem("Sẵn có", _page == 1)),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    _page = 2;
                                  });
                                },
                                child: _tabItem("Tạo mới", _page == 2)),
                          ],
                        ),
                      ),
                      _page == 1 ? _addressList() : _newAddress()
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

  Widget _addressCard(Address address) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.5, color: Color(0xFF9E9E9E)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "${widget.user.full_name}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      address.address.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${widget.user.phone}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }

  Widget _addressList() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: addresses.map((e) => _addressCard(e)).toList(),
      ),
    );
  }

  Widget _newAddress() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              'Tỉnh, Thành Phố',
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
              controller: _provinceController,
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
              'Quận, Huyện',
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
              controller: _districtController,
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
              'Xã, Phường',
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
              controller: _villageController,
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
              'Chú thích',
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
              controller: _noteController,
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
            height: 50,
          ),
          Container(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Row(children: [
                Expanded(
                    child: InkWell(
                        onTap: () async {
                          if (_isValid()) {
                            String address =
                                "${_provinceController.text}, ${_districtController.text}, ${_villageController.text} \n${_noteController.text}";

                            var success =
                                await AddressRequset.addAddress(address);
                            if (success && context.mounted) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shadowColor: Colors.grey[300],
                                    alignment: Alignment.center,
                                    content: Text(
                                      "Thêm địa chỉ thành công",
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
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shadowColor: Colors.grey[300],
                                  alignment: Alignment.center,
                                  content: Text(
                                    "Vui lòng nhập đủ thông tin.",
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
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: _submitButton()))
              ])),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  bool _isValid() {
    return _provinceController.text.isNotEmpty &&
        _districtController.text.isNotEmpty &&
        _villageController.text.isNotEmpty &&
        _noteController.text.isNotEmpty;
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

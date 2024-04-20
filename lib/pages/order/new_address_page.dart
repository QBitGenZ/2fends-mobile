import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../networks/address_request.dart';

class NewAddressPage extends StatefulWidget {
  const NewAddressPage({super.key});

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: headerForDetail("Thêm địa chỉ mới"),
        body: SingleChildScrollView(
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
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFC3C3C3)),
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
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFC3C3C3)),
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
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFC3C3C3)),
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
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFC3C3C3)),
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
        ));
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
      backgroundColor: Colors.white,
      centerTitle: true,
      title: title != null
          ? Text(
              title,
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

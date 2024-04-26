import 'dart:io';

import 'package:fends_mobile/networks/event_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../models/event.dart';
import '../../models/product_type.dart';
import '../../networks/product_request.dart';
import '../index.dart';

class EditDonationEventPage extends StatefulWidget {
  final MyEvent event;
  const EditDonationEventPage({super.key, required this.event});

  @override
  State<EditDonationEventPage> createState() =>
      _EditDonationEventPageState();
}

class _EditDonationEventPageState extends State<EditDonationEventPage> {
  late double screenHeight;
  late double screenWidth;
  var _page;
  late bool isLoading = true;
  bool _eventSubmitted = false;
  late TextEditingController _eventNameController = TextEditingController(text: widget.event.name.toString());
  late DateTime _eventStartTimeController = DateTime.parse(widget.event.beginAt.toString());
  late DateTime _eventEndTimeController = DateTime.parse(widget.event.endAt.toString());
  late TextEditingController _eventDescriptionController =
  TextEditingController(text: widget.event.description.toString());
  late List<String> _listProductTypeController;
  late XFile? images = null;

  @override
  void initState() {
    super.initState();
    _page = 1;
    _listProductTypeController = [];
  }

  // void _initController


  Future<bool> updateEvent() async {
    var event = MyEvent(
      id: widget.event.id,
      name: _eventNameController.text,
      description: _eventDescriptionController.text,
      beginAt: DateFormat("yyyy-MM-dd").format(_eventStartTimeController),
      endAt: DateFormat("yyyy-MM-dd").format(_eventEndTimeController),
    );
    //TODO: chon san pham can keu goi
    if (!_eventSubmitted) {
      setState(() {
        _eventSubmitted = true;
      });
      try {
        final bool success = await EventRequest.updateEvent(event, images!);
        if (success) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        throw Exception(e);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: headerForDetail("Tạo sự kiện quyên góp"),
      bottomNavigationBar:               Row(
        children: [
          Expanded(
            child: _page != 4
                ? InkWell(
                onTap: () {
                  setState(() {
                    if (_page < 4) _page += 1;
                  });
                },
                child: _builderButton())
                : InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainPage()));
              },
              child: _builderFinishButton(),
            ),
          )
        ],
      )
      ,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                  child: render(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget render() {
    if (_page == 1) {
      return _page1();
    }
    if (_page == 2) {
      if (_eventNameController.text.isNotEmpty &&
          _eventDescriptionController.text.isNotEmpty) {
        return _page2();
      } else {
        _page = 1;
      }
      return _page1();
    }
    if (_page == 3) {
      if (_listProductTypeController.isNotEmpty) {
        return _page3();
      } else {
        return _page2();
      }
    }
    if (_page == 4) {
      return FutureBuilder<bool>(
        future: updateEvent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Container(width: 50, height: 50,child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == true) {
            return _page4();
          } else {
            return _page3();
          }
        },
      );
    }
    return Container();
  }

  Widget _builderButton() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      decoration: BoxDecoration(color: Colors.black),
      child: Text(
        'Tiếp theo',
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

  Widget _builderFinishButton() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      decoration: BoxDecoration(color: Colors.black),
      child: Text(
        'Hoàn tất',
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

  Widget _page1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Tên sự kiện',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _eventNameController,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  )),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  ))),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Thời gian bắt đầu',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          readOnly: true,
          controller: TextEditingController(
            text: DateFormat('dd/MM/yyyy')
                .format(_eventStartTimeController)
                .toString(),
          ),
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _selectTime(context, true),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  )),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  ))),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Thời gian kết thúc',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          readOnly: true,
          controller: TextEditingController(
            text: DateFormat('dd/MM/yyyy')
                .format(_eventEndTimeController)
                .toString(),
          ),
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _selectTime(context, false),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  )),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  ))),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Mô tả sự kiện',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _eventDescriptionController,
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  )),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  ))),
        ),
      ],
    );
  }

  Widget _page2() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: Text(
              'Danh mục sản phẩm cần kêu gọi',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          FutureBuilder(
              future: ProductRequest.getProductType(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Đã xảy ra lỗi: ${snapshot.error}');
                }
                List<ProductType> productType = snapshot.data ?? [];
                return Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: productType!
                        .map((e) => typeOfProductButton(e))
                        .toList(),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget _page3() {
    return Container(
      width: screenWidth,
      height: screenHeight,
      padding: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Hình ảnh sản phẩm',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              getImage();
            },
            child: Text('Chọn hình ảnh'),
          ),
          Expanded(
              child: images != null
                  ? Image.file(
                File(images!.path),
                fit: BoxFit.cover,
              )
                  : Container()),
        ],
      ),
    );
  }

  Widget _page4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Cảm ơn bạn đã tạo sự kiện',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
          ),
          child: Text(
            'Sự kiện của bạn đã được tạo, tuy nhiên phải chờ xét duyệt. Hãy kiểm tra email đễ theo dõi tình trạng',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          width: 256,
          height: 256,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sunflower.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Widget typeOfProductButton(ProductType type) {
    var state = _listProductTypeController.contains(type.id!);
    return InkWell(
      onTap: () {
        setState(() {
          if (state) {
            _listProductTypeController.remove(type.id!);
          } else
            _listProductTypeController.add(type.id!);
        });
        // print(identical(_typeProductController, type.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        width: screenWidth * 40 / 100,
        decoration: ShapeDecoration(
          color: state ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFF999999)),
          ),
        ),
        child: Text(
          type.name.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: state ? Colors.white : Colors.black,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
      isStartTime ? _eventStartTimeController : _eventEndTimeController,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(Duration(days: 360)),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartTime) {
          _eventStartTimeController = pickedDate;
        } else {
          _eventEndTimeController = pickedDate;
        }
      });
    }
  }

  void getImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImages =
    await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImages != null) {
      images = selectedImages;
    }
    // print("Image List Length:" + images!.length.toString());
    setState(() {});
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

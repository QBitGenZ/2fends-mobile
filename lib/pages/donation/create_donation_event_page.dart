import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../models/product_type.dart';
import '../../networks/product_request.dart';
import '../index.dart';

class CreateDonationEventPage extends StatefulWidget {
  const CreateDonationEventPage({super.key});

  @override
  State<CreateDonationEventPage> createState() =>
      _CreateDonationEventPageState();
}

class _CreateDonationEventPageState extends State<CreateDonationEventPage> {
  late double screenHeight;
  late double screenWidth;
  var _page;
  late bool isLoading = true;
  final TextEditingController _eventNameController = TextEditingController();
  late DateTime _eventEndTimeController = DateTime.now();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  late List<String> _listProductTypeController;
  late List<XFile>? images = [];

  @override
  void initState() {
    super.initState();
    _page = 1;
    _listProductTypeController = [];
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: headerForDetail("Tạo sự kiện quyên góp"),
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
              Row(
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
                              // TODO: Xử lý sự kiện thêm sự kiện
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => MainPage()),
                              );
                            },
                            child: _builderFinishButton(),
                          ),
                  )
                ],
              )
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
          _eventDescriptionController.text.isNotEmpty)
        return _page2();
      else
        _page = 1;
      return _page1();
    }
    if (_page == 3) {
      return _page3();
    }
    if (_page == 4) {
      return _page4();
    }
    return Container();
  }

  Widget _builderButton() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
      child: Text(
        'Tiếp theo',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF949494),
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
                onPressed: () => _selectEndTime(context),
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
          maxLines: 10,
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
              future: ProductRequest.GetProductType(),
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
            child: GridView.builder(
                itemCount: images!.length ?? 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 3, mainAxisSpacing: 3),
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(
                    File(images![index].path),
                    fit: BoxFit.cover,
                  );
                }),
          ),
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

  Future<void> _selectEndTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _eventEndTimeController,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _eventEndTimeController) {
      setState(() {
        _eventEndTimeController = pickedDate;
      });
    }
  }

  void getImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      images!.addAll(selectedImages);
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

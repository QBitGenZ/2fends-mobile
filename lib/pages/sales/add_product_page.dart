import 'dart:io';

import 'package:fends_mobile/models/product_type.dart';
import 'package:fends_mobile/networks/product_request.dart';
import 'package:fends_mobile/pages/index.dart';
import 'package:fends_mobile/pages/sales/department_store_page.dart';
import 'package:fends_mobile/sections/home/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/navbar.dart';
import '../../models/product.dart';
import '../../widgets/navbar.dart';

class AddProductPage extends StatefulWidget {
  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late double screenHeight;
  late double screenWidth;
  String _degreeController = 'Mới';
  String _genderController = 'Nam';
  String _typeProductController = '';
  List<String> _sizeController = [];
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  late List<XFile>? images = [];
  late String _productId;

  var _page;
  @override
  void initState() {
    super.initState();
    _page = 1;
    _degreeController = 'Nam';
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: headerForDetail("Đăng bán sản phẩm"),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: render(),
            )),
            Row(
              children: [
                Expanded(
                  child: images!.length == 0 || _page != 3
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              if (_page < 3) _page += 1;
                            });
                            if (_page == 3) {
                              _addProduct();
                            }
                          },
                          child: _builderButton())
                      : InkWell(
                          onTap: () {
                            _addImage();
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => MainPage()),
                            );
                          },
                          child: _builderFinishButton(),
                        ),
                )
              ],
            )
          ],
        ));
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

  AppBar headerForDetail([String? title]) {
    return AppBar(
      leading: InkWell(
          onTap: () {
            if (_page != 1)
              setState(() {
                _page -= 1;
              });
            else
              Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new)),
      backgroundColor: Colors.white,
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

  Widget render() {
    if (_page == 1) {
      return _page1();
    }
    if (_page == 2) {
      if (_degreeController.isNotEmpty &&
          _typeProductController.isNotEmpty &&
          _sizeController.isNotEmpty) return _page2();
      _page = 1;
      return _page1();
    }
    if (_page == 3) {
      if (_nameController.text.isNotEmpty &&
          _priceController.text.isNotEmpty &&
          _priceController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty) {
        // print(double.parse(_priceController.text.toString()).runtimeType);
        return _page3();
      }
      _page = 2;
      return _page2();
    }
    return Container();
  }

  Future<void> _addProduct() async {
    try {
      print(_sizeController.join(', ').toString());
      Product product = Product(
        name: _nameController.text.toString(),
        quantity: int.parse(_quantityController.text.toString()),
        price: double.parse(_priceController.text.toString()),
        description: _descriptionController.text.toString(),
        size: _sizeController.join(', ').toString(),
        productType: _typeProductController.toString(),
        gender: _genderController.toString(),
        degree: _degreeController.toString()
      );
      var success = await ProductRequest.addProduct(product);
      _productId = success.id!;
      // print(_productId);
    } catch (e) {
      print('Error adding product: $e');
    }
  }


  Widget _page1() {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Giới tính',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: genderButton('Nam'),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: genderButton('Nữ'),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: genderButton('Unisex'),
              ),
            ],
          ),
          SizedBox(height: 30),

          Text(
            'Độ mới',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: degreeButton('Mới'),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: degreeButton('Vừa'),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: degreeButton('Cũ'),
              ),
            ],
          ),
          SizedBox(height: 30),
          Text(
            'Loại sản phẩm',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          SizedBox(height: 10),
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
                // print(_typeProductController);
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
          SizedBox(height: 30),
          Text(
            'Kích cỡ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              spacing: 20.0,
              runSpacing: 20.0,
              children: ['S', 'M', 'L', 'XL', '2XL', '3XL', 'Oversize', 'Khác ']
                  .map((e) => sizeOfProductButton(e))
                  .toList(),
            ),
          )
        ],
      ),
    ));
  }

  Widget _page2() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tên sản phẩm',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _nameController,
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
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Giá sản phẩm',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _priceController,
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
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Số lượng',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _quantityController,
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
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mô tả sản phẩm',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _descriptionController,
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
            )
          ],
        ),
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

  Widget degreeButton(String gender) {
    return InkWell(
      onTap: () {
        setState(() {
          _degreeController = gender;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: ShapeDecoration(
          color: identical(_degreeController, gender)
              ? Colors.black
              : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFF999999)),
          ),
        ),
        child: Text(
          gender,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _degreeController == gender ? Colors.white : Colors.black,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ),
    );
  }

  Widget genderButton(String gender) {
    return InkWell(
      onTap: () {
        setState(() {
          _genderController = gender;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: ShapeDecoration(
          color: identical(_genderController, gender)
              ? Colors.black
              : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFF999999)),
          ),
        ),
        child: Text(
          gender,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _genderController == gender ? Colors.white : Colors.black,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ),
    );
  }

  Widget typeOfProductButton(ProductType type) {
    return InkWell(
      onTap: () {
        setState(() {
          _typeProductController = type.id!;
        });
        // print(identical(_typeProductController, type.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        width: screenWidth * 40 / 100,
        decoration: ShapeDecoration(
          color:
              _typeProductController == type.id ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFF999999)),
          ),
        ),
        child: Text(
          type.name.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color:
                _typeProductController == type.id ? Colors.white : Colors.black,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ),
    );
  }

  Widget sizeOfProductButton(String size) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_sizeController.contains(size))
            _sizeController.remove(size);
          else
            _sizeController.add(size);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        width: screenWidth * 40 / 100,
        decoration: ShapeDecoration(
          color: _sizeController.contains(size) ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFF999999)),
          ),
        ),
        child: Text(
          size.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _sizeController.contains(size) ? Colors.white : Colors.black,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ),
    );
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

  Future<void> _addImage() async {
    print(images!.length);
    images!.forEach((element) async {
      var success = await ProductRequest.addProductImage(
                _nameController!.text.toString(), _productId, element);

    });

  }
}

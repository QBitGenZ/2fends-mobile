import 'dart:io';

import 'package:fends_mobile/pages/sales/your_department_page.dart';
import 'package:fends_mobile/pages/sales/size_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SalePage extends StatefulWidget {
  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  late double screenHeight;
  late double screenWidth;
  File? _image;

  // Function to handle image selection
  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => YourDepartmentPage()),
                    );
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          top: 50),
                      alignment: Alignment.topLeft,
                      child: Image.asset('assets/images/Vector.png'))),
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.08),
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Hình ảnh sản phẩm',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: _selectImage,
                child: Container(
                  width: screenWidth * 0.83,
                  height: screenHeight * 0.183,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _image == null
                          ? Text('')
                          : Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        child: Image.asset('assets/images/Vector1.png'),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: ElevatedButton(
                  onPressed: _selectImage,
                  child: Text('Tải ảnh lên'),
                ),
              ),
              InkWell(
                onTap: () =>{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SizeProduct()),)
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(30,MediaQuery.of(context).size.height*0.15,30,MediaQuery.of(context).size.height*0.15),
                  width: 450,
                  height: 50,
                  color: Colors.grey[100],
                  alignment: Alignment.center,
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

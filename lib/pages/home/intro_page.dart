import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../index.dart';



class IntroPage extends StatelessWidget {
  late double screenHeight;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              titleContainer(context), 
              listImage(context),
              accessbtnContainer(context),
              textIntro(context)
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  /**
   * Widget tieu de trang
   */
  Container titleContainer(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(
            0, 97, 30, screenHeight * 0.08375),
        child: Center(
          child: Text(
            "Bắt đầu trải nghiệm\n" "mua sắm với 2fends",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
  }

  Stack listImage(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Container(
              child: Image.asset('assets/images/Rectangle 79.png'),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(screenWidth*0.1, 0, screenWidth*0.10, 0),
             child: Image.asset('assets/images/Rectangle 78.png'),
            ),
            Container(
              child: Image.asset('assets/images/Rectangle 80.png'),
            ),
          ],
        )
      ],
    );
  }
  /**
   * Widget button trải nghiệm
   */
  Container accessbtnContainer(BuildContext context) {
    return Container(
      width: screenWidth * 0.83333,
      height: screenHeight * 0.075,
      margin: EdgeInsets.only(top: screenHeight*0.1575),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        },
        child: Text(
          'Trải nghiệm ngay',
          style: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFEEE8DA),

          // Màu nền của nút

          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          // Padding nút
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Bo tròn góc nút
          ),
        ),
      ),
    );
  }
  Container textIntro(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 0.0375*screenHeight),
      child: Text(
        'Bắt đầu dạo quanh 2fends để khám phá nào!!',
        style: GoogleFonts.roboto(
          color: Color(0xFF484848),
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 0,
        ),
      ),
    );
  }
}

import 'package:fends_mobile/pages/home/start_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  late double screenHeight;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => StartPage(),
        ),
      );
    });

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
                child: Container(
              color: Colors.grey.shade100,
              width: screenWidth,
              height: screenHeight,
              child: Image.asset(
                'assets/images/Rectangle 66.png',
                width: screenWidth,
                height: screenHeight,
              ),
            )),
            Positioned(
                child: Container(
              decoration: BoxDecoration(color: Color(0x99A7A7A7)),
              width: screenWidth * 0.5583333,
              height: screenHeight,
            )),
            Positioned(
                child: Container(
              child: Image.asset(
                  'assets/images/Thiết_kế_chưa_có_tên-removebg-preview.png'),
            )),
            Positioned(
                top: screenHeight * 0.245,
                child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: SizedBox(
                      width: 196,
                      height: 266,
                      child: Text(
                        'Nơi bạn tìm được những món đồ \nchất lượng với giá rẻ',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    )))
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

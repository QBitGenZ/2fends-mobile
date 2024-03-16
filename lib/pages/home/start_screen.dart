import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../account/login_screen.dart';
import '../account/signup_screen.dart';

class StartScreen extends StatelessWidget {
  late double screenWidth;
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
                child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: Image.asset(
                "./assets/images/home.png",
              ),
            )),
            Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.52375,
                  child: Column(
                    children: [
                      loginButtonContainer(context),
                      signinLink(context)
                    ],
                  ),
                ))
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  /**
   * Widget button đăng nhập
   */
  Container loginButtonContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 130, 0, 30),
      width: 0.83333 * screenWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: Colors.white),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: Text(
          "Đăng nhập",
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: Colors.black,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ),
    );
  }
  TextButton signinLink(BuildContext context){
    return TextButton(
      onPressed: () {
        // Không cần xử lý ở đây vì sẽ được xử lý trong onTap của TextSpan
      },
      child: RichText(
        text: TextSpan(
          text: 'Bạn chưa có tài khoản? ',
          style: GoogleFonts.roboto(
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w300,
            fontSize: 16,
            color: Colors.white,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Đăng ký',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Chuyển đến trang LoginScreen()
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}

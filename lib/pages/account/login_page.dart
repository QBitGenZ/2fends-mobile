import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/home_page.dart';
import '../home/intro_page.dart';
import '../home/start_page.dart';
import '../verify/accountAuth_page.dart';

/**
 * Class khung nhap password
 */
class PasswordContainer extends StatefulWidget {
  @override
  _PasswordContainerState createState() => _PasswordContainerState();
}

class _PasswordContainerState extends State<PasswordContainer> {
  bool _obscureText = true;
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.0925),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: _obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Mật khẩu',
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                style: BorderStyle.none,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  late double screenWidth;
  late double screenHeight;
  void navigateToStartScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            color: Color(0xFFEEE8DA),
            child: Stack(
              children: [
                Positioned(
                  child: GestureDetector(
                      onTap: () {
                        navigateToStartScreen(context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              top: 50, left: screenWidth * 0.0555),
                          child: Image.asset('assets/images/Vector.png'))),
                ),
                Column(
                  children: [
                    titleContainer(context),
                    userContainer(context),
                    //Đường viền giữa
                    Container(
                      height: 1,
                      color: Color(0x00D9D9D9),
                    ),
                    PasswordContainer(),
                    loginbtnContainer(context)
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    'assets/images/Group 674.png',
                    width: 900,
                  ),
                )
              ],
            )),
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
            0, (screenHeight * 0.19125), 0, screenHeight * 0.10375),
        child: Center(
          child: Text(
            "Đăng nhập\n" "vào tài khoản của bạn",
            style: GoogleFonts.roboto(
                fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ));
  }

  /**
   * Widget khung nhap username
   */
  Container userContainer(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextFormField(
          // keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Tài khoản',
            // prefixIcon: Icon(Icons.phone),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                style: BorderStyle.none,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /**
   * Widget button đăng nhập
   */
  Container loginbtnContainer(BuildContext context) {
    return Container(
      width: screenWidth * 0.83333,
      height: screenHeight * 0.075,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => IntroPage()),
          );
        },
        child: Text(
          'Đăng nhập',
          style: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
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
}

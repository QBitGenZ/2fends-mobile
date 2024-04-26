import 'package:fends_mobile/models/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_config.dart';
import '../../networks/user_request.dart';
import '../home/home_page.dart';
import '../home/intro_page.dart';
import '../home/start_page.dart';
import '../index.dart';
import '../verify/accountAuth_page.dart';

/**
 * Class khung nhap password
 */


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  late Login login;
  late String password;
  late double screenWidth;

  late double screenHeight;

  late String username;

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
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    'assets/images/Group 674.png',
                    width: 900,
                  ),
                ),
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
                    passwordContainer(context),
                    loginbtnContainer(context)
                  ],
                ),

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
          onChanged: (value) => {
            username = value
          },
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
Container passwordContainer(BuildContext context){
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.0925),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextFormField(
          onChanged: (value) => {
            password = value
          },
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
  /**
   * Widget button đăng nhập
   */
  Container loginbtnContainer(BuildContext context) {
    return Container(
      width: screenWidth * 0.83333,
      height: screenHeight * 0.075,
      child: ElevatedButton(
        onPressed: () {
          print(username);
          print(password);
          UserRequest.loginToken(username, password).then((value) => {
            AppConfig.ACCESS_TOKEN = value.access,
              Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MainPage()),
          )
          }).catchError((err) => {
            AlertDialog(
            shadowColor: Colors.grey[300],
            alignment: Alignment.center,
            content: Text(
              "Sai Tài khoản/Mật khẩu... Dăng nhập lại",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          )
          });

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

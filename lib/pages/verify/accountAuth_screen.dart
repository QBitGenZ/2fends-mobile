import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../account/signup_screen.dart';
import '../home/start_screen.dart';

class AccountAuthScreen extends StatelessWidget {
  late double screenWidth;
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Color(0xFFEEE8DA),
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: screenWidth * 0.0555,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Container(
                  child: Image.asset('assets/images/Vector.png'),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, (screenHeight * 0.16125),
                      60, screenHeight * 0.10375),
                  child: Center(
                    child: Text(
                      "Xác thực \n" "với số điện thoại",
                      style: GoogleFonts.roboto(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ),
                // Hàng ngang của các TextField để nhập mã OTP
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                        (index) {
                      return Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:BorderSide(

                              color: Colors.black,
                              width: 2,) ,

                          ),

                        ),
                        child: SizedBox(
                          width: 40,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                            onChanged: (value) {
                              // Tự động chuyển sang ô kế tiếp khi người dùng nhập
                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    width: screenWidth*0.92222,
                    height: screenHeight*0.074,
                    margin: EdgeInsets.fromLTRB(0, screenHeight*0.01625, 0, screenHeight*0.0325),
                  child: TextButton(
                    onPressed: () {
                      // Không cần xử lý ở đây vì sẽ được xử lý trong onTap của TextSpan
                    },
                      style: ButtonStyle(
                        alignment: Alignment.center,
                      ),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Mã xác nhận đã được gửi vào số điện thoại của bạn đã điền trước đó. Nếu bạn vẫn chưa nhận được hãy, vui lòng bấm vào',
                          style: GoogleFonts.roboto(
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '\ngửi lại',
                              style: GoogleFonts.roboto(

                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Chuyển đến trang LoginScreen()
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => StartScreen()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    )
                  ),
                ),
                Container(
                  width: screenWidth * 0.83333,
                  height: screenHeight * 0.075,
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý khi nhấn nút đăng nhập
                    },
                    child: Text(
                      'Xác nhận',
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFCA4B),
                      padding: EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(50.0), // Bo tròn góc nút
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/sunflower.png',
                width: 100 ,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

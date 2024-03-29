import 'package:fends_mobile/networks/user_request.dart';
import 'package:fends_mobile/pages/account/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/start_page.dart';
import '../verify/accountAuth_page.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late double screenWidth;

  late double screenHeight;

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _rePasswordController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  late DateTime _selectedDate = DateTime.now();

  String _selectedGender = 'Nữ';

  @override
  void initState() {
    super.initState();
    // Initialize selected date to current date
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            width: screenWidth,
            color: Color(0xFFEEE8DA),
            child: Stack(
              children: [
                Positioned(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StartPage()),
                        );
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              top: 50, left: screenWidth * 0.0555),
                          child: Image.asset('assets/images/Vector.png'))),
                ),
                Column(
                  children: [
                    titleContainer(),
                    userContainer(),
                    passwordContainer(),
                    repasswordContainer(),
                    nameContainer(),
                    birthdayContainer(),
                    genderContainerState(),
                    emailContainer(),
                    phoneContainer(),
                    signinbtnContainer()
                  ],
                ),
              ],
            )),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Container titleContainer() {
    return Container(
        margin: EdgeInsets.fromLTRB(
            0, (screenHeight * 0.03375) + 55, 90, screenHeight * 0.03375),
        child: Center(
          child: Text(
            "Đăng ký\n" "tài khoản mới",
            style: GoogleFonts.roboto(
                fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ));
  }

  Container lineBetweenContainer() {
    return Container(
      height: 1,
      color: Color(0x00D9D9D9),
    );
  }

  Widget genderContainerState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 13),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Giới tính',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Nam'),
                value: 'Nam',
                groupValue: _selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Nữ'),
                value: 'Nữ',
                groupValue: _selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container userContainer() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextFormField(
          controller: _usernameController,
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

  Container nameContainer() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextFormField(
          // keyboardType: TextInputType.phone,
          controller: _fullNameController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Họ và tên',
            // prefixIcon: Icon(Icons.phone),
            enabledBorder: OutlineInputBorder(
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

  bool passwordVisible = false;
  Container passwordContainer() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextFormField(
          // keyboardType: TextInputType.phone,
          obscureText: passwordVisible,
          controller: _passwordController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Mật khẩu',
            suffixIcon: IconButton(
              icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(
                  () {
                    passwordVisible = !passwordVisible;
                  },
                );
              },
            ),
            // prefixIcon: Icon(Icons.phone),
            enabledBorder: OutlineInputBorder(
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

  bool repasswordVisible = false;
  Container repasswordContainer() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: repasswordVisible,
          controller: _rePasswordController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            suffixIcon: IconButton(
              icon: Icon(
                  repasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(
                  () {
                    repasswordVisible = !repasswordVisible;
                  },
                );
              },
            ),
            labelText: 'Nhập lại mật khẩu',
            // prefixIcon: Icon(Icons.phone),
            enabledBorder: OutlineInputBorder(
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

  Container phoneContainer() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextFormField(
          // keyboardType: TextInputType.phone,
          controller: _phoneController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Số điện thoại ',
            // prefixIcon: Icon(Icons.phone),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.none,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container emailContainer() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Email',
            enabledBorder: OutlineInputBorder(
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Widget birthdayContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextFormField(
        readOnly: true,
        controller: TextEditingController(
          text:
              "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Ngày sinh',
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.none,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Container signinbtnContainer() {
    return Container(
      width: screenWidth * 0.83333,
      height: screenHeight * 0.075,
      margin: EdgeInsets.only(top: screenHeight * 0.04125),
      child: ElevatedButton(
        onPressed: () async {
          if (_passwordController.text != _rePasswordController.text)
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Mật khẩu không trùng khớp.'),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Đóng'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          else {
            var success = await UserRequest.signup(
                _usernameController.text,
                _passwordController.text,
                _fullNameController.text,
                _selectedDate,
                _selectedGender.toString(),
                _emailController.text,
                _phoneController.text);
            if (success)
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            else
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Tạo tài khoản không thành công.'),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Đóng'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
          }
        },
        child: Text(
          'Đăng ký',
          style: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF006B28),
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

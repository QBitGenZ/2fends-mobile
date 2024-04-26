import 'package:fends_mobile/networks/user_request.dart';
import 'package:fends_mobile/pages/account/address_page.dart';
import 'package:fends_mobile/pages/account/login_page.dart';
import 'package:fends_mobile/pages/account/update_info_page.dart';
import 'package:fends_mobile/pages/home/start_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../app_config.dart';
import '../../models/user.dart';
import '../../networks/statistics.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late double screenWidth;
  late User user;
  late double screenHeight;
  late bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  Future<void> _getInfo() async {
    user = await UserRequest.info();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFEEE8DA),
      appBar: headerForDetail("Tài khoản"),
      body: Column(children: [
        Expanded(
            child: Container(
          width: screenWidth,
          height: screenHeight * 83 / 100,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
          child: isLoading
              ? Center(
                  child: Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator()))
              : _buildInfoMenu(),
        ))
      ]),
    );
  }

  Column _buildInfoMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
            width: 150,
            height: 150,
            child: user.avatar != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                        "${AppConfig.IMAGE_API_URL}${user.avatar as String}"),
                  )
                : CircleAvatar()),
        const SizedBox(
          height: 10,
        ),
        Text(
          user!.full_name.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          user.is_philanthropist != null && user.is_philanthropist != false
              ? 'Nhà từ thiện'
              : 'Người dùng',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        _buildTotalFund(),
        const SizedBox(
          height: 30,
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 10 / 100),
            // alignment: Alignment.center,
            width: screenWidth,
            child: _menu())
      ],
    );
  }

  Widget _menu() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateInfoPage(
                          user: user,
                          callback: () async => await _getInfo(),
                        )));
          },
          child: _menuItem(Icons.manage_accounts_outlined, 'Cài đặt tài khoản',
              Color(0xFF4299AB)),
        ),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddressPage(
                            user: user,
                          )));
            },
            child: _menuItem(
                Icons.location_on_outlined, 'Địa chỉ', Color(0xFF4FEC9D))),
        // _menuItem(Icons.credit_card_outlined, 'Thanh toán', Color(0xFF0587FF)),
        _menuItem(Icons.help_outline, 'Trung tâm trợ giúp', Color(0xFFB6D400)),
        _menuItem(Icons.error_outline, 'Báo cáo tài khoản', Color(0xFFFF0000)),
        InkWell(
            onTap: () {
              AppConfig.ACCESS_TOKEN = '';
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => StartPage()));
            },
            child: _menuItem(
                Icons.logout_outlined, 'Đăng xuất', Color(0xFFFF9900))),
      ],
    );
  }

  Widget _menuItem(IconData icon, String tilte, [Color? color]) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color ?? Color(0xFF063B00),
            size: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            tilte,
            style: TextStyle(
              color: Color(0xFF063B00),
              fontSize: 15,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalFund() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      decoration: ShapeDecoration(
        color: Color(0xFFEEE8DA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding:
              const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tổng số tiền quyên góp',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FutureBuilder(
                      future: StatisticRequest.myTotalFund(),
                      builder: (context, snapshot) {
                        var fund = snapshot.data ?? 0;
                        return Text(
                          '$fund VND',
                          style: TextStyle(
                            color: Color(0xFF161414),
                            fontSize: 32,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar headerForDetail([String? title]) {
    return AppBar(
      leading: Container(),
      backgroundColor: Color(0xFFEEE8DA),
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
}

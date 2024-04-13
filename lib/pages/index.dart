import 'package:fends_mobile/pages/account/account_page.dart';
import 'package:fends_mobile/pages/donation/donation_page.dart';
import 'package:fends_mobile/pages/sales/department_store_page.dart';
import 'package:fends_mobile/sections/home/index.dart';
import 'package:fends_mobile/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/navbar.dart';
import '../sections/recomment_product_section.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late double screenWidth;
  late String selectedTitle;

  @override
  void initState() {
    super.initState();
    selectedTitle = navbar[0].title;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    void updateSelectedTitle(String title) {
      setState(() {
        selectedTitle = title;
      });
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Navbar(
          selectedTitle: selectedTitle,
          updateSelectedTitle: updateSelectedTitle,
        ),
        body: renderSection(),
      ),
    );
  }

  Widget renderSection() {
    if (selectedTitle == navbar[0].title) {
      print(selectedTitle);
      return HomeSection();
    } else if (selectedTitle == navbar[2].title) {
      print(selectedTitle);
      return DepartmentStorePage();
    }
    else if(selectedTitle == navbar[4].title) {
      return AccountPage();
    }
    else if (selectedTitle == navbar[3].title) {
      return DonationPage();
    }
    return Container();
  }
}

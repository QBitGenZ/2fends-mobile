import 'package:fends_mobile/sections/home/index.dart';
import 'package:fends_mobile/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/navbar.dart';

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

    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                bottom: 0,
                child: Navbar(selectedTitle: selectedTitle, updateSelectedTitle: updateSelectedTitle,)
            ),
            Positioned(
              top: 0,
                child: renderSection()
            ),
          ],
    ));
  }

  Widget renderSection() {
    if(selectedTitle == navbar[0].title) {
      print(selectedTitle);
      return HomeSection();
    }
    return Container();
  }
}

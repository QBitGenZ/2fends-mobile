import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecommentProductSection extends StatelessWidget{
  late double screenHeight;
  late double screenWidth;

  @override
  Widget build(BuildContext context){
    screenWidth= MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Row(

                  )
                ],
              ),
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
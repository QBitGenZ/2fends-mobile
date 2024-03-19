import 'package:fends_mobile/constants/recomment_product.dart';
import 'package:fends_mobile/constants/user_data.dart';
import 'package:fends_mobile/models/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late double screenHeight;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: screenHeight+1134,
          margin: EdgeInsets.only(top: screenHeight * 0.0875),
          child:
          ListView(children: recommentproduct.map((e) => list(e)).toList()),
        ),
      ),
    );
  }

  Widget list(RecommentProduct? recommentproduct) {
    return Dismissible(
      key: Key(recommentproduct!.productName),
      background: Container(
        color: Colors.green,
        child: Icon(Icons.add),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20.0),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: Icon(Icons.delete),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
      ),
      onDismissed: (direction) {
        setState(() {
          recommentproduct = null;
        });
        if (direction == DismissDirection.startToEnd) {
          // Add item back
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(" added"),
                  duration: Duration(seconds: 1)));
        } else if (direction == DismissDirection.endToStart) {
          // Delete item
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("deleted"),
                  duration: Duration(seconds: 1)));
        }
      },
      child: ListTile(
        title: Container(
          child: Row(
            children: [
              Image.asset(recommentproduct.imagePath),
              Container(
                child: Column(
                  children: [
                    Text(
                      recommentproduct.productName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    Text(
                      formatPrice(recommentproduct.price),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    Text(
                      'Kích cỡ:  ' + recommentproduct.size,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class Product {
//   final String imagePath;
//   final String productName;
//   final String formatPrice;
//   final String size;
//
//   Product(
//       {Key? key,
//       required this.imagePath,
//       required this.productName,
//       required this.formatPrice,
//       required this.size});
// }

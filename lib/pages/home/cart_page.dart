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
        body: Stack(
          children: [
            ListView(
              children: [
                ...recommentproduct.map((e) => list(e)).toList(),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: payContainer(recommentproduct[0]),
              // Truyền một phần tử từ danh sách recommentproduct
              // Đặt payContainer ở góc dưới của màn hình sử dụng Positioned.
            ),
          ],
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
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(" added"), duration: Duration(seconds: 1)));
        } else if (direction == DismissDirection.endToStart) {
          // Delete item
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("deleted"), duration: Duration(seconds: 1)));
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

  Container payContainer(RecommentProduct recommentproduct) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Container(

      decoration: BoxDecoration(color: Color(0xFFFAFAFA)),
      width: screenWidth,
      height: screenHeight*0.3125,
      child: Column(
        children: [
          Container(
            height: screenHeight*0.075,
            child:
            Row(
              children: [
                Container(
            margin: EdgeInsets.fromLTRB( 0.045*screenWidth,0,150,0),
                  child:Text('Mã giảm giá',
                    style: TextStyle(
                      color: Color(0xFF858585),
                      fontSize: 15,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),),
                ),
                Container(
                  child: Text(formatPrice(recommentproduct.price),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),),
                )


              ],
            ),
          ),
          Container(
            width: screenWidth,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFFC7C7C7),
                ),
              ),
            ),
          ),
         Container(
           height: screenHeight*0.075,
           child:
           Row(
             children: [
               Container(
                 margin: EdgeInsets.fromLTRB( 0.045*screenWidth,0,125,0),
                 child: Text('Tổng thanh toán',
                   style: TextStyle(
                     color: Color(0xFF858585),
                     fontSize: 15,
                     fontFamily: 'Roboto',
                     fontWeight: FontWeight.w500,
                     height: 0,
                   ),),
               ),
               Container(
                 child: Text(formatPrice(recommentproduct.price),
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     color: Colors.black,
                     fontSize: 15,
                     fontFamily: 'Roboto',
                     fontWeight: FontWeight.w500,
                     height: 0,
                   ),),
               )
             ],
           ),
         ),
          Container(
            width: screenWidth,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFFC7C7C7),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 0.04125*screenHeight),
            width: 0.83333*screenWidth,
            height: screenHeight*0.0625,
            decoration: ShapeDecoration(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            alignment: Alignment.center,
            child:  Text(
                'Thanh toán',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
        ],
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

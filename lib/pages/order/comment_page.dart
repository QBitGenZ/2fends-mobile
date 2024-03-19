import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentPage extends StatelessWidget {
  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: headerForDetail("Đánh giá đơn hàng"),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Chi tiết đơn hàng',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                _listProduct(),
                SizedBox(
                  height: 10,
                ),
                _totalRow("Giá sản phẩm", "250.000"),
                _totalRow("Giá vận chuyển", "0"),
                _totalRow("Giá đơn hàng", "250.000", Colors.black),
                SizedBox(
                  height: 45,
                ),
                _commentArea()
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar headerForDetail([String? title]) {
    return AppBar(
      leading: Icon(Icons.arrow_back_ios_new),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: title != null
          ? Text(
              title,
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

  Widget _listProduct() {
    return Column(
      children: List.generate(
        3,
        (index) => _listProductItem(),
      ),
    );
  }

  Widget _listProductItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 62,
        padding: EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.5, color: Color(0xFFCCCCCC), strokeAlign: 2),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://bizweb.dktcdn.net/thumb/1024x1024/100/329/681/products/3bf3d1e0-688f-4d6b-8b0a-60e9f0a1bb21.jpg?v=1679480250493"),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
            // Image.network(
            //   "https://bizweb.dktcdn.net/thumb/1024x1024/100/329/681/products/3bf3d1e0-688f-4d6b-8b0a-60e9f0a1bb21.jpg?v=1679480250493",
            //   width: 40 / 360 * screenWidth,
            //   fit: BoxFit.fitWidth,
            // ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Áo choàng vải',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                Text(
                  'Kích cỡ: phù hợp mọi kích cỡ',
                  style: TextStyle(
                    color: Color(0xFFB2B2B2),
                    fontSize: 10,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            )),
            Expanded(
              child: Text(
                '125.000 vnd',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalRow(String title, String value, [Color? color]) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color ?? Color(0xFF767676),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          Text(
            value + ' vnd',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: color ?? Color(0xFF767676),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _commentArea() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Đánh giá',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Chất lượng sản phẩm',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              Expanded(
                child: RatingBar.builder(
                  itemSize: 20,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Chia sẻ về sản phẩm',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 50),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF999999)))),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Người bán hỗ trợ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              // SizedBox(width: 30,),
              Expanded(
                child: RatingBar.builder(
                  itemSize: 20,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Dịch vụ giao hàng',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              // SizedBox(width: 30,),
              Expanded(
                child: RatingBar.builder(
                  itemSize: 20,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),

            ],
          ),
          SizedBox(height: 15,),
          _submitButton()
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: Colors.black),
              child: Center(
                child: Text(
                  'Gửi đánh giá',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:fends_mobile/pages/order/comment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class StatusOrderPage extends StatelessWidget {
  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: headerForDetail("Tình trạng đơn hàng"),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _subNav(),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
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
                SizedBox(height: 10,),
                _totalRow("Giá sản phẩm", "250.000"),
                _totalRow("Giá vận chuyển", "0"),
                _totalRow("Giá đơn hàng", "250.000", Colors.black),

                _submitButton("Đánh giá đơn hàng", context)

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

  Widget _subNav() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 45,
          width: 150/360 *screenWidth,
          decoration: BoxDecoration(color: Color(0xFFEEE8DA)),
          child: Center(
            child: Text(
              'Chi tiết',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
        ),
        Container(
          height: 45,
          width: 150/360 *screenWidth,
          decoration: BoxDecoration(color: Colors.black),
          child: Center(
            child: Text(
              'Vận chuyển',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFEEE8DA),
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
        )
      ],
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

  Widget _submitButton(String title, BuildContext context) {
    return InkWell(
      onTap: () => {
      Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CommentPage()),
      )
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: Colors.black),
              child: Center(
                child: Text(
                  title,
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

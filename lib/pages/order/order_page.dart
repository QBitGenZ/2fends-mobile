import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _header(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subNav(),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                  child: Text(
                    'Đơn hàng chưa giao',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                _orderList(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, bottom: 10, top: 30),
                  child: Text(
                    'Đơn hàng đã giao',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                _orderList(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, bottom: 10, top: 30),
                  child: Text(
                    'Đơn hàng chờ đánh giá',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                _orderList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _header([String? title]) {
    return AppBar(
      leading: Icon(Icons.arrow_back_ios_new),
      backgroundColor: Colors.white,
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

  Widget _orderList() {
    return Column(
      children: List.generate(
        10,
        (index) => _orderListItem(),
      ),
    );
  }

  Widget _orderListItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(
                horizontal: BorderSide(color: Color(0xFFC6C6C6)))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                "https://bizweb.dktcdn.net/thumb/1024x1024/100/329/681/products/3bf3d1e0-688f-4d6b-8b0a-60e9f0a1bb21.jpg?v=1679480250493",
                width: 40 / 360 * screenWidth,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Khăn choàng',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '125.000 vnd',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ],
              )),
              Expanded(
                child: Text(
                  'Tình trạng: chờ xác nhận',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }

  Widget subNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _subnavItem("Giỏ hàng", false),
        _subnavItem("Đơn hàng", true),
        _subnavItem("Chat", false)],
    );
  }

  Widget _subnavItem(String title, bool state) {
    return Builder(
      builder: (context) {
        return Container(
          width: 100/360 * MediaQuery.of(context).size.width,
          height: 35,
          decoration: ShapeDecoration(
            color: state ? Colors.black :Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: Color(0xFF707070)),
            ),
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: state? Colors.white : Colors.black,
                fontSize: 13,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
        );
      }
    );
  }
}

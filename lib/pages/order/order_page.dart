import 'package:fends_mobile/app_config.dart';
import 'package:fends_mobile/networks/order_request.dart';
import 'package:fends_mobile/pages/order/comment_page.dart';

import 'package:fends_mobile/pages/order/status_order_page.dart';
import 'package:fends_mobile/sections/home/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/order.dart';
import '../chat/chat_page.dart';
import '../index.dart';
import '../product/cart_page.dart';

class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late double screenWidth;
  late List<Order> orders = [];
  bool isLoading = true;

  Future<void> _getOrders() async {
    try {
      // Assuming OrderRequest.getOrders() returns a list of orders
      List<Order> fetchedOrders = await OrderRequest.getOrders();
      setState(() {
        orders = fetchedOrders;
        isLoading = false; // Set isLoading to false when data is fetched
      });
    } catch (error) {
      // Handle error if any
      print("Error fetching orders: $error");
      setState(() {
        isLoading = false; // Set isLoading to false even if there's an error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getOrders();
  }

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
                // Padding(
                //   padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                //   child: Text(
                //     'Đơn hàng chưa giao',
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 16,
                //       fontFamily: 'Roboto',
                //       fontWeight: FontWeight.w500,
                //       height: 0,
                //     ),
                //   ),
                // ),
                // _orderList(context),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(left: 20.0, bottom: 10, top: 30),
                //   child: Text(
                //     'Đơn hàng đã giao',
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 16,
                //       fontFamily: 'Roboto',
                //       fontWeight: FontWeight.w500,
                //       height: 0,
                //     ),
                //   ),
                // ),
                // _orderList(context),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(left: 20.0, bottom: 10, top: 30),
                //   child: Text(
                //     'Đơn hàng chờ đánh giá',
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 16,
                //       fontFamily: 'Roboto',
                //       fontWeight: FontWeight.w500,
                //       height: 0,
                //     ),
                //   ),
                // ),
                _orderList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _header([String? title]) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MainPage()));
        },
        child: Icon(Icons.arrow_back_ios_new),
      ),
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

  // Widget _orderList(BuildContext context) {
  //   return ListView.builder(
  //     itemCount: orders.length,
  //       itemBuilder: _orderListItem() );
  // }

  Widget _orderList(BuildContext context) {
    if (isLoading) {
      return Center(
          child: Container(
              width: 30,
              height: 30,
              child:
                  CircularProgressIndicator())); // Show loading indicator while fetching data
    } else {
      return ListView.builder(
        shrinkWrap:
            true, // Added to make the ListView scrollable within the Column
        physics:
            NeverScrollableScrollPhysics(), // Added to make the ListView scrollable within the SingleChildScrollView
        itemCount: orders.length,
        itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => StatusOrderPage(order : orders[index])));
            },
            child: _orderListItem(orders[index])),
      );
    }
  }

  Widget _orderListItem(Order order) {
    if (order.items != null && order.items!.isNotEmpty) {
      final productImage = order.items![0].product!.productImage?[0].src;
      final imageUrl = productImage != null && productImage.isNotEmpty
          ? "${AppConfig.IMAGE_API_URL}/${productImage.toString()}"
          : "https://bizweb.dktcdn.net/thumb/1024x1024/100/329/681/products/3bf3d1e0-688f-4d6b-8b0a-60e9f0a1bb21.jpg?v=1679480250493";
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
                  imageUrl,
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
                      '${order.items![0].product!.name.toString()}',
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
                    'Tình trạng: ${order.status.toString()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                InkWell(
                    onTap: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => StatusOrderPage(order: order,)),
                          )
                        },
                    child: Icon(Icons.arrow_forward_ios))
              ],
            ),
          ),
        ),
      );
    }
    return Container();
  }

  Widget subNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: _subnavItem("Giỏ hàng", false)),
        InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => OrderPage()));
            },
            child: _subnavItem("Đơn hàng", true)),
        InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ChatPage()));
            },
            child: _subnavItem("Chat", false))
      ],
    );
  }

  Widget _subnavItem(String title, bool state) {
    return Builder(builder: (context) {
      return Container(
        width: 100 / 360 * MediaQuery.of(context).size.width,
        height: 35,
        decoration: ShapeDecoration(
          color: state ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: Color(0xFF707070)),
          ),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: state ? Colors.white : Colors.black,
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
      );
    });
  }
}

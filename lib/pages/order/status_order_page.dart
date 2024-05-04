import 'package:fends_mobile/constants/recomment_product.dart';
import 'package:fends_mobile/networks/address_request.dart';
import 'package:fends_mobile/pages/order/comment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '../../app_config.dart';
import '../../models/address.dart';
import '../../models/order.dart';
import '../../models/order_item.dart';
import '../../models/user.dart';
import '../../networks/user_request.dart';

class StatusOrderPage extends StatefulWidget {
  late Order order;
  StatusOrderPage({super.key, required this.order});

  @override
  State<StatusOrderPage> createState() => _StatusOrderPageState();
}

class _StatusOrderPageState extends State<StatusOrderPage> {
  late double screenWidth;
  bool isLoading = true;
  late User user = User();
  late Address address;

  double _totalPrice() {
    if (widget.order.items!.isNotEmpty) {
      return widget.order.items!
          .map((item) =>
              (item.product!.price!.toDouble() * item.quantity!.toInt()))
          .reduce((value, element) => value + element);
    }
    return 0;
  }

  Future<void> _getInfo() async {
    user = await UserRequest.info();
  }

  Future<void> _getAddress() async {
    address = await AddressRequset.getAddress(widget.order.address.toString());
  }

  Future<void> _initializeData() async {
    await _getInfo();
    await _getAddress();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: headerForDetail("Tình trạng đơn hàng"),
      bottomNavigationBar: widget.order.status.toString() == "Đã giao hàng"
          ? InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CommentPage(order: widget.order,)),
                );
              },
              child: _submitButton("Đánh giá đơn hàng", context))
          : _submitButton("Đã nhận hàng", context),
      body: isLoading
          ? Container()
          : Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // _subNav(),
                      // SizedBox(height: 30),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 10),
                      //   child: Text(
                      //     'Chi tiết đơn hàng',
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 16,
                      //       fontFamily: 'Roboto',
                      //       fontWeight: FontWeight.w500,
                      //       height: 0,
                      //     ),
                      //   ),
                      // ),
                      _listProduct(),
                      SizedBox(
                        height: 10,
                      ),
                      _totalRow("Quỹ từ thiện", _totalPrice() * 10/100),
                      _totalRow("Tổng giá trị sản phẩm", _totalPrice()),
                      // _totalRow("Giá vận chuyển", "0"),
                      _totalRow(
                          "Tổng giá trị đơn hàng", _totalPrice()*1.1, Colors.black),
                      const SizedBox(
                        height: 30,
                      ),
                      _address()
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  AppBar headerForDetail([String? title]) {
    return AppBar(
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new)),
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
          width: 150 / 360 * screenWidth,
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
          width: 150 / 360 * screenWidth,
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
    // return Column(
    //   children: List.generate(
    //     3,
    //     (index) => _listProductItem(),
    //   ),
    // );

    return ListView.builder(
      shrinkWrap:
          true, // Added to make the ListView scrollable within the Column
      physics:
          NeverScrollableScrollPhysics(), // Added to make the ListView scrollable within the SingleChildScrollView
      itemCount: widget.order.items?.length,
      itemBuilder: (context, index) => InkWell(
          onTap: () {
            //   Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (context) => StatusOrderPage(order : orders[index])));
          },
          child: _listProductItem(widget.order.items![index])),
    );
  }

  Widget _listProductItem(OrderItem item) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        // height: 62,
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
                  image: item.product?.productImage != null &&
                          item.product!.productImage!.isNotEmpty
                      ? NetworkImage(
                          AppConfig.IMAGE_API_URL +
                              item.product!.productImage![0].src.toString(),
                        )
                      : NetworkImage(
                          "https://bizweb.dktcdn.net/thumb/1024x1024/100/329/681/products/3bf3d1e0-688f-4d6b-8b0a-60e9f0a1bb21.jpg?v=1679480250493",
                        ),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
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
                  '${item.product?.name.toString()}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                Text(
                  'Kích cỡ: ${item.product?.size.toString()}',
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
                formatPrice(item.product!.price! * item.quantity!.toDouble()),
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

  Widget _totalRow(String title, double value, [Color? color]) {
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
            formatPrice(value),
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

  Widget _address() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          // left: BorderSide(color: Color(0xFFCCCCCC)),
          top: BorderSide(width: 1, color: Color(0xFFCCCCCC)),
          // right: BorderSide(color: Color(0xFFCCCCCC)),
          bottom: BorderSide(width: 1, color: Color(0xFFCCCCCC)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Địa chỉ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          _addressCard(address)
        ],
      ),
    );
  }

  Widget _addressCard(Address address) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(top: 10),
                // decoration: ShapeDecoration(
                //   color: Colors.white,
                //   shape: RoundedRectangleBorder(
                //     side: BorderSide(width: 1.5, color: Color(0xFF9E9E9E)),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "${user.full_name}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      address.address.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${user.phone}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }

  Widget _submitButton(String title, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
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

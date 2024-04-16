import 'package:fends_mobile/networks/cart_request.dart';
import 'package:fends_mobile/pages/order/comment_page.dart';
import 'package:fends_mobile/pages/order/order_address_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '../../app_config.dart';
import '../../models/cart_item.dart';

enum PaymentMethod { COD, VNPay }

class PaymentPage extends StatefulWidget {
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late double screenWidth;
  late List<CartItem> carts;
  late bool isLoading = true;

  Future getCart() async {
    carts = await CartRequest.getCarts();
    setState(() {
      isLoading = false;
    });
  }

  double _totalPrice() {
    if (carts.isNotEmpty) {
      return carts
          .map((item) =>
              (item.product!.price!.toDouble() * item.quantity!.toInt()))
          .reduce((value, element) => value + element);
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    getCart();
  }

  PaymentMethod? _paymentMethod = PaymentMethod.COD;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: headerForDetail("Thanh toán"),
      bottomNavigationBar: _submitButton("Đặt hàng", context),
      body: isLoading
          ? CircularProgressIndicator()
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
                      SizedBox(
                        height: 10,
                      ),
                      _totalRow("Giá sản phẩm", _totalPrice().toString()),
                      _totalRow("Giá vận chuyển", "0"),
                      _totalRow("Giá đơn hàng", _totalPrice().toString(),
                          Colors.black), //TODO: Cộng giá vận chuyển
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderAddressPage()));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      // left: BorderSide(color: Color(0xFFCCCCCC)),
                                      top: BorderSide(
                                          width: 1, color: Color(0xFFCCCCCC)),
                                      // right: BorderSide(color: Color(0xFFCCCCCC)),
                                      bottom: BorderSide(
                                          width: 1, color: Color(0xFFCCCCCC)),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Địa chỉ', //TODO: chon hoặc thêm địa chỉ
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Color(0xFFCCCCCC),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      // left: BorderSide(color: Color(0xFFCCCCCC)),
                                      top: BorderSide(
                                          width: 1, color: Color(0xFFCCCCCC)),
                                      // right: BorderSide(color: Color(0xFFCCCCCC)),
                                      bottom: BorderSide(
                                          width: 1, color: Color(0xFFCCCCCC)),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Phương thức thanh toán',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: RadioListTile(
                                          title: Text("Tiền mặt"),
                                          groupValue: _paymentMethod,
                                          value: PaymentMethod.COD,
                                          onChanged: (PaymentMethod? value) {
                                            setState(() {
                                              _paymentMethod = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        child: RadioListTile(
                                          title: Text("VNPay"),
                                          groupValue: _paymentMethod,
                                          value: PaymentMethod.VNPay,
                                          onChanged: (PaymentMethod? value) {
                                            setState(() {
                                              _paymentMethod = value;
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 150,
                      ),
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

  Widget _listProduct() {
    return Column(
      children: carts.map((e) => _listProductItem(e)).toList(),
    );
  }

  Widget _listProductItem(CartItem cartItem) {
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                image: DecorationImage(
                    image: cartItem.product?.productImage != null &&
                            cartItem.product!.productImage!.isNotEmpty
                        ? NetworkImage(
                            AppConfig.IMAGE_API_URL +
                                cartItem.product!.productImage![0].src
                                    .toString(),
                          )
                        : NetworkImage(
                            "https://bizweb.dktcdn.net/thumb/1024x1024/100/329/681/products/3bf3d1e0-688f-4d6b-8b0a-60e9f0a1bb21.jpg?v=1679480250493",
                          )
                    // : AssetImage("assets/images/fake.png"),
                    ),
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
                  cartItem.product!.name.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                Text(
                  'Kích cỡ: ' + cartItem.product!.size.toString(),
                  style: TextStyle(
                    color: Color(0xFFB2B2B2),
                    fontSize: 10,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                Text(
                  'Số lượng: ' + cartItem.quantity.toString(),
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
                (cartItem.product!.price! * cartItem.quantity!.toDouble()).toString() + " vnd",
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
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => CommentPage()),
        // )
        //ToDo: Xử lý sự kiện đặt hàng
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 70,
              margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              // padding: EdgeInsets.symmetric(vertical: 20),
              decoration: ShapeDecoration(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
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

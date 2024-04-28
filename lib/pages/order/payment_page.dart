import 'dart:async';

import 'package:fends_mobile/networks/order_item_request.dart';
import 'package:fends_mobile/networks/order_request.dart';
import 'package:fends_mobile/networks/cart_request.dart';
import 'package:fends_mobile/pages/order/comment_page.dart';
import 'package:fends_mobile/pages/order/order_address_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '../../app_config.dart';
import '../../constants/recomment_product.dart';
import '../../models/address.dart';
import '../../models/cart_item.dart';
import '../../models/order.dart';
import '../../models/order_item.dart';
import '../../models/user.dart';
import '../../networks/user_request.dart';
import '../index.dart';

enum PaymentMethod { COD, MoMo }

class PaymentPage extends StatefulWidget {
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late double screenWidth;
  late List<CartItem> carts;
  late bool isLoading = true;
  late Address address;
  late User user;
  bool isAddressSelected = false;

  Future<void> _getCart() async {
    carts = await CartRequest.getCarts();
  }

  Future<void> _getInfo() async {
    user = await UserRequest.info();
  }

  Future<void> _initializeData() async {
    await _getInfo();
    await _getCart();
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

  void getAddressData(Address data) {
    setState(() {
      address = data;
      isAddressSelected = true;
    });
  }

  Future<bool> _order() async {
    try {
      String payment = _paymentMethod.toString().split('.').last;
      Order order = await OrderRequest.addOrder(Order.fromJson(
          {'payment_method': payment, 'address': address.id.toString()}));
      String? orderId;
      if (order.id != null) {
        orderId = order.id;
        for (var cart in carts) {
          await OrderItemRequest.addOrderItem(
            order.id!,
            OrderItem.fromJson({
              'product': cart.product?.toJson(),
              'quantity': cart.quantity,
            }),
          );
        }
        print("true");
        return true;
      }
      return false;
    } on Exception catch (e) {
      // return false;
      throw Exception(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  PaymentMethod? _paymentMethod = PaymentMethod.COD;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: headerForDetail("Thanh toán"),
      bottomNavigationBar: _submitButton("Đặt hàng", context),
      body: isLoading
          ? Center(child: const CircularProgressIndicator())
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // _subNav(),
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
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
                      const SizedBox(
                        height: 10,
                      ),
                      _totalRow("Quỹ từ thiện", (_totalPrice()*0.1)),
                      _totalRow("Giá trị sản phẩm", _totalPrice()),
                      // _totalRow("Giá vận chuyển", "0"),
                      _totalRow("Giá trị đơn hàng",( _totalPrice()*1.1),
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => OrderAddressPage(
                                            saveAddress: getAddressData,
                                          )));
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  decoration: const BoxDecoration(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Địa chỉ',
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
                                      isAddressSelected
                                          ? _addressCard(address)
                                          : Container()
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
                                      // Container(
                                      //   child: RadioListTile(
                                      //     title: Text("MoMo"),
                                      //     groupValue: _paymentMethod,
                                      //     value: PaymentMethod.MoMo,
                                      //     onChanged: (PaymentMethod? value) {
                                      //       setState(() {
                                      //         _paymentMethod = value;
                                      //       });
                                      //     },
                                      //   ),
                                      // )
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
                formatPrice(cartItem.product!.price! * cartItem.quantity!.toDouble()),
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

  Widget _submitButton(String title, BuildContext context) {
    return InkWell(
      onTap: () async {

        if (isAddressSelected) {
          var success = await _order();
          if (success) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shadowColor: Colors.grey[300],
                  alignment: Alignment.center,
                  content: Text(
                    "Đặt hàng thành công",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                );
              },
            );
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context).pop(); // Tự động đóng AlertDialog sau 2 giây
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            });
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shadowColor: Colors.grey[300],
                  alignment: Alignment.center,
                  content: Text(
                    "Đặt hàng không thành công",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                );
              },
            );
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context).pop();
            });
          }
        }
        else{
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shadowColor: Colors.grey[300],
                alignment: Alignment.center,
                content: Text(
                  "Vui lòng chọn địa chỉ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              );
            },
          );
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(); // Tự động đóng AlertDialog sau 2 giây
          });
        }
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

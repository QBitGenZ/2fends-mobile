import 'package:fends_mobile/networks/cart_request.dart';
import 'package:fends_mobile/pages/home/start_page.dart';
import 'package:fends_mobile/pages/index.dart';

import 'package:fends_mobile/pages/order/order_page.dart';
import 'package:fends_mobile/pages/order/payment_page.dart';
import 'package:fends_mobile/pages/order/status_order_page.dart';
import 'package:fends_mobile/pages/product/product_detail_page.dart';
import 'package:fends_mobile/sections/home/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../app_config.dart';
import '../../constants/recomment_product.dart';

import '../../models/cart_item.dart';
import '../../models/product.dart';

import '../chat/chat_page.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late double screenHeight;
  late double screenWidth;
  late List<CartItem> carts;
  // bool isLoading = true;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   initData();
  // }
  //
  // Future<List<CartItem>> getCarts() async {
  //   final cart = await CartRequest.getCarts();
  //   return cart;
  // }
  //
  // void initData() async {
  //   carts = await getCarts();
  //   setState(() {
  //     isLoading = false;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _header(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subNav(),
              Expanded(child: _buildCart()),
            ],
          ),
        ),
        // bottomNavigationBar:
      ),
    );
  }

  Widget listItem(CartItem cart) {
    return Dismissible(
      key: Key(cart.id.toString()),
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {

        if (direction == DismissDirection.endToStart) {
          var success = await CartRequest.deleteFromCart(cart.id.toString());
          if (success) {
            setState(() {
              // initData();
            });
          }
        }
        // setState(() {
        //
        // });
      },
      child: ListTile(
        title: InkWell(
          onTap: () {
            // Điều hướng đến trang chi tiết sản phẩm và truyền dữ liệu sản phẩm
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                      product: cart.product ??
                          new Product())),
            );
          },
          child: Container(
            width: screenWidth,
            child: Row(
              children: [
                cart.product?.productImage != null &&
                        cart.product!.productImage!.isNotEmpty
                    ? Image.network(
                        AppConfig.IMAGE_API_URL +
                            cart.product!.productImage![0].src.toString(),
                        height: 120,
                        width: 120,
                        fit: BoxFit.contain,
                      )
                    : Image.asset("assets/images/fake.png"),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cart.product!.name.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        formatPrice(cart.product!.price ?? 0),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Kích cỡ:  ' + cart.product!.size.toString(),
                        style: TextStyle(
                          color: Color(0xFFB2B2B2),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Độ mới:  ' + cart.product!.degree.toString(),
                        style: TextStyle(
                          color: Color(0xFFB2B2B2),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFF7C7C7C)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        // height: 20,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                onTap: () async {
                                  if (cart.quantity != 1) {
                                    var success = await CartRequest.addToCart(
                                        cart.product!.id.toString(), '-1');
                                    if (success) {
                                      setState(() {});
                                    }
                                  }
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 20,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              cart.quantity.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () async {
                                  if (cart.quantity! <
                                      (cart.product!.quantity! -
                                          cart.product!.sold!.toInt())) {
                                    var success = await CartRequest.addToCart(
                                        cart.product!.id.toString(), '1');
                                    if (success) {
                                      setState(() {});
                                    }
                                  }
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 20,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      cart.product!.quantity! - cart.product!.sold! == 0
                          ? Text(
                              "Sản phẩm đã hết",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  double totalPrice(List<CartItem> cart) {
    return cart
        .map((item) =>
            (item.product!.price!.toDouble() * item.quantity!.toInt()))
        .reduce((value, element) => value + element);
  }

  Container payContainer(List<CartItem> carts) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    double total = carts.isNotEmpty ? totalPrice(carts) : 0;

    return Container(
      decoration: BoxDecoration(color: Color(0xFFFAFAFA)),
      width: screenWidth,
      // height: screenHeight * 0.3125,
      child: Column(
        children: [
          _buildTotalRow('Quỹ từ thiện', total * 0.1),
          _buildTotalRow("Tổng giá trị sản phẩm", total),
          _buildTotalRow('Tổng đơn hàng', total * 1.1),
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
          InkWell(
            onTap: (){
              bool check = true;
              for (var element in carts) {
                check = element.product!.quantity != element.product!.sold && check;
              }
              if(check) {
                Navigator.of(context)
                    .push(
                    MaterialPageRoute(builder: (context) => PaymentPage()));
              }
              else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shadowColor: Colors.grey[300],
                      alignment: Alignment.center,
                      content: Text(
                        "Có sản phẩm đã hết trong giỏ hàng\nVui lòng xóa sản phẩm",
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
                  Navigator.pop(context);
                });
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: 0.04125 * screenHeight),
              width: 0.83333 * screenWidth,
              height: screenHeight * 0.0625,
              decoration: ShapeDecoration(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
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
          ),
        ],
      ),
    );
  }

  Container _buildTotalRow(String title, double total) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(
                title,
                style: TextStyle(
                  color: Color(0xFF858585),
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 30),
            child: Text(
              formatPrice(total),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          )
        ],
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

  Widget subNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: _subnavItem("Giỏ hàng", true)),
        InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => OrderPage()));
            },
            child: _subnavItem("Đơn hàng", false)),
        // InkWell(
        //     onTap: () {
        //       Navigator.of(context)
        //           .push(MaterialPageRoute(builder: (context) => ChatPage()));
        //     },
        //     child: _subnavItem("Chat", false))
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
            side: BorderSide(width: 1.5, color: Color(0xFF707070)),
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

  AppBar _header([String? title]) {
    return AppBar(
      leading: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MainPage()));
          },
          child: Icon(Icons.arrow_back_ios_new)),
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

  Widget _buildCart() {
    return FutureBuilder(future: CartRequest.getCarts(), builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox();
            }
            if (snapshot.hasError) {
              return Text('Đã xảy ra lỗi: ${snapshot.error}');
            }
            carts = snapshot.data!;
            if (carts!.isNotEmpty)
              return Column(
                children: [
                  Expanded(child: ListView(children: carts.map((e) => listItem(e)).toList()),),
                  Container(child: payContainer(carts),)
                ],
              );
            else
              return Column(
                children: [
                  Expanded(child: Container(),),
                  Container(child: payContainer([]),)
                ],
              );

    });
  }
}

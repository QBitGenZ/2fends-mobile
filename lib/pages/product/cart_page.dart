import 'package:fends_mobile/constants/recomment_product.dart' as Constains;
import 'package:fends_mobile/constants/user_data.dart';
import 'package:fends_mobile/models/index.dart';
import 'package:fends_mobile/networks/cart_request.dart';
import 'package:fends_mobile/networks/product_request.dart';
import 'package:fends_mobile/pages/order/order_page.dart';
import 'package:fends_mobile/pages/product/product_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_config.dart';
import '../../constants/recomment_product.dart';
import '../../constants/recomment_product.dart';
import '../../models/cart.dart';
import '../../models/product.dart';
import '../../widgets/header_for_detail.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late double screenHeight;
  late double screenWidth;
  late List<Cart> carts;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: headerForDetail('Giỏ hàng'),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: headerForDetail('Giỏ hàng'),
          // child: context.findAncestorStateOfType(),
        ),
        body: FutureBuilder(
          future: CartRequest.getCarts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('Đã xảy ra lỗi: ${snapshot.error}');
            }
            carts = snapshot.data!;
            if (carts!.isNotEmpty)
              return ListView(children: carts.map((e) => list(e)).toList());
            else
              return SizedBox();
          },
        ),
        bottomNavigationBar: FutureBuilder(
            future: CartRequest.getCarts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox();
              }
              if (snapshot.hasError) {
                return Text('Đã xảy ra lỗi: ${snapshot.error}');
              }
              carts = snapshot.data!;
              if (carts!.isNotEmpty)
                return payContainer(carts);
              else
                return SizedBox();
            }),
      ),
    );
  }

  Widget list(Cart cart) {
    return Dismissible(
      key: Key(cart.id.toString()),
      // background: Container(
      //   color: Colors.green,
      //   child: Icon(Icons.add),
      //   alignment: Alignment.centerLeft,
      //   padding: EdgeInsets.only(left: 20.0),
      // ),
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        setState(() {});
        if (direction == DismissDirection.endToStart) {
          var success = await CartRequest.deleteFromCart(cart.id.toString());
          if (success) {
            setState(() {});
          }
        }
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
                          new Product())), // Thay đổi index bằng vị trí sản phẩm bạn muốn truyền vào
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
                                  var success = await CartRequest.addToCart(
                                      cart.product!.id.toString(), '1');
                                  if (success) {
                                    setState(() {});
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
                      )
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

  double totalPrice(List<Cart> cart) {
    return cart
        .map((item) =>
            (item.product!.price!.toDouble() * item.quantity!.toInt()))
        .reduce((value, element) => value + element);
  }

  Container payContainer(List<Cart> carts) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    double total = totalPrice(carts);

    return Container(
      decoration: BoxDecoration(color: Color(0xFFFAFAFA)),
      width: screenWidth,
      height: screenHeight * 0.3125,
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.075,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0.045 * screenWidth, 0, 150, 0),
                  child: Text(
                    'Mã giảm giá',
                    style: TextStyle(
                      color: Color(0xFF858585),
                      fontSize: 15,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    formatPrice(120),
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
            height: screenHeight * 0.075,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0.045 * screenWidth, 0, 125, 0),
                  child: Text(
                    'Tổng thanh toán',
                    style: TextStyle(
                      color: Color(0xFF858585),
                      fontSize: 15,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                Container(
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
          InkWell(
            onTap: () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => OrderPage()))
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
}

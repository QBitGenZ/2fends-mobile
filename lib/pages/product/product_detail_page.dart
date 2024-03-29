import 'package:fends_mobile/app_config.dart';
import 'package:fends_mobile/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/navbar.dart';
import '../../constants/recomment_product.dart';
import '../../models/cart.dart';
import '../../models/product_image.dart';
import '../../widgets/navbar.dart';
import '../index.dart';
import 'cart_page.dart';

import 'package:fends_mobile/networks/cart_request.dart';

class ProductDetailPage extends StatefulWidget {
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
  final Product product;
  // final List<ProductImage> productImage;

  ProductDetailPage({Key? key, required this.product}) : super(key: key);
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late double screenHeight;
  late double screenWidth;
  late String selectedTitle;

  void updateSelectedTitle(String title) {
    setState(() {
      selectedTitle = title;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedTitle = navbar[0].title;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
                bottom: 0,
                child: Navbar(
                  selectedTitle: selectedTitle,
                  updateSelectedTitle: updateSelectedTitle,
                )),
            Positioned(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Image.network(AppConfig.IMAGE_API_URL +
                      widget.product.productImage![0].src.toString(),
                      width: screenWidth,
                      height: screenHeight * 0.49,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(screenWidth * 0.043055,
                          screenHeight * 0.021686, screenWidth * 0.043055, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Text(
                              widget.product.name.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Text(
                              widget.product.size.toString(),
                              style: TextStyle(
                                color: Color(0xFF5A5A5A),
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: screenHeight * 0.021686),
                            child: Text(
                              formatPrice(widget.product.price!.toDouble()),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: screenHeight * 0.021686),
                            width: screenWidth * 340 / 360,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFADADAD),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'Mô tả sản phẩm',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    widget.product.productDetail![0].text.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 70,
              child: Container(
                decoration: BoxDecoration(color: Color(0x63DBDBDB)),
                width: screenWidth,
                height: screenHeight * 50 / 830,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        bool success = await CartRequest.addToCart(widget.product.id.toString(), "1");
                        if (success) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shadowColor: Colors.grey[300],
                                alignment: Alignment.center,
                                content: Text(
                                  "Bạn đã chọn ${widget.product.name}",
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
                            Navigator.of(context)
                                .pop(); // Tự động đóng AlertDialog sau 2 giây
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => CartPage()),
                            );
                          });
                        }
                        else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shadowColor: Colors.grey[300],
                                alignment: Alignment.center,
                                content: Text(
                                  "Thêm không thành công",
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
                        }

                      },

                      child: Container(
                        width: screenWidth * 150 / 360,
                        alignment: Alignment.center,
                        height: screenHeight * 30 / 830,
                        decoration: BoxDecoration(color: Colors.white),
                        margin: EdgeInsets.fromLTRB(
                            screenWidth * 17 / 360,
                            screenHeight * 10 / 830,
                            screenWidth * 26 / 360,
                            screenHeight * 10 / 830),
                        child: Text(
                          'Thêm vào giỏ hàng',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 150 / 360,
                      alignment: Alignment.center,
                      height: screenHeight * 30 / 830,
                      decoration: BoxDecoration(color: Colors.black),
                      margin: EdgeInsets.fromLTRB(0, screenHeight * 10 / 830,
                          screenWidth * 17 / 360, screenHeight * 10 / 830),
                      child: Text(
                        'Mua hàng',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
                left: 10,
                child:
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ))

          ],
        ),
      ),
    );
  }
}

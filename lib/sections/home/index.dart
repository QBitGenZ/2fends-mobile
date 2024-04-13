import 'package:fends_mobile/networks/product_request.dart';
import 'package:fends_mobile/pages/product/cart_page.dart';
import 'package:fends_mobile/pages/sales/HorizontalList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/index.dart';
import '../../models/product.dart';

import '../recomment_product_section.dart';

class HomeSection extends StatefulWidget {
  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      // height: MediaQuery.of(context).size.height - 68,
      child: Column(
        children: [
          HeaderImage(context),
          Container(
            alignment: Alignment.centerLeft,
            width: screenWidth,
            padding: EdgeInsets.only( left: 10),
            child: Text(
              'Tất cả sản phẩm',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: FutureBuilder(
                  future: ProductRequest.GetProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Container(height: 50, width: 50,child: CircularProgressIndicator()));
                    }
                    if (snapshot.hasError) {
                      return Text('Đã xảy ra lỗi: ${snapshot.error}');
                    }
                    var products = snapshot.data;

                    // return RecommentProductSection(Products: products ?? []);
                    return RecommentProductSection();
                  }),
              // child: RecommentProductSection(),
            ),
          ),
        ],
      ),
    );
  }

  Container HeaderImage(BuildContext context) {
    return Container(
      height: 360,
      width: screenWidth,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
                width: screenWidth,
                child: const Image(
                  image: AssetImage('assets/images/home/background.png'),
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
              right: 20,
              top: 70,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
                child: Container(
                  child: Icon(
                    Icons.menu,
                    size: 40,
                  ),
                ),
              )),
          const Positioned(
              top: 120,
              left: 20,
              child: SizedBox(
                width: 186,
                height: 118,
                child: Text(
                  'Item hot bạn \nkhông nên bỏ lỡ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    shadows: [
                      Shadow(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        blurRadius: 5, // Độ mờ của bóng
                        offset: Offset(
                            2, 2), // Độ dịch chuyển của bóng theo trục X và Y
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

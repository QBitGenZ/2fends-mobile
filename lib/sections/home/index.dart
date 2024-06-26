import 'package:fends_mobile/networks/product_request.dart';
import 'package:fends_mobile/pages/product/cart_page.dart';
import 'package:fends_mobile/pages/sales/HorizontalList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

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
      width: screenWidth,
      // height: MediaQuery.of(context).size.height - 68,
      child: Column(
        children: [
          HeaderImage(context),
          Container(
            alignment: Alignment.centerLeft,
            width: screenWidth,
            padding: EdgeInsets.only(left: 10),
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
                  future: ProductRequest.getProducts(),
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
                height: 360,
                child: const Image(
                  image: AssetImage('assets/images/startpage.jpg'),
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
           Positioned(
              top: 80,
              left: 20,
              child: SizedBox(
                // width: 186,
                height: 118,
                child: Text(
                    '''Nâng niu những điều đã cũ\n      Đồng hành và trao sự yêu thương!''',
                    style: GoogleFonts.lobster(
                      textStyle: TextStyle(
                        color: Color(0xffA65644),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: 0,
                        shadows: [
                          Shadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    )
                ),
              )),
        ],
      ),
    );
  }
}

import 'package:fends_mobile/app_config.dart';
import 'package:fends_mobile/pages/index.dart';
import 'package:fends_mobile/sections/recomment_product_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/index.dart';
import '../models/product.dart';
import '../pages/product/product_detail_page.dart';

class HorizontalList extends StatelessWidget {
  final String title;
  final List<Product> products;
  late double screenWidth;

  HorizontalList({Key? key, required this.title, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Container(
            width: screenWidth,
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RecommentProductSection(Products: products)),
                    );
                  },
                  child: Text(
                    'Xem tất cả',
                    style: TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: screenWidth,
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: products
                  .map((e) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: e,
                        ),
                      ),
                    );
                  },
                  child: ProductItem(product: e)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(8.0),
      child: ListView(

        children: [
          product.productImage != null && product.productImage!.isNotEmpty
              ? Image.network(
                  AppConfig.IMAGE_API_URL +
                      product.productImage![0].src.toString(),
                  height: 120, width: 120,)
              : Image.asset('assets/images/fake.png'),
          Center(
            child: Text(
              product.name.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          Center(
            child: Text(
              product.price.toString(),
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
    );
  }
}


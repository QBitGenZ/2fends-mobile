import 'package:fends_mobile/pages/index.dart';
import 'package:fends_mobile/sections/recomment_product_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/index.dart';
import '../models/product.dart';

class HorizontalList extends StatelessWidget {
  final String title;
  final List<Product> products;
  late double screenWidth;

  HorizontalList({Key? key, required this.title, required this.products}) : super(key: key);

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
                      MaterialPageRoute(builder: (context) => RecommentProductSection(Products: products)),
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
            height: 190,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: products.map((e) => ProductItem(product: e)).toList(),
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
      width: 125,
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          // Image(image: AssetImage(product.productImage[0].toString()), ),
          Image.network("https://bizweb.dktcdn.net/100/393/859/products/aa05eb0d94a869c571dfbc5a04c2dcc0-1664351250542.jpg?v=1680139537870",
          height: 100),
          Text(
            product.name.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          Text(
            product.price.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}

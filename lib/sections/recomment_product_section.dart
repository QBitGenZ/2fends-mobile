import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/recomment_product.dart';

class RecommentProductSection extends StatefulWidget {
  @override
  State<RecommentProductSection> createState() => _RecommentProductSectionState();
}

class _RecommentProductSectionState extends State<RecommentProductSection> {
  late double screenHeight;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 90),
              child: Column(
                children: [
                  for (int i = 0; i < recommentproduct.length; i += 2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (i < recommentproduct.length)
                          InkWell(
                            onTap: () {
                              // Xử lý khi người dùng nhấn vào sản phẩm
                            },
                            child: ItemList(
                              imagePath: recommentproduct[i].imagePath,
                              productName: recommentproduct[i].productName,
                              formatPrice: formatPrice(recommentproduct[i].price),
                            ),
                          ),
                        if (i + 1 < recommentproduct.length)
                          InkWell(
                            onTap: () {
                              // Xử lý khi người dùng nhấn vào sản phẩm
                            },
                            child: ItemList(
                              imagePath: recommentproduct[i + 1].imagePath,
                              productName: recommentproduct[i + 1].productName,
                              formatPrice: formatPrice(recommentproduct[i + 1].price),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ItemList extends StatefulWidget {
  final String imagePath;
  final String productName;
  final String formatPrice;

  const ItemList({
    Key? key,
    required this.imagePath,
    required this.productName,
    required this.formatPrice,
  }) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(
            widget.imagePath,
          ),
          Text(
            widget.productName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          Text(
            widget.formatPrice,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          )
        ],
      ),
    );
  }
}

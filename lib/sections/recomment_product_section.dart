import 'package:fends_mobile/constants/recomment_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import '../constants/recomment_product.dart';
import '../pages/product/product_detail_page.dart';

import '../models/product.dart';

class RecommentProductSection extends StatefulWidget {
  final List<Product> Products;
  RecommentProductSection({Key? key, required this.Products}) : super(key: key);
  @override
  State<RecommentProductSection> createState() =>
      _RecommentProductSectionState();
}

class _RecommentProductSectionState extends State<RecommentProductSection> {
  late double screenHeight;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: screenWidth,
            margin: EdgeInsets.fromLTRB(60, 90, 60, 0),
            child: Column(
              children: [
                for (int i = 0; i < widget.Products.length; i += 2)
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (i < widget.Products.length)
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailPage(
                                        product: widget.Products[i])), 
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 20),
                              child: ItemList(
                                imagePath: "assets/images/fake.png",
                                productName: widget.Products[i].name.toString(),
                                formatPrice:
                                    formatPrice(widget.Products[i].price ?? 0)
                                        .toString(),
                              ),
                            ),
                          ),
                        if (i + 1 < widget.Products.length)
                          InkWell(
                            onTap: () {
                              // Điều hướng đến trang chi tiết sản phẩm và truyền dữ liệu sản phẩm
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailPage(
                                        product: widget.Products[i + 1])), // Thay đổi index bằng vị trí sản phẩm bạn muốn truyền vào
                              );
                            },
                            child: ItemList(
                              imagePath: "assets/images/fake.png",
                              productName: widget.Products[i+1].name.toString(),
                              formatPrice:
                                  formatPrice(widget.Products[i+1].price ?? 0)
                                      .toString(),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
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

import 'package:fends_mobile/constants/recomment_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import '../constants/recomment_product.dart';
import '../app_config.dart';
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
    print(widget.Products.length);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(),
            child: Column(
              children: [
                if (widget
                    .Products.isNotEmpty) // Check if Products list is not empty
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
                                      product: widget.Products[i],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(right: 20),
                                child: ItemList(
                                  imagePath:
                                      widget.Products[i].productImage !=
                                                  null &&
                                              widget.Products[i]
                                                  .productImage!.isNotEmpty
                                          ? widget.Products[i]
                                              .productImage![0].src
                                              .toString()
                                          : '',
                                  productName:
                                      widget.Products[i].name.toString(),
                                  formatPrice:
                                      formatPrice(widget.Products[i].price ?? 0)
                                          .toString(),
                                ),
                              ),
                            ),
                          if (i + 1 < widget.Products.length)
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailPage(
                                      product: widget.Products[i + 1],
                                    ),
                                  ),
                                );
                              },
                              child: ItemList(
                                imagePath:
                                    widget.Products[i + 1].productImage !=
                                                null &&
                                            widget.Products[i + 1].productImage!
                                                .isNotEmpty
                                        ? widget.Products[i + 1]
                                            .productImage![0].src
                                            .toString()
                                        : '',
                                productName:
                                    widget.Products[i + 1].name.toString(),
                                formatPrice: formatPrice(
                                        widget.Products[i + 1].price ?? 0)
                                    .toString(),
                              ),
                            ),
                        ],
                      ),
                    ),
                if (widget.Products
                    .isEmpty) // Handle case when Products list is empty
                  Text("No products available"),
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
          if (widget.imagePath == '')
            Image.asset('assets/images/fake.png')
          else
          Image.network(
            AppConfig.IMAGE_API_URL + widget.imagePath,
            width: 125 / 360 * MediaQuery.of(context).size.width,
            height: 125 / 360 * MediaQuery.of(context).size.width,
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

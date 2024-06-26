import 'package:fends_mobile/app_config.dart';
import 'package:fends_mobile/constants/recomment_product.dart';
import 'package:fends_mobile/pages/index.dart';
import 'package:fends_mobile/pages/sales/edit_product_page.dart';
import 'package:fends_mobile/pages/sales/see_all_product.dart';
import 'package:fends_mobile/sections/recomment_product_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/index.dart';
import '../../models/product.dart';
import '../product/product_detail_page.dart';

class HorizontalList extends StatefulWidget {
  final String title;
  final List<Product> products;
  bool? canEdit = true;

  HorizontalList({Key? key, required this.title, required this.products, this.canEdit = true})
      : super(key: key);

  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  late double screenWidth;

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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),

                                    ),
                  ),
                Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SeeAllProduct(canEdit: widget.canEdit!,)),
                      );
                    },
                    child:
                    Text(
                      'Xem tất cả',
                      style: TextStyle(
                        color: Color(0xFF929292),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
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
              children: widget.products
                  .map((e) => InkWell(
                  onTap: () {
                    if(widget.canEdit!=null && widget.canEdit!) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProductPage(
                                product: e,
                              ),
                        ),
                      );
                    }
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
              formatPrice(product.price!),
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

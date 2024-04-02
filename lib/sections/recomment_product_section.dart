import 'package:fends_mobile/constants/recomment_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import '../constants/recomment_product.dart';
import '../app_config.dart';
import '../models/cart.dart';
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
            child: Wrap(
                children:
                    widget.Products.map((e) => buildItem(context, e)).toList()),
          ),
        ],
      ),
    );
  }

  InkWell buildItem(BuildContext context, Product product) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(right: 20),
        child: ItemList(
          imagePath:
              product.productImage != null && product.productImage!.isNotEmpty
                  ? product.productImage![0].src.toString()
                  : '',
          productName: product.name.toString(),
          formatPrice: formatPrice(product.price ?? 0).toString(),
        ),
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
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (widget.imagePath == '')
            Image.asset('assets/images/fake.png')
          else
            Image.network(
              AppConfig.IMAGE_API_URL + widget.imagePath,
              width: 125 / 360 * MediaQuery.of(context).size.width,
              height: 125 / 360 * MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
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

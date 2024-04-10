// import 'package:fends_mobile/constants/recomment_product.dart';
// import 'package:fends_mobile/networks/product_request.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// // import '../constants/recomment_product.dart';
// import '../app_config.dart';
// import '../models/cart.dart';
// import '../pages/product/product_detail_page.dart';
//
// import '../models/product.dart';
//
// class RecommentProductSection extends StatefulWidget {
//   List<Product> Products = [];
//   // RecommentProductSection({Key? key}) : super(key: key);
//   @override
//   State<RecommentProductSection> createState() =>
//       _RecommentProductSectionState();
// }
//
// class _RecommentProductSectionState extends State<RecommentProductSection> {
//   late double screenHeight;
//   late double screenWidth;
//
//   static int page = 1;
//   final ScrollController _sc = ScrollController();
//   bool isLoading = false;
//
//   void initState() {
//     this._getMoreData(page);
//     super.initState();
//     _sc.addListener(() {
//       if (_sc.position.pixels ==
//           _sc.position.maxScrollExtent) {
//         _getMoreData(page);
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _sc.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     screenWidth = MediaQuery.of(context).size.width;
//     screenHeight = MediaQuery.of(context).size.height;
//     print(widget.Products.length);
//
//     return Container(
//       alignment: Alignment.center,
//       width: screenWidth,
//       height: 400 / 800 * screenHeight,
//       child: ListView.builder(
//         itemCount: (widget.Products.length / 2).ceil(),
//         controller: _sc,
//         itemBuilder: (context, rowIndex) {
//           if (rowIndex == widget.Products.length)
//             return _buildProgressIndicator();
//           final firstItemIndex = rowIndex * 2;
//           final secondItemIndex = firstItemIndex + 1;
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (firstItemIndex < widget.Products.length)
//                 buildItem(context, widget.Products[firstItemIndex]),
//               if (secondItemIndex < widget.Products.length)
//                 buildItem(context, widget.Products[secondItemIndex]),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   InkWell buildItem(BuildContext context, Product product) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetailPage(
//               product: product,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.only(right: 20),
//         child: ItemList(
//           imagePath:
//               product.productImage != null && product.productImage!.isNotEmpty
//                   ? product.productImage![0].src.toString()
//                   : '',
//           productName: product.name.toString(),
//           formatPrice: formatPrice(product.price ?? 0).toString(),
//         ),
//       ),
//     );
//   }
//
//   void _getMoreData(int index) async {
//     if (!isLoading) {
//       setState(() {
//         isLoading = true;
//       });
//       final response = await ProductRequest.GetProducts(page:index);
//       print(response);
//       setState(() {
//         isLoading = false;
//         page++;
//         widget.Products.addAll(response);
//       });
//     }
//   }
//
//   Widget _buildProgressIndicator() {
//     return new Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: new Center(
//         child: new Opacity(
//           opacity: isLoading ? 1.0 : 00,
//           child: new CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }
//
// class ItemList extends StatefulWidget {
//   final String imagePath;
//   final String productName;
//   final String formatPrice;
//
//   const ItemList({
//     Key? key,
//     required this.imagePath,
//     required this.productName,
//     required this.formatPrice,
//   }) : super(key: key);
//
//   @override
//   State<ItemList> createState() => _ItemListState();
// }
//
// class _ItemListState extends State<ItemList> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           if (widget.imagePath == '')
//             Image.asset('assets/images/fake.png')
//           else
//             Image.network(
//               AppConfig.IMAGE_API_URL + widget.imagePath,
//               width: 125 / 360 * MediaQuery.of(context).size.width,
//               height: 125 / 360 * MediaQuery.of(context).size.width,
//               fit: BoxFit.cover,
//             ),
//           Text(
//             widget.productName,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 13,
//               fontFamily: 'Roboto',
//               fontWeight: FontWeight.w500,
//               height: 0,
//             ),
//           ),
//           Text(
//             widget.formatPrice,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 13,
//               fontFamily: 'Roboto',
//               fontWeight: FontWeight.w400,
//               height: 0,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_config.dart';
import '../models/product.dart';
import '../pages/product/product_detail_page.dart';
import '../networks/product_request.dart';

class RecommentProductSection extends StatefulWidget {
  // final List<Product> Products;
  List<Product> Products = [];

  // RecommentProductSection({Key? key, required this.Products}) : super(key: key);

  @override
  _RecommentProductSectionState createState() => _RecommentProductSectionState();
}

class _RecommentProductSectionState extends State<RecommentProductSection> {
  late double screenHeight;
  late double screenWidth;

  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _getMoreData(currentPage);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _getMoreData(currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Container(
      alignment: Alignment.center,
      width: screenWidth,
      height: 400 / 800 * screenHeight,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: (widget.Products.length / 2).ceil(),
        controller: _scrollController,
        itemBuilder: (context, rowIndex) {
          if (rowIndex == widget.Products.length)
            return Container();
          final firstItemIndex = rowIndex * 2;
          final secondItemIndex = firstItemIndex + 1;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (firstItemIndex < widget.Products.length)
                buildItem(context, widget.Products[firstItemIndex]),
              if (secondItemIndex < widget.Products.length)
                buildItem(context, widget.Products[secondItemIndex]),
            ],
          );
        },
      ),
    );
  }

  Widget buildItem(BuildContext context, Product product) {
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
          imagePath: product.productImage != null && product.productImage!.isNotEmpty
              ? product.productImage![0].src.toString()
              : '',
          productName: product.name.toString(),
          formatPrice: formatPrice(product.price ?? 0).toString(),
        ),
      ),
    );
  }

  Future<void> _getMoreData(int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      final response = await ProductRequest.GetProducts(page: page);

      setState(() {
        isLoading = false;
        widget.Products.addAll(response);
        currentPage = currentPage + 1;

      });
    }
  }
}

class ItemList extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (imagePath.isEmpty)
            Image.asset('assets/images/fake.png')
          else
            Image.network(
              AppConfig.IMAGE_API_URL + imagePath,
              width: 125 / 360 * MediaQuery.of(context).size.width,
              height: 125 / 360 * MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          Text(
            productName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          Text(
            formatPrice,
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

String formatPrice(double price) {
  return '\$$price'; // You can implement your own price formatting logic here
}
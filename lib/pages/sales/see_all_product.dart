import 'package:fends_mobile/pages/sales/edit_product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_config.dart';
import '../../models/product.dart';
import '../../pages/product/product_detail_page.dart';
import '../../networks/product_request.dart';

class SeeAllProduct extends StatefulWidget {
  List<Product> Products = [];
  late bool canEdit = false;

  SeeAllProduct({super.key, this.canEdit = false});

  @override
  _SeeAllProductState createState() => _SeeAllProductState();
}

class _SeeAllProductState extends State<SeeAllProduct> {
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
    print(widget.canEdit);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _getMoreData(currentPage);
    }
  }

  Future<void> _getMoreData(int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      final response = await ProductRequest.getMyProducts(page: page);
      final List<Product>products = [];
      if (widget.canEdit!=null && widget.canEdit!) {
        products.addAll(response!.where((product) => product.quantity != product.sold).toList());

      }
      else{
        products.addAll(response!.where((product) => product.quantity == product.sold).toList());
      }

      setState(() {
        isLoading = false;
        widget.Products.addAll(products);
        currentPage = currentPage + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: headerForDetail('Danh sách sản phẩm'),
        body: Container(
          alignment: Alignment.center,
          width: screenWidth,
          height: screenHeight,
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: (widget.Products.length / 2).ceil(),
            controller: _scrollController,
            itemBuilder: (context, rowIndex) {
              if (rowIndex == widget.Products.length) return Container();
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
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, Product product) {
    return InkWell(
      onTap: () {
        if (widget.canEdit!=null && widget.canEdit!) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditProductPage(product: product)
            ),
          );
        }
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



  AppBar headerForDetail([String? title]) {
    return AppBar(
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new)),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: title != null
          ? Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          height: 0,
        ),
      )
          : const SizedBox(),
    );
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
    return ListProducts(
        imagePath: imagePath,
        productName: productName,
        formatPrice: formatPrice);
  }
}

class ListProducts extends StatelessWidget {
  const ListProducts({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.formatPrice,
  });

  final String imagePath;
  final String productName;
  final String formatPrice;

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
  return '${price.toInt()} VND'; // You can implement your own price formatting logic here
}
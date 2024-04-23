import 'dart:async';

import 'package:fends_mobile/models/product_type.dart';
import 'package:fends_mobile/networks/product_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/product.dart';
import '../../sections/recomment_product_section.dart';
import '../product/product_detail_page.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  late List<Product> products = [];

  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _getMoreData(currentPage, searchController.text.toString());
    }
  }

  Future search(int page, String keyword) async {
    products = await ProductRequest.search(keyword: keyword, page: page);
  }

  Future<void> _getMoreData(int page, String keyword) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      final response = await ProductRequest.search(keyword: keyword, page: page);

      setState(() {
        isLoading = false;
        products.addAll(response);
        currentPage = currentPage + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tìm kiếm',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        leading: SizedBox(),
        centerTitle: true,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 20),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFAFAFAF)),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: searchController,
                          onFieldSubmitted: (value) {
                            search(1, value);
                          },
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                  color: Colors.white,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                borderSide: BorderSide(
                                  style: BorderStyle.none,
                                  color: Colors.white,
                                ),
                              ))),
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 20),
                        child: IconButton(icon: Icon(Icons.search), onPressed: () {
                          search(1, searchController.text.toString());
                        },))
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  itemCount: products.length,
                itemBuilder: (context, rowIndex) {
                  if (rowIndex == products.length)
                    return Container();
                  final firstItemIndex = rowIndex * 2;
                  final secondItemIndex = firstItemIndex + 1;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (firstItemIndex < products.length)
                        buildItem(context, products[firstItemIndex]),
                      if (secondItemIndex < products.length)
                        buildItem(context, products[secondItemIndex]),
                    ],
                  );
                },
              ),
            )
          ]),
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
}

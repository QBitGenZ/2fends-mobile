import 'package:fends_mobile/models/donation_product.dart';
import 'package:fends_mobile/networks/event_request.dart';
import 'package:fends_mobile/networks/product_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_config.dart';
import '../../models/event.dart';
import '../../models/product.dart';

class DonationProductsList extends StatefulWidget {
  final MyEvent event;
  const DonationProductsList({super.key, required this.event});

  @override
  State<DonationProductsList> createState() => _DonationProductsListState();
}

class _DonationProductsListState extends State<DonationProductsList> {

  late double screenHeight;
  late double screenWidth;
  late List<DonationProduct> donationProducts = [];

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

  Future<void> _getMoreData(int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      final response = await EventRequest.getDonationProduct(widget.event.id.toString(), page: page);

      setState(() {
        isLoading = false;
        donationProducts.addAll(response);
        currentPage = currentPage + 1;

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      width: screenWidth,
      height: screenHeight,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: (donationProducts.length / 2).ceil(),
        controller: _scrollController,
        itemBuilder: (context, rowIndex) {
          if (rowIndex == donationProducts.length) {
            return Container();
          }
          final firstItemIndex = rowIndex * 2;
          final secondItemIndex = firstItemIndex + 1;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (firstItemIndex < donationProducts.length)
                buildItem(context, donationProducts[firstItemIndex]),
              if (secondItemIndex < donationProducts.length)
                buildItem(context, donationProducts[secondItemIndex]),
            ],
          );
        },
      ),
    );

  }

  Widget buildItem(BuildContext context, DonationProduct donationProduct) {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: DonationItemList(
        donationProduct: donationProduct,
      ),
    );
  }

}

class DonationItemList extends StatefulWidget {
  final DonationProduct donationProduct;

  const DonationItemList({
    Key? key,
    required this.donationProduct
  }) : super(key: key);

  @override
  State<DonationItemList> createState() => _DonationItemListState();
}

class _DonationItemListState extends State<DonationItemList> {
  late Product product;

  late bool isLoading = true;

  Future<void> getProduct() async {
    product = await ProductRequest.getProductByID(widget.donationProduct.product.toString());
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Container(child: CircularProgressIndicator(),) : Container(
      height: 200,
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (product.productImage != null && product.productImage!.isNotEmpty)

            Image.network(
              AppConfig.IMAGE_API_URL + product.productImage![0].src.toString(),
              width: 100 / 360 * MediaQuery.of(context).size.width,
              height: 100 / 360 * MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            )
          else Image.asset('assets/images/fake.png')
    ,
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
            'Số lượng: ${widget.donationProduct.quantity.toString()}',
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


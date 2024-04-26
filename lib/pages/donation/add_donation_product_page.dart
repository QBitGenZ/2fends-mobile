import 'package:fends_mobile/models/donation_product.dart';
import 'package:fends_mobile/networks/event_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_config.dart';
import '../../constants/recomment_product.dart';
import '../../models/event.dart';
import '../../models/product.dart';
import '../../networks/product_request.dart';
import '../../sections/recomment_product_section.dart';

class AddDonationProductPage extends StatefulWidget {
  final MyEvent event;
  AddDonationProductPage({super.key, required this.event});

  @override
  State<AddDonationProductPage> createState() => _AddDonationProductPageState();
}

class _AddDonationProductPageState extends State<AddDonationProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerForDetail("Quyên góp sản phẩm"),
      body: Container(
        alignment: Alignment.center,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
                child: Text(
                  'Vui lòng chọn sản phẩm muốn quyên góp',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
                child: Text(
                  'Lưu ý: Việc quyên góp sản phẩm bạn đã đăng bán thì các sản phẩm sẽ được quyên góp cho nhà từ thiện với giá 0đ',
                  style: TextStyle(
                    color: Color(0xFF4B4B4B),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListProductDonation(event: widget.event),
              ),
            ],
          ),
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

class ListProductDonation extends StatefulWidget {
  final MyEvent event;
  ListProductDonation({super.key, required this.event});

  @override
  State<ListProductDonation> createState() => _ListProductDonationState();
}

class _ListProductDonationState extends State<ListProductDonation> {
  late double screenHeight;
  late double screenWidth;

  late List<Product> products = [];

  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _getMoreData(currentPage);
  }

  Future<void> _getMoreData(int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      final response = await ProductRequest.getMyProducts(page: page);

      setState(() {
        isLoading = false;
        products.addAll(response);
        currentPage = currentPage + 1;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: _buildListProduct(),
    );
  }

  Widget _buildListProduct() {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: (products.length / 2).ceil(),
      controller: _scrollController,
      itemBuilder: (context, rowIndex) {
        if (rowIndex == products.length) return Container();
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
    );
  }

  Widget buildItem(BuildContext context, Product product) {
    return InkWell(
      onTap: () {
        _dialogBuilder(context, product);
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

  Future<void> _dialogBuilder(BuildContext context, Product product) {
    print(widget.event.id);
    var quantity = product.quantity;
    int quantityController = 1;
    try {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              backgroundColor:
                  Colors.transparent, // Make the background transparent
              child: Material(
                color: Colors.white,
                shadowColor: Colors.white,
                textStyle: TextStyle(color: Colors.white),
                elevation: 24, // Add some elevation for the shadow effect
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Quyên góp sản phẩm',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                product.productImage != null &&
                                        product.productImage!.isNotEmpty
                                    ? Image.network(
                                        AppConfig.IMAGE_API_URL +
                                            product.productImage![0].src
                                                .toString(),
                                        width: 125 /
                                            360 *
                                            MediaQuery.of(context).size.width,
                                        height: 125 /
                                            360 *
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset('assets/images/fake.png'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  product.name.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 100,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0xFF7C7C7C)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  // height: 20,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                          onTap: () async {
                                            if (quantityController > 1) {
                                              setState(() {
                                                quantityController -= 1;
                                              });
                                            }
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            size: 20,
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        quantityController.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                          onTap: () async {
                                            if (quantityController <
                                                (quantity ?? 1)) {
                                              setState(() {
                                                quantityController += 1;
                                              });
                                            }
                                          },
                                          child: Icon(
                                            Icons.add,
                                            size: 20,
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Hủy bỏ'),
                        ),
                        TextButton(
                          onPressed: () async {
                            var success = await EventRequest.addDonationProduct(
                                quantityController.toInt(),
                                product.id.toString(),
                                widget.event.id.toString());
                            if (success) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shadowColor: Colors.grey[300],
                                    alignment: Alignment.center,
                                    content: Text(
                                      "Quyên góp sản phẩm thành công",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  );
                                },
                              );

                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shadowColor: Colors.grey[300],
                                    alignment: Alignment.center,
                                    content: Text(
                                      "Quyên góp không thành công",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  );
                                },
                              );
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            }
                          },
                          child: const Text('Quyên góp'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        },
      );
    } on Exception catch (e) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content:
                  Text('An error occurred while adding the donation product.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }
  }
}

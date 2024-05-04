import 'package:fends_mobile/constants/recomment_product.dart';
import 'package:fends_mobile/networks/product_request.dart';
import 'package:fends_mobile/networks/statistics.dart';
import 'package:fends_mobile/pages/sales/add_product_page.dart';
import 'package:fends_mobile/pages/sales/sale_page.dart';
import 'package:fends_mobile/pages/sales/HorizontalList.dart';
import 'package:fends_mobile/widgets/header_for_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/navbar.dart';
import '../../models/product.dart';

class DepartmentStorePage extends StatefulWidget {
  const DepartmentStorePage({super.key});

  @override
  State<DepartmentStorePage> createState() => _DepartmentStorePageState();
}

class _DepartmentStorePageState extends State<DepartmentStorePage> {
  late double screenWidth;
  late String selectedTitle;

  @override
  void initState() {
    super.initState();
    selectedTitle = navbar[2].title;
  }

  void updateSelectedTitle(String title) {
    setState(() {
      selectedTitle = title;
    });
  }
  // late List<Product> products;
  // @override
  // void initState() async {
  //    products = await ProductRequest.GetProducts();
  // }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gian hàng của bạn',
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildRevenue(),
              SizedBox(
                height: 20,
              ),
              _buildAddProduct(),
              SizedBox(
                height: 20,
              ),
              Container(
                child: FutureBuilder(
                    future: ProductRequest.getMyProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Đã xảy ra lỗi: ${snapshot.error}');
                      }
                      var products = snapshot.data;
                      List<Product> inventoryProducts = [];
                      inventoryProducts = products!.where((product) => product.quantity != product.sold).toList();
                      if (inventoryProducts!.isEmpty) return Container();
                      return HorizontalList(
                          title: 'Sản phẩm còn lại',
                          products: inventoryProducts ?? [],
                      canEdit: true,);
                    }),
              ),
              const SizedBox(height: 10,),
              Container(
                child: FutureBuilder(
                    future: ProductRequest.getMyProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Đã xảy ra lỗi: ${snapshot.error}');
                      }
                      var products = snapshot.data;
                      List<Product> soldOutProducts = [];
                      soldOutProducts = products!.where((product) => product.quantity == product.sold).toList();
                      if (soldOutProducts.isEmpty) return Container();
                      return HorizontalList(
                          title: "Sản phẩm đã bán",
                          products: soldOutProducts ?? [],
                      canEdit: false,);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildRevenue() {
    return Container(
      decoration: ShapeDecoration(
        color: Color(0xFF00DF74),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Doanh thu',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FutureBuilder(
                      future: ProductRequest.getRevenue(),
                      builder: (context, snapshot) {
                        var price = snapshot.data?? 0;
                        return Text(
                          '${formatPrice(price)}',
                          style: TextStyle(
                            color: Color(0xFF161414),
                            fontSize: 32,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton.filled(
              onPressed: () {}, // TODO: chuyển sang trang doanh thu
              color: Color(0xFF00DF74),
              icon: Icon(Icons.arrow_forward_ios),
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget _buildAddProduct() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddProductPage()));
      },
      child: Container(
        decoration: ShapeDecoration(
          color: Color(0xFF0665F3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top:30.0, bottom: 30, left: 30),
                child: Text(
                  'Thêm mới sản phẩm',
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton.filled(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductPage()));
                },
                icon: Icon(Icons.arrow_forward_ios),
                color: Colors.white,
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _cardItem(Product product) {
    return Container(
      child: Stack(
        children: [
          Chip(
            elevation: 50,
            padding: EdgeInsets.all(8),
            backgroundColor: Colors.greenAccent[100],
            label: Text(
              'Đã bán',
              style: TextStyle(fontSize: 20),
            ),
          ),
          // ProductItem(product: product),
        ],
      ),
    );
  }

  Widget headerForDetail([String? title]) {
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

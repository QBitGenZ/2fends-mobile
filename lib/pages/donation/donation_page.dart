import 'package:fends_mobile/networks/product_request.dart';
import 'package:fends_mobile/pages/donation/create_donation_event_page.dart';
import 'package:fends_mobile/pages/sales/add_product_page.dart';
import 'package:fends_mobile/pages/sales/sale_page.dart';
import 'package:fends_mobile/pages/sales/HorizontalList.dart';
import 'package:fends_mobile/widgets/header_for_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/navbar.dart';
import '../../models/product.dart';
import '../../widgets/navbar.dart';
import '../index.dart';
// import 'HorizontalList.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quyên góp',
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
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _buildDonationCard(),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateDonationEventPage()));
                },
                  child: _buildCreateEvent()),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Sự kiện bạn đã tạo',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _buildListEvent(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Sản phầm chờ duyệt',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Text(
                    'Xem thêm',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _buildListProductEvent(),
              const SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      ),
    );
  }

  Row _buildCreateEvent() {
    return Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: ShapeDecoration(
                      color: Color(0xFFFFFCEC),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFD5D5D5)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Đăng ký tạo sự kiện quyên góp',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ],
            );
  }

  Widget _buildListProductEvent() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          _buildProductEventItem(),
          _buildProductEventItem(),
          _buildProductEventItem(),
        ],
      ),
    );
  }

  Container _buildProductEventItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFB5B5B5)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://cdn.boo.vn/media/catalog/product/1/_/1.2.21.2.18.006.222.23-60600034-bst-1.jpg"),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Quần dài',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Kích cỡ: XL',
                style: TextStyle(
                  color: Color(0xFF6F6F6F),
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildListEvent() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildListEventItem(),
          _buildListEventItem(),
          _buildListEventItem(),
        ],
      ),
    );
  }

  Container _buildListEventItem() {
    return Container(
      width: 225,
      margin: EdgeInsets.only(right: 30),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            side: BorderSide(color: Colors.black12)),
        shadows: [
          BoxShadow(
            color: Color(0x3F7D7D7D),
            blurRadius: 10,
            offset: Offset(0, 10),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: 225,
              height: 125,
              decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://product.hstatic.net/1000178779/product/v61w23t010_40774588_0_09600769fda74cf78243b8bd7adfa18b_master.jpg"),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F7D7D7D),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ])),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Quyên góp cùng quỹ mái ấm',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Còn lại 25 ngày',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                Icon(Icons.schedule_outlined)
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildDonationCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: ShapeDecoration(
        color: Color(0xFFEEE8DA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: OvalBorder(),
            ),
            child: Icon(
              Icons.savings_outlined,
              size: 40,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Bạn đã tạo quyên góp',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    '2 sự kiện',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Nhận 30 sản phẩm',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: ShapeDecoration(
              color: Colors.black,
              shape: OvalBorder(),
            ),
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          )
        ],
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
                      future: ProductRequest.GetRevenue(),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data.toString() + ' VND',
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
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  'Thêm mới sản phẩm',
                  textAlign: TextAlign.center,
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

import 'package:fends_mobile/models/event.dart';
import 'package:fends_mobile/pages/donation/donation_products_list.dart';
import 'package:fends_mobile/pages/donation/see_all_donation_product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../app_config.dart';
import 'add_donation_product_page.dart';

class DonationEventDetailPage extends StatefulWidget {
  late MyEvent event;
  DonationEventDetailPage({super.key, required this.event});

  @override
  State<DonationEventDetailPage> createState() =>
      _DonationEventDetailPageState();
}

class _DonationEventDetailPageState extends State<DonationEventDetailPage> {
  late double screenHeight;
  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: headerForDetail("Chi tiết sự kiện"),
      bottomNavigationBar: _button(),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: screenWidth - 30,
                height: screenWidth - 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: widget.event.image != null &&
                            widget.event.image!.isNotEmpty
                        ? NetworkImage(
                            '${AppConfig.IMAGE_API_URL}${widget.event.image}')
                        : NetworkImage(
                            "https://product.hstatic.net/1000178779/product/v61w23t010_40774588_0_09600769fda74cf78243b8bd7adfa18b_master.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '${widget.event.name.toString()}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${widget.event.user.toString()}',
                style: TextStyle(
                  color: Color(0xFF727272),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bắt đầu ${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.event.beginAt.toString()))}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Text(
                    'Còn lại ${DateTime.parse(widget.event.endAt!).difference(DateTime.now()).inDays} ngày',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${widget.event.description.toString()}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SeeAllDonationProductPage(event: widget.event)));
                },
                child: Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Xem sản phẩm quyên góp',
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
              // Expanded(child: Container( padding: EdgeInsets.only(top: 20), child: DonationProductsList(event: widget.event,)))
            ],
          ),
        ),
      ),
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddDonationProductPage(
                        event: widget.event,
                      )));
        },
        child: Row(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3F6B6B6B),
                    blurRadius: 50,
                    offset: Offset(0, 15),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: ShapeDecoration(
                  color: Color(0xFFEEE8DA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'Tham gia quyên góp',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ))
          ],
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
        child: Icon(Icons.arrow_back_ios_new),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

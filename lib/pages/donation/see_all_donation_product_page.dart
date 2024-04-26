import 'package:fends_mobile/pages/donation/donation_products_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/event.dart';

class SeeAllDonationProductPage extends StatefulWidget {
  final MyEvent event;
  const SeeAllDonationProductPage({super.key, required this.event});

  @override
  State<SeeAllDonationProductPage> createState() => _SeeAllDonationProductPageState();
}

class _SeeAllDonationProductPageState extends State<SeeAllDonationProductPage> {
  late double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: headerForDetail("Danh sách sản phẩm"),
      body: DonationProductsList(event: widget.event,),
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

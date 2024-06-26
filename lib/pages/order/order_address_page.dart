import 'package:fends_mobile/networks/user_request.dart';
import 'package:fends_mobile/pages/order/new_address_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/address.dart';
import '../../models/user.dart';
import '../../networks/address_request.dart';

class OrderAddressPage extends StatefulWidget {
  final Function(Address) saveAddress;
  OrderAddressPage({super.key, required this.saveAddress});

  @override
  State<OrderAddressPage> createState() => _OrderAddressPageState();
}

class _OrderAddressPageState extends State<OrderAddressPage> {
  late List<Address> addresses;
  late User user;
  bool isLoading = true;

  Future<void> _getAddresses() async {
    addresses = await AddressRequset.getAddresses();
  }

  Future<void> _getInfo() async {
    user = await UserRequest.info();
  }

  Future<void> _initializeData() async {
    await _getInfo();
    await _getAddresses();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerForDetail("Địa chỉ giao hàng"),
      body: isLoading
          ? Center(
              child: Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ))
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Địa chỉ vận chuyển',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Sau khi nhập địa chỉ, chúng tôi sẽ cho bạn biết chi phí giao hàng đến bạn.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: _addressList(),
                    ),
                    InkWell(
                      onTap: () async {
                        await  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewAddressPage()));
                        setState(() {
                          isLoading = true; // Set loading to true to indicate loading state
                        });
                        await _initializeData();
                      },
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 0.50),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Icon(Icons.add),
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _addressCard(Address address) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.5, color: Color(0xFF9E9E9E)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "${user.full_name}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      address.address.toString(),
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
                    Text(
                      "${user.phone}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }

  Widget _addressList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: addresses.map((e) => InkWell(
        onTap: () {
          widget.saveAddress(e);
          Navigator.pop(context);
        },
          child: _addressCard(e))).toList(),
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
              title,
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

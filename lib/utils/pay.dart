import 'dart:convert';
import 'dart:typed_data';

import 'package:fends_mobile/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fends_mobile/utils/result.dart';
import 'package:http/http.dart' as http;

class PayScreen extends StatefulWidget {
  const PayScreen({super.key, required this.money, required this.orderID});

  final String money;
  final String orderID;

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  String paymentUrl = '';

  @override
  void initState() {
    super.initState();
    // Gửi yêu cầu tạo thanh toán và nhận URL từ server
    createPaymentUrl();
  }

  void createPaymentUrl() async {
    var response = await http.post(
        Uri.parse('${AppConfig.SERVER_API_URL}/vnpay/create-url/'),
        body: {'amount': '${widget.money}', 'order': '${widget.orderID}'});
    var responseData = jsonDecode(response.body);
    var paymentUrl = responseData['data'];
    print(this.paymentUrl);

    setState(() {
      this.paymentUrl = paymentUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pay Screen"),
      ),
      body: paymentUrl != ''
          ? _buildWebView()
          : Center(
              child:
                  CircularProgressIndicator()), // Hiển thị tiến trình đang tải nếu chưa nhận được URL
    );
  }

  Widget _buildWebView() {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri(paymentUrl),
        method: 'GET',
        // headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ),
      onWebViewCreated: (controller) {
        debugPrint("Open web success");
      },
      onLoadStop: (controller, url) async {
        // var response = await controller.evaluateJavascript(source: 'document.body.innerText');
        // var code = jsonDecode(response)['code'];
        if (url.toString().contains('vnpay/payment_response/')) {
          Uri uri = Uri.parse(url.toString());
          String code = uri.queryParameters['vnp_ResponseCode'] ?? '';
          await http.get(uri);
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResultScreen(result: code)));
        }
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen(result: code)));
        // debugPrint(code);
      },
    );
  }
}

import 'dart:ffi';

import 'package:fends_mobile/networks/product_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../app_config.dart';
import '../../models/feedback.dart';
import '../../models/order.dart';
import '../../models/order_item.dart';
import '../index.dart';

class CommentPage extends StatefulWidget {
  late Order order;
  CommentPage({super.key, required this.order});
  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late double screenWidth;

  late List<TextEditingController> titleControllers;
  late List<TextEditingController> textControllers;
  late List<double> ratingValues;

  @override
  void initState() {
    super.initState();
    titleControllers = List.generate(
        widget.order.items!.length, (index) => TextEditingController(text: ''));
    textControllers = List.generate(
        widget.order.items!.length, (index) => TextEditingController(text: ''));
    ratingValues = List.generate(widget.order.items!.length,
        (index) => 5.0); // Initialize with initial rating
  }

  Future<bool> sendFeedback() async {
    try {
      bool allFeedbackSent = true; // Flag to track if all feedbacks are sent successfully
      await Future.forEach(widget.order.items!, (OrderItem item) async {
        int index = widget.order.items!.indexOf(item);
        // Check if title and text are not empty
        String title = titleControllers[index].text.toString().trim();
        String text = textControllers[index].text.toString().trim();
        if (title.isNotEmpty && text.isNotEmpty) {
          MyFeedback feedback = MyFeedback.fromJson({
            'title': title,
            'text': text,
            'star_number': ratingValues[index],
            'product': widget.order.items?[index].product?.id
          });
          // Send feedback
          await ProductRequest.addFeedback(feedback);
        } else {
          // Title or text is empty, set feedback status to false
          allFeedbackSent = false;
        }
      });
      return allFeedbackSent; // Return true if all feedbacks are successfully sent
    } catch (e) {
      print('Error sending feedback: $e');
      return false; // Return false if there is any error
    }
  }


  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: headerForDetail("Đánh giá đơn hàng"),
      bottomNavigationBar: _submitButton(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Chi tiết đơn hàng',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                _listProduct(),
                SizedBox(
                  height: 10,
                ),
                // _totalRow("Giá sản phẩm", "250.000"),
                // _totalRow("Giá vận chuyển", "0"),
                // _totalRow("Giá đơn hàng", "250.000", Colors.black),
                // SizedBox(
                //   height: 45,
                // ),
                // _commentArea()
              ],
            ),
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

  Widget _listProduct() {
    return ListView.builder(
      shrinkWrap:
          true, // Added to make the ListView scrollable within the Column
      physics:
          NeverScrollableScrollPhysics(), // Added to make the ListView scrollable within the SingleChildScrollView
      itemCount: widget.order.items?.length,
      itemBuilder: (context, index) => InkWell(
          onTap: () {
            //   Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (context) => StatusOrderPage(order : orders[index])));
          },
          child: _listProductItem(index)),
    );
  }

  Widget _listProductItem(int index) {
    OrderItem item = widget.order.items![index];
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        // height: 62,
        padding: EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.5, color: Color(0xFFCCCCCC), strokeAlign: 2),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: item.product?.productImage != null &&
                              item.product!.productImage!.isNotEmpty
                          ? NetworkImage(
                              AppConfig.IMAGE_API_URL +
                                  item.product!.productImage![0].src.toString(),
                            )
                          : NetworkImage(
                              "https://bizweb.dktcdn.net/thumb/1024x1024/100/329/681/products/3bf3d1e0-688f-4d6b-8b0a-60e9f0a1bb21.jpg?v=1679480250493",
                            ),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.product?.name.toString()}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    Text(
                      'Kích cỡ: ${item.product?.size.toString()}',
                      style: TextStyle(
                        color: Color(0xFFB2B2B2),
                        fontSize: 10,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                )),
                Expanded(
                  child: Text(
                    '${item.product!.price!} vnd',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Chất lượng sản phẩm',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                Expanded(
                  child: RatingBar.builder(
                    itemSize: 20,
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        ratingValues[index] = rating;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Tiêu đề',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: titleControllers[index],
                decoration: InputDecoration(
                    // contentPadding: EdgeInsets.symmetric(vertical: 50),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Color(0xFF999999)))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Chi tiết đánh giá',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: textControllers[index],
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(

                    // contentPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),

                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Color(0xFF999999)))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalRow(String title, String value, [Color? color]) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color ?? Color(0xFF767676),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          Text(
            value + ' vnd',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: color ?? Color(0xFF767676),
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _commentArea() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Text(
          //   'Đánh giá',
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontSize: 16,
          //     fontFamily: 'Roboto',
          //     fontWeight: FontWeight.w500,
          //     height: 0,
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Chất lượng sản phẩm',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              Expanded(
                child: RatingBar.builder(
                  itemSize: 20,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Tiêu đề',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                  // contentPadding: EdgeInsets.symmetric(vertical: 50),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF999999)))),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Chi tiết đánh giá',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 50),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF999999)))),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Text(
          //         'Người bán hỗ trợ',
          //         style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 13,
          //           fontFamily: 'Roboto',
          //           fontWeight: FontWeight.w500,
          //           height: 0,
          //         ),
          //       ),
          //     ),
          //     // SizedBox(width: 30,),
          //     Expanded(
          //       child: RatingBar.builder(
          //         itemSize: 20,
          //         initialRating: 5,
          //         minRating: 1,
          //         direction: Axis.horizontal,
          //         allowHalfRating: true,
          //         itemCount: 5,
          //         itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          //         itemBuilder: (context, _) => Icon(
          //           Icons.star,
          //           color: Colors.amber,
          //         ),
          //         onRatingUpdate: (rating) {
          //           print(rating);
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Text(
          //         'Dịch vụ giao hàng',
          //         style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 13,
          //           fontFamily: 'Roboto',
          //           fontWeight: FontWeight.w500,
          //           height: 0,
          //         ),
          //       ),
          //     ),
          //     // SizedBox(width: 30,),
          //     Expanded(
          //       child: RatingBar.builder(
          //         itemSize: 20,
          //         initialRating: 5,
          //         minRating: 1,
          //         direction: Axis.horizontal,
          //         allowHalfRating: true,
          //         itemCount: 5,
          //         itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          //         itemBuilder: (context, _) => Icon(
          //           Icons.star,
          //           color: Colors.amber,
          //         ),
          //         onRatingUpdate: (rating) {
          //           print(rating);
          //         },
          //       ),
          //     ),
          //
          //   ],
          // ),
          // SizedBox(height: 15,),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        bool success = await sendFeedback();
        if (success) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shadowColor: Colors.grey[300],
                alignment: Alignment.center,
                content: Text(
                  "Đánh giá thành công",
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
            Navigator.of(context).pop(); // Tự động đóng AlertDialog sau 2 giây
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          });
        }
        else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shadowColor: Colors.grey[300],
                alignment: Alignment.center,
                content: Text(
                  "Đánh giá không thành công",
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
            Navigator.of(context).pop(); // Tự động đóng AlertDialog sau 2 giây
          });
        }
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20),
              height: 50,
              decoration: BoxDecoration(color: Colors.black),
              child: Center(
                child: Text(
                  'Gửi đánh giá',
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
          ),
        ],
      ),
    );
  }
}

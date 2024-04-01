import 'package:fends_mobile/pages/sales/sale_page.dart';
import 'package:fends_mobile/widgets/header_for_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../index.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _nameProductController = TextEditingController();
  final _priceProductController = TextEditingController();
  final _descriptionProductController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20),
          //   child: IconButton(
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => MainPage()),
          //         );
          //       },
          //       icon: Icon(Icons.arrow_back_ios_new)),
          ),
        ],
      ),
    );
    // return Container(
    //   height: MediaQuery.of(context).size.height - 68,
    //   child: SingleChildScrollView(
    //     child: Container(
    //       margin: EdgeInsets.fromLTRB(30, 80, 30, 0),
    //       child: SizedBox(
    //         width: 301,
    //         height: MediaQuery.of(context).size.height - 80,
    //         child: Column(
    //           mainAxisSize: MainAxisSize.max,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             IconButton(
    //                 onPressed: () {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(builder: (context) => MainPage()),
    //                   );
    //                 },
    //                 icon: Icon(Icons.arrow_back_ios_new)),
    // // Container(
    // //                     margin: EdgeInsets.only(bottom: 50),
    // //                     alignment: Alignment.topLeft,
    // //                     child: Image.asset('assets/images/Vector.png'))),
    //             Container(
    //               child: Column(
    //                 children: [
    //                   SizedBox(
    //                       height: 21,
    //                       child: Text(
    //                         'Tên sản phẩm',
    //                         style: TextStyle(
    //                           color: Colors.black,
    //                           fontSize: 18,
    //                           fontFamily: 'Roboto',
    //                           fontWeight: FontWeight.w700,
    //                           height: 0,
    //                         ),
    //                       ),
    //                     ),
    //
    //                    Container(
    //                       width: 279,
    //                       height: 50,
    //                       child: Stack(
    //                         children: [
    //                           Positioned(
    //                             left: 0,
    //                             top: 0,
    //                             child: Container(
    //                               width: 279,
    //                               height: 50,
    //                               decoration: ShapeDecoration(
    //                                 color: Colors.white,
    //                                 shape: RoundedRectangleBorder(
    //                                   side: BorderSide(
    //                                       width: 1, color: Color(0xFF999999)),
    //                                 ),
    //                               ),
    //                             ),
    // )]))]))])))));

    //           SizedBox(
    //               width: 279,
    //               height: 50,
    //               child: TextField(
    //                 decoration: InputDecoration(
    //                   border: InputBorder
    //                       .none, // Ẩn border của TextField
    //                   contentPadding: EdgeInsets.only(left: 20),
    //                 ),
    //                 style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 15,
    //                   fontFamily: 'Roboto',
    //                   fontWeight: FontWeight.w400,
    //                   height: 0,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ],

    //           ),
    //           const SizedBox(height: 30),
    //           Container(
    //             width: 298,
    //             height: 86,
    //             child: Stack(
    //               children: [
    //                 Positioned(
    //                   left: 0,
    //                   top: 0,
    //                   child: SizedBox(
    //                     width: 123,
    //                     height: 21,
    //                     child: Text(
    //                       'Giá sản phẩm',
    //                       style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 18,
    //                         fontFamily: 'Roboto',
    //                         fontWeight: FontWeight.w700,
    //                         height: 0,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   left: 18,
    //                   top: 36,
    //                   child: Container(
    //                     width: 279,
    //                     height: 50,
    //                     child: Stack(
    //                       children: [
    //                         Positioned(
    //                           left: 0,
    //                           top: 0,
    //                           child: Container(
    //                             width: 279,
    //                             height: 50,
    //                             decoration: ShapeDecoration(
    //                               color: Colors.white,
    //                               shape: RoundedRectangleBorder(
    //                                 side: BorderSide(
    //                                     width: 1, color: Color(0xFF999999)),
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         Positioned(
    //                           left: 0,
    //                           top: 0,
    //                           child: SizedBox(
    //                             width: 279,
    //                             height: 50,
    //                             child: TextField(
    //                               decoration: InputDecoration(
    //                                 border: InputBorder
    //                                     .none, // Ẩn border của TextField
    //                                 contentPadding: EdgeInsets.only(left: 20),
    //                               ),
    //                               style: TextStyle(
    //                                 color: Colors.black,
    //                                 fontSize: 15,
    //                                 fontFamily: 'Roboto',
    //                                 fontWeight: FontWeight.w400,
    //                                 height: 0,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const SizedBox(height: 30),
    //           Container(
    //             width: 298,
    //             height: 200,
    //             child: Stack(
    //               children: [
    //                 Positioned(
    //                   left: 0,
    //                   top: 0,
    //                   child: Text(
    //                     'Mô tả sản phẩm',
    //                     style: TextStyle(
    //                       color: Colors.black,
    //                       fontSize: 18,
    //                       fontFamily: 'Roboto',
    //                       fontWeight: FontWeight.w700,
    //                       height: 0,
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   left: 18,
    //                   top: 36,
    //                   child: Stack(
    //                     children: [
    //                       Positioned(
    //                         child: Container(
    //                           width: 279,
    //                           height: 164,
    //                           decoration: ShapeDecoration(
    //                             color: Colors.white,
    //                             shape: RoundedRectangleBorder(
    //                               side: BorderSide(
    //                                   width: 1, color: Colors.black),
    //                             ),
    //                           ),
    //                           child: TextField(
    //                             decoration: InputDecoration(
    //                               border: InputBorder
    //                                   .none, // Ẩn border của TextField
    //                               contentPadding: EdgeInsets.only(left: 20),
    //                             ),
    //                             style: TextStyle(
    //                               color: Colors.black,
    //                               fontSize: 15,
    //                               fontFamily: 'Roboto',
    //                               fontWeight: FontWeight.w400,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           InkWell(
    //             onTap: () => {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(builder: (context) => SalePage()),
    //               )
    //             },
    //             child: Container(
    //               margin: EdgeInsets.fromLTRB(
    //                   20,
    //                   MediaQuery.of(context).size.height * 0.15,
    //                   0,
    //                   MediaQuery.of(context).size.height * 0.15),
    //               width: 450,
    //               height: 50,
    //               color: Colors.grey[100],
    //               alignment: Alignment.center,
    //               child: Text(
    //                 'Tiếp theo',
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                   color: Color(0xFF949494),
    //                   fontSize: 18,
    //                   fontFamily: 'Roboto',
    //                   fontWeight: FontWeight.w700,
    //                   height: 0,
    //                 ),
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // ),
    // );
  }

  Widget headerForDetail([String? title] ){
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
        title?? '',
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

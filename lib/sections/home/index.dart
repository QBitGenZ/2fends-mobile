import 'package:fends_mobile/widgets/HorizontalList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/index.dart';

class HomeSection extends StatelessWidget {
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: MediaQuery.of(context).size.height - 68,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            HeaderImage(),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: HorizontalList(title: 'Sản phẩm bạn có thể thích', products: products,),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: HorizontalList(title: 'Sản phẩm đang giảm giá', products: products,),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: HorizontalList(title: 'Sản phẩm hot', products: products,),
            ),
          ],
        ),
      ),
    );
  }

  Container HeaderImage() {
    return Container(
          height: 360,
          width: screenWidth,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                    width: screenWidth,
                    child: const Image(
                      image: AssetImage('assets/images/home/background.png'),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              const Positioned(
                  top: 120,
                  left: 20,
                  child: SizedBox(
                    width: 186,
                    height: 118,
                    child: Text(
                      'Item hot bạn \nkhông nên bỏ lỡ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                        shadows: [
                          Shadow(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            blurRadius: 5, // Độ mờ của bóng
                            offset: Offset(2, 2), // Độ dịch chuyển của bóng theo trục X và Y
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        );
  }
}

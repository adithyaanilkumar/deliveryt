import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Carousal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920, allowFontScaling: true);
    return  Container(
        height: 500.h,
        child: new Carousel(
          boxFit: BoxFit.cover,
          dotColor: Color(0xFFB62C40).withOpacity(0.8),
          dotSize: 4.0,
          dotSpacing: 16.0,
          dotBgColor: Colors.transparent,
          showIndicator: true,
          overlayShadow: true,
          overlayShadowColors: Colors.white.withOpacity(0.9),
          overlayShadowSize: 0.9,
          images: [
            AssetImage('assets/images/carousal1.jpg'),
            AssetImage('assets/images/carousal2.jpg'),
            AssetImage('assets/images/carousal3.jpg'),
            AssetImage('assets/images/carousal4.jpg')
            ],
        ),
      );

  }
}

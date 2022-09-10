import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenfth/Services/product_model.dart';
import '../../Constants/authConst.dart';
import 'package:gardenfth/UI/productDetail/detail.dart';

class card_details extends StatelessWidget {
  card_details(this.imgurl, this.prodname, this.price, this.id);

  final String imgurl;
  final String prodname;
  final String price;
  final Products id;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920, allowFontScaling: true);
    return InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => Detail(
                id,
              ),
              transitionDuration: Duration(milliseconds: 900),
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return Opacity(
                  opacity: animation.value,
                  child: child,
                );
              }));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          elevation: 1,
          child: Column(
            children: <Widget>[
              Container(

                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      fit: BoxFit.contain,
                        placeholder: AssetImage('assets/images/onboard1.jpg'),
                        image: CacheImage("$imgurl"))),
                height: 250.h,
                width: 450.w,
              ),
              Padding(
//                padding: EdgeInsetsResponsive.only(top:10,bottom: 12),
//                padding: const EdgeInsets.only(top: 2.0, bottom: 3.0),
                padding:  EdgeInsets.only(top: ScreenUtil().setWidth(10), bottom: ScreenUtil().setWidth(13)),
                child: Text(prodname, style: heading_auth_smol_2),
              ),
              Padding(
//                padding: EdgeInsetsResponsive.only(bottom: 14),
                padding:  EdgeInsets.only(bottom:ScreenUtil().setWidth(14)),
                child: Text(
                  'Rs ${price}',
                  style: heading_auth_smol_1,
                ),
              )
            ],
          ),
        ),
      );

  }
}








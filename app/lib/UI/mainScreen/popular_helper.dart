import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenfth/Services/getJwt.dart';
import 'package:gardenfth/Services/network.dart';
import 'package:gardenfth/UI/mainScreen/common.dart';
import 'package:gardenfth/UI/mainScreen/modules.dart';
import 'package:gardenfth/UI/widgets/loader.dart';

class Popular_items extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920, allowFontScaling: true);
    MyCacheManager cacheManager = MyCacheManager();
    Widget createPopularListview(BuildContext context, AsyncSnapshot snapshot) {
      double screenHeight = MediaQuery.of(context).size.height;
      return Padding(
        padding:  EdgeInsets.all(ScreenUtil().setWidth(20)),
        child: SizedBox(
          height: 410.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:  EdgeInsets.only(right:ScreenUtil().setWidth(16)),
                child: card_details(
                    "${snapshot.data[index].image_url}",
                    "${snapshot.data[index].name}",
                    "${snapshot.data[index].regular_price}",
                    snapshot.data[index]),
              );
            },
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title_common("Popular"),
        FutureBuilder(
          future: cacheManager.getProducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Spinner(context),
                ),
              );
            } else {
              return createPopularListview(context, snapshot);
            }
          },
        ),
      ],
    );
  }
}


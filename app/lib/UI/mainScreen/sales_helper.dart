import 'package:flutter/material.dart';
import 'package:gardenfth/Services/getJwt.dart';
import 'package:gardenfth/UI/mainScreen/common.dart';
import 'package:gardenfth/UI/mainScreen/modules.dart';
import 'package:gardenfth/Services/network.dart';
import 'package:gardenfth/UI/widgets/loader.dart';

class Sales_main_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyCacheManager cacheManager = MyCacheManager();
    Widget createSalesListview(BuildContext context, AsyncSnapshot snapshot) {
      final orientation = MediaQuery.of(context).orientation;
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: screenWidth,
          height: snapshot.data.length.toDouble()*140,
          child: GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: screenWidth/50,
                crossAxisSpacing: screenWidth/50,
                crossAxisCount: 2 ),
            itemBuilder: (BuildContext context, int index) {
              return snapshot.data[index].popular
                  ? card_details(
                  "${snapshot.data[index].image_url}",
                  "${snapshot.data[index].name}",
                  "${snapshot.data[index].regular_price}",
                  snapshot.data[index])
                  : Container();
            },
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title_common("Recommended"),
        FutureBuilder(
          future: cacheManager.getProducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                    child: Spinner(context)
                ),
              );
            } else {
              return createSalesListview(context, snapshot);
            }
          },
        ),
      ],
    );
  }
}

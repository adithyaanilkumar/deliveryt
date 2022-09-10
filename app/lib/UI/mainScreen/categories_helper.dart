import 'package:flutter/material.dart';
import 'package:gardenfth/UI/mainScreen/categories/categories.dart' as cat;
import 'dart:math';

import 'package:gardenfth/UI/mainScreen/common.dart';

final List<String> categories = <String>[
  'Chicken',
  'Beef',
  'Pork',
  'Fish',
  'Mutton',
  'Others'
];
List colors = [
  Colors.redAccent[100],
  Colors.blueAccent[100],
  Colors.orange[200],
  Colors.pink[100]
];

List<String> CatImg = [
  'https://pluspng.com/img-png/white-chicken-png-image-png-image-2055.png',
  'https://pngimg.com/uploads/cow/cow_PNG50601.png',
  'https://www.zg.ch/behoerden/volkswirtschaftsdirektion/lbbz/lbbz-english/ueber-das-lbbz/estate-farm/livestock-farming/pig-farming/swiss-landrace-sl/@@images/895891d0-3191-41ea-a062-6a9182471722.png',
  'https://pngimg.com/uploads/fish/fish_PNG25137.png',
  'https://www.freepnglogos.com/uploads/sheep-png/download-sheep-png-transparent-image-and-clipart-16.png',
  'https://pngimg.com/uploads/duck/duck_PNG5028.png'
];

final List<String> image_url = <String>[
  'https://4.imimg.com/data4/SS/SS/GLADMIN-/image-cache-chicken-chicken_cube-500x500-500x500.jpg',
  'https://previews.123rf.com/images/yodaswaj/yodaswaj1611/yodaswaj161100140/66448970-group-raw-black-pomfret-fish-on-white-background.jpg',
  'https://fishify.in/wp-content/uploads/2019/01/white-pomfret-1.jpg',
  'https://content.jdmagicbox.com/comp/pune/t2/020pxx20.xx20.191220100443.r1t2/catalogue/om-fish-shop-wagholi-pune-fish-retailers-02myvblr4r.jpg?clr=',
  'https://4.imimg.com/data4/BO/CC/MY-24286376/king-fish-500x500.jpg',
  'https://greenleafonline.net/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/1/0/100_1.jpg',
  'https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/AN_images/shrimp-on-wooden-platter-1296x728.jpg?w=1155&h=1528',
  'https://5.imimg.com/data5/MY/GQ/MY/SELLER-39820924/raw-mathi-fish-500x500.jpg',
  'https://5.imimg.com/data5/UW/SQ/MY-41889214/aila-fish-500x500.jpg',
  'https://japan-brand.jnto.go.jp/wp-content/uploads/2014/03/95-c.jpg',
  'https://4.imimg.com/data4/BW/RO/ANDROID-66536491/product-500x500.jpeg',
  'https://www.gimmesomeoven.com/wp-content/uploads/2018/01/5-Freezer-Chicken-Breast-Marinade-Recipes-Packs-5.jpg',
  'https://4.imimg.com/data4/KE/QK/MY-9650223/pork-meat-500x500.jpg',
];


class Categories_on_screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    int number = 0;
    final orientation = MediaQuery.of(context).orientation;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title_common("Categories"),
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 600,
                  child: GridView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 0.5,
                        crossAxisSpacing: 0.5,
                        crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                      builder: (context) => cat.Category(
                                        catText: categories[index],
                                      )),
                                );
                              },
                              child: Card(
                                color: colors[random.nextInt(4)],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                elevation: 0,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 100,
                                        height: 100,
                                        child: Image.network(CatImg[index]),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${categories[index]}',
                                        style: TextStyle(
                                            fontFamily: 'SF-Pro',
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
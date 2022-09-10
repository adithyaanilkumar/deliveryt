import 'package:algolia/algolia.dart';
import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gardenfth/Constants/authConst.dart';
import 'package:gardenfth/UI/productDetail/detail.dart';
import 'package:gardenfth/Services/product_model.dart';
import 'package:gardenfth/UI/widgets/loader.dart';

class Category extends StatefulWidget {

  Category({@required this.catText});
  final String catText;

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<AlgoliaObjectSnapshot> _results = [];
  bool _searching = false;
  bool _searched = false;

  _search() async {
    setState(() {
      _searching = true;
      _searched = true;
    });

    Algolia algolia = Algolia.init(
      applicationId: 'FV6ERISLLI',
      apiKey: '0f84938dc2a30be8b9c8128b8c31d7dd',
    );

    AlgoliaQuery query = algolia.instance.index('Product');
    query = query.search(widget.catText);

    _results = (await query.getObjects()).hits;

    setState(() {
      _searching = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _search();
  }

  double quantity = 1;
  void add(){
    quantity += 1;
    setState(() {
      quantity = quantity;
    });
  }
  void reduce(){
    if(quantity<=1)
    {
      print('lowest quantity possible');
    }else{
      quantity -= 1;}
    setState(() {
      quantity = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text("${widget.catText}",style: TextStyle(fontFamily: 'SF-Pro',fontSize: 28,fontWeight: FontWeight.w700,color: Colors.black),),
      ),
      body: Container(
//        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left:8.0,top: 14,right: 8,bottom: 8),
                child: _searched == true
                    ? Text('${_results.length} Results for " ${widget.catText}"',style: TextStyle(fontFamily: 'SF-PRO',color: Colors.grey,letterSpacing: 1),)
                    : null
            ),
            Expanded(
              child: _searching == true
                  ? Center(
                child: Spinner(context),
              )
                  : _results.length == 0
                  ? _searched ?Center(
                child: Text("No results found."),
              ):Text('')
                  :Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _results.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 2,
                      crossAxisCount: 2 ),
                itemBuilder: (BuildContext ctx, int index) {
                    AlgoliaObjectSnapshot snap = _results[index];
                    return InkWell(
                      onTap: () {
                        var product = Products(
                            snap.data["id"],
                            snap.data["name"],
                            snap.data["category"],
                            snap.data["description"],
                            snap.data["image_url"],
                            snap.data["regular_price"].toString(),
                            snap.data["discount_price"].toString(),
                            snap.data["active"],
                            snap.data["popular"],
                            snap.data["stock"].toString(),
                            snap.data["taxable"]
                        );
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => Detail(
                              product
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
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 1,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                            child: FadeInImage(
                                                placeholder: AssetImage(
                                                    'assets/images/onboard1.jpg'),
                                                image: CacheImage(
                                                    "${snap.data["image_url"]}"))),
                              height: 80,
                              width: 150,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0, bottom: 5.0),
                              child: Text(snap.data["name"], style: heading_auth_smol_2),
                            ),
                            Text(
                              'Rs ${snap.data["discount_price"]}',
                              style: heading_auth_smol_1,
                            ),
                      ]),
                    ));
                },
              ),
                  ),
//                  : GridView.builder(
//                scrollDirection: Axis.vertical,
//                itemCount: _results.length,
//                itemBuilder: (BuildContext ctx, int index) {
//                  AlgoliaObjectSnapshot snap = _results[index];
//
//                  return Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      SizedBox(height: 10,),
//                      Container(
//                        height: 110,
//                        child: Card(
//                          shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(5),
//                          ),
//                          elevation: 5,
//                          child: Padding(
//                              padding: const EdgeInsets.only(
//                                  top: 10.0, bottom: 10.0, left: 20, right: 10.0),
//                              child: Row(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  GestureDetector(
//                                    onTap: (){
//                                      Navigator.of(context).push(
//                                        MaterialPageRoute<void>(
//                                            builder: (context) => Detail(null)
//                                        ),
//                                      );
//                                    },
//                                    child: Container(
//                                      child: ClipRRect(borderRadius: BorderRadius.circular(10),
//                                        child: Image.network(snap.data["image_url"]),),
//                                      height: 80,
//                                      width: 80,
//                                    ),
//                                  ),
//                                  SizedBox(width: 10,),
//                                  Container(
//                                    child: Column(
//                                      crossAxisAlignment: CrossAxisAlignment.start,
//                                      mainAxisAlignment: MainAxisAlignment.center,
//                                      children: <Widget>[
//                                        Text(
//                                          snap.data["name"],
//                                          style: TextStyle(
//                                              fontSize: 20,
//                                              fontWeight: FontWeight.bold,
//                                              fontFamily: 'SFPROBOLD'
//                                          ),
//                                        ),
//                                        SizedBox(height: 4),
//                                        Row(
//                                          mainAxisAlignment: MainAxisAlignment.start,
//                                          children: <Widget>[
//                                            Text(snap.data["price"],),
//                                          ],
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  Spacer(),
//                                  Column(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    crossAxisAlignment: CrossAxisAlignment.center,
//                                    children: <Widget>[
//                                      Padding(
//                                        padding: EdgeInsets.all(10),
//                                        child: Row(
//                                          children: <Widget>[
//                                            GestureDetector(
//                                              onTap: (){
//                                                add();
//                                              },
//                                              child: Container(
//                                                width: 30,
//                                                height: 30,
//                                                child: Center(
//                                                  child: Card(
//                                                    elevation: 3,
//                                                    shape: RoundedRectangleBorder(
//                                                      borderRadius: BorderRadius.circular(18.0),
////                                                                side: BorderSide(color: Colors.grey[400])
//                                                    ),
//                                                    child: Center(child: FaIcon(FontAwesomeIcons.plus,size: 13,color: Colors.grey[400],)),
//                                                  ),
//                                                ),
//                                              ),
//                                            ),
//                                            Container(
//                                              width: 30,
//                                              height: 30,
//                                              child: Center(
//                                                child: Card(
//                                                  elevation: 3,
//                                                  child: Center(
//                                                    child: Text('$quantity',style: TextStyle(fontFamily: 'SF-Pro'),),
//                                                  ),
//                                                ),
//                                              ),
//                                            ),
//                                            GestureDetector(
//                                              onTap: (){
//                                                reduce();
//                                              },
//                                              child: Container(
//                                                width: 30,
//                                                height: 30,
//                                                child: Center(
//                                                  child: Card(
//                                                    elevation: 3,
//                                                    shape: RoundedRectangleBorder(
//                                                      borderRadius: BorderRadius.circular(18.0),
////                                                                side: BorderSide(color: Colors.grey[400])
//                                                    ),
//                                                    child: Center(child: FaIcon(FontAwesomeIcons.minus,size: 13,color: Colors.grey[400],)),
//                                                  ),
//                                                ),
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                      Container(
//                                        width: 90,
//                                        height: 30,
//                                        child: Center(
//                                          child: Card(
//                                            elevation: 5,
//                                            color: Colors.redAccent,
//                                            child: Center(child: Text('Add to cart',style: TextStyle(color: Colors.white),)),
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  )
//                                ],
//                              )
//                          ),
//                        ),
//                      ),
//
//                    ],
//                  );
//                },
//              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        elevation: 10,
        label: Text('Checkout',style: TextStyle(color: Colors.white,fontFamily: 'SF-Pro'),),
        icon: Icon(Icons.shopping_cart,color: Colors.white,),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14)
        ),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

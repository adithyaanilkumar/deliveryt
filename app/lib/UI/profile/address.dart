import 'package:flutter/material.dart';
import 'package:gardenfth/Services/profile/address/address_model.dart';
import 'package:gardenfth/Services/profile/address/get_address.dart';
import 'package:gardenfth/Services/profile/address/update_address.dart';
import 'package:gardenfth/UI/widgets/loader.dart';
import 'package:geolocator/geolocator.dart';
import 'profile.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

final TextEditingController _addressController = TextEditingController();
String get _address => _addressController.text;

String city1,state1,pin1;
double lat,long;

bool getPressed = false;

class _AddressState extends State<Address> {

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress = 'Loading';

  @override
  Widget build(BuildContext context) {
    AdresscacheManager adresscacheManager = AdresscacheManager();

    _getAddressFromLatLng() async {
      try {
        List<Placemark> p = await geolocator.placemarkFromCoordinates(
            _currentPosition.latitude, _currentPosition.longitude);

        Placemark place = p[0];

        setState(() {
          city1 = place.locality;
          state1 = place.administrativeArea;
          pin1 = place.postalCode;
          _currentAddress =
          "${place.locality}, ${place.postalCode}, ${place.administrativeArea}, ${place.country}";
        });
      } catch (e) {
        print(e);
      }
    }
    _getCurrentLocation() {
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation)
          .then((Position position) {
        setState(() {
          lat = position.latitude;
          long = position.longitude;
          _currentPosition = position;
        });

        _getAddressFromLatLng();
      }).catchError((e) {
        print(e);
      });
    }

    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;
    displayAddress(context, snapshot){
      bool Change = false;
      String showAddress = snapshot.data.address1;
      String address2 = snapshot.data.address2;
      String city = snapshot.data.city;
      String state = snapshot.data.state;
      String pincode = snapshot.data.pin_code;
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth/1.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${showAddress}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Text('${pincode}',style: TextStyle(color: Colors.grey[600],fontSize: 20),),
                  SizedBox(height: 5,),
                  Text('${city}',style: TextStyle(color: Colors.grey[600],fontSize: 20),),
                  SizedBox(height: 5,),
                  Text('${state}',style: TextStyle(color: Colors.grey[600],fontSize: 20),),
                ],
              ),),
            Padding(
              padding: const EdgeInsets.only(left:20.0,bottom: 15,right: 20,top: 15),
              child: Divider(height: 2,thickness: 2,),
            ),
            if(_currentPosition == null)
              Container(
                height: screenheight/2,
                width: screenWidth,
                child: Image.asset('assets/images/address.png'),
              ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 50,
                width: 200,
                child: FlatButton(
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.my_location,color: Colors.white,),
                      SizedBox(width: 5,),
                      Text("Change Address",style: TextStyle(color: Colors.white),),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      Change = true;
                    });
                    _getCurrentLocation();
                    getPressed = true;
                  },
                ),
              ),
            ),
            if (_currentPosition != null)
              Column(
                children: [
                  SizedBox(height: 10,),
                  Text(_currentAddress,style: TextStyle(fontSize: 18,),),
                  SizedBox(height: 10,),
                  Container(
                    height: screenheight / 7,
                    width: screenWidth / 1.2,
                    child: Card(
                      color: Colors.white,
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.grey[600]),
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          controller: _addressController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          maxLines: 3,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            hintText: " Enter more details",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right:25.0),
                      child: FlatButton(
                        onPressed: (){
                          final address = AddressUp(
                            id: snapshot.data.id,
                            uid: snapshot.data.uid,
                            name: snapshot.data.name,
                            address1: _address,
                            address2: 'blank',
                            city: city1,
                            state: state1,
                            pin_code: pin1,
                            lat: lat,
                            longt: long,
                          );
                          updateAddress(address);
                          setState(() {
                            city = city1;
                            showAddress = _address;
                            state = state1;
                            pincode = pin1;
                          });
                          _addressController.clear();
                        },
                        color: Colors.redAccent,
                        child: Text('Save',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('My Address',style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
          onPressed: (){
            Navigator.of(context).pop(PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) =>
                  Profile(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = Offset(1.0, 0.0);
                var end = Offset.zero;
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ));
          },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder(
            future: adresscacheManager.getProfiles(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                      child: Spinner(context)
                  ),
                );
              } else {
                return displayAddress(context, snapshot);
              }
            }),
      ),
    );
  }
}



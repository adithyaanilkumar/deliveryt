import 'package:flutter/material.dart';
import 'package:gardenfth/Services/profile/network_profiles.dart';
import 'package:gardenfth/Services/profile/update_profile.dart';
import 'package:gardenfth/Services/profile/update_model.dart';
import 'package:gardenfth/UI/cart/cart.dart';
import 'package:gardenfth/UI/profile/profile.dart';
import 'address.dart';
import 'package:gardenfth/UI/widgets/loader.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

final TextEditingController _firstNameController = TextEditingController();

String get _firstname => _firstNameController.text;
final TextEditingController _lastNameController = TextEditingController();

String get _lastname => _lastNameController.text;
final TextEditingController _phoneController = TextEditingController();

String get _phone => _phoneController.text;
final TextEditingController _emailController = TextEditingController();

String get _email => _emailController.text;

class _AccountState extends State<Account> {

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    setState(() {
      build(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfileCacheManager cacheManager = ProfileCacheManager();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    displayAccount(context, snapshot) {
      String phone = snapshot.data.phone;
      String lastname = snapshot.data.last_name;
      String firstname = snapshot.data.first_name;
      String email = snapshot.data.email;
      return SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, bottom: 8),
                        child: Text(
                          '$firstname $lastname',
                          style: TextStyle(
                              fontFamily: 'SF-Pro',
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                              letterSpacing: 0),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8),
                            child: Icon(
                              Icons.account_circle,
                              color: Colors.grey[400],
                            ),
                          ),
                          Text('Username : ',
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontFamily: 'SF-Pro',
                                  fontSize: 20)),
                          Text('${snapshot.data.username}',
                              style: TextStyle(
                                  fontFamily: 'SF-Pro', fontSize: 20)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8),
                            child: Icon(
                              Icons.mail,
                              color: Colors.grey[400],
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            '$email',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'SF-Pro',
                                letterSpacing: 0.2,
                                color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8),
                            child: Icon(
                              Icons.call,
                              color: Colors.grey[400],
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            '$phone',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'SF-Pro',
                                letterSpacing: 0.2,
                                color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8),
                            child: Icon(
                              Icons.home,
                              color: Colors.grey[400],
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
//                          Text(
//                            '${snapshot.data[index].address}',
//                            style: TextStyle(
//                                fontSize: 15,
//                                fontFamily: 'SF-Pro',
//                                letterSpacing: 0.2,
//                                color: Colors.grey[500]),
//                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Center(child: Text('Pull refresh the page to see the updated details',style: TextStyle(color: Colors.grey),))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    height: 10,
                    width: double.infinity,
                    color: Colors.grey[200],
                  ),
                ),

                /// change name
                ExpansionTile(
                  title: Text(
                    'Change Name',
                    style: TextStyle(color: Colors.grey),
                  ),
                  children: <Widget>[
                    Container(
                      height: screenheight / 11,
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
                            controller: _firstNameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: " Enter your First Name",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: screenheight / 11,
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
                            controller: _lastNameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: " Enter your Last Name",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      onPressed: () {
                        final nameup = NameUp(
                            username: snapshot.data.username,
                            firstname: _firstname,
                            lastname: _lastname);
                        updateName(nameup);
                        setState(() {
                          firstname = _firstname;
                          lastname = _lastname;
                        });
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    )
                  ],
                ),
                grey_thin_line(),

                /// change username
                ExpansionTile(
                  title: Text(
                    'Change Username',
                    style: TextStyle(color: Colors.grey),
                  ),
                  children: <Widget>[],
                ),
                grey_thin_line(),

                ///  change email
                ExpansionTile(
                  title: Text(
                    'Change Email',
                    style: TextStyle(color: Colors.grey),
                  ),
                  children: <Widget>[
                    Container(
                      height: screenheight / 11,
                      width: screenWidth / 1.2,
                      child: Card(
                        color: Colors.white,
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            style: TextStyle(color: Colors.grey[600]),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: _emailController,
                            validator: (val) =>
                            !val.contains('@') ? "Invalid Email" : null,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: " Enter your email",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      onPressed: () {
                        final emailup = EmailUp(
                            username: snapshot.data.username,
                            email: _email);
                        updateEmail(emailup);
                        setState(() {
                          email = _email;
                        });
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    SizedBox(
                      height: screenheight/3,
                    ),
                  ],
                ),
                grey_thin_line(),

                ///  change phone
                ExpansionTile(
                  title: Text(
                    'Change Phone number',
                    style: TextStyle(color: Colors.grey),
                  ),
                  children: <Widget>[
                    Container(
                      height: screenheight / 11,
                      width: screenWidth / 1.2,
                      child: Card(
                        color: Colors.white,
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            style: TextStyle(color: Colors.grey[600]),
                            autocorrect: false,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            controller: _phoneController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: " Enter your Phone number",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      onPressed: () {
                        final phoneup = PhoneUp(
                            username: snapshot.data.username,
                            phone: _phone);
                        updatePhone(phoneup);
                        setState(() {
                          phone = _phone;
                        });
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    SizedBox(
                      height: screenheight/3,
                    )
                  ],
                ),
                grey_thin_line(),

                /// change password
                Padding(
                  padding: EdgeInsets.only(
                      top: 10, left: 24.0, right: 6.0, bottom: 12.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.vpn_key,
                        color: Colors.grey[400],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text('Change Password',
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ],
                  ),
                ),
                grey_thin_line(),

                /// change address
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (context) => Address()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 15, left: 24.0, right: 6.0, bottom: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey[400],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text('Change Address',
                            style: TextStyle(color: Colors.grey, fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                grey_thin_line(),
              ],
            ),
          ));
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SmartRefresher(
          enablePullDown: true,
          header: WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// appbar
                Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: InkWell(
                          onTap: () {
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
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'My Account',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: (){},
                            child: Icon(
                              Icons.home,
                              size: 25,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  height: screenheight - 79,
                  child: FutureBuilder(
                      future: cacheManager.getProfiles(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                                child: Spinner(context)
                            ),
                          );
                        } else {
                          return displayAccount(context, snapshot);
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class grey_thin_line extends StatelessWidget {
  const grey_thin_line({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey[300],
      ),
    );
  }
}

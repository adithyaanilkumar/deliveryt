import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gardenfth/UI/auth/Old_sign_in.dart';
import 'package:gardenfth/Services/Auth.dart';
import 'package:gardenfth/UI/auth/landing_page.dart';
import 'splash.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => new _OnBoardingState();
}

double width,height;
class _OnBoardingState extends State<OnBoarding> {
  List<Slide> slides = new List();

  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Get Started with Garden",
        styleTitle: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "All your poultry in one place",
        styleDescription: TextStyle(
            color: Colors.grey[400],
            fontSize: 20.0,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/onboard1.jpg",
      ),
    );
    slides.add(
      new Slide(
        title: "Track your delivery",
        styleTitle: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Our deliveries will be fast but we ensure that it'll be trackable.",
        styleDescription: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/onboard2.jpg",
      ),
    );
    slides.add(
      new Slide(
        title: "Safe and Healthy",
        styleTitle: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "All our products are healthy",
        styleDescription: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
            fontFamily: 'Raleway'),
            pathImage: "assets/images/onboard3.jpg",
      ),
    );
  }

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  landingPage(),
      ),
    );
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.redAccent,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.redAccent,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.redAccent,
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                    currentSlide.pathImage,
                    width: width,
                    height: height/2,
                    fit: BoxFit.contain,
                  )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Colors.red[100],
      highlightColorSkipBtn: Colors.redAccent,

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Colors.red[100],
      highlightColorDoneBtn: Colors.redAccent,

      // Dot indicator
      colorDot: Colors.redAccent,
      sizeDot: 13.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Show or hide status bar
      shouldHideStatusBar: true,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}

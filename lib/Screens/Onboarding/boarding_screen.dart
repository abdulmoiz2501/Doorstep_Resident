import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:DoorStep/Screens/Onboarding/slide.dart';
import 'package:DoorStep/Services/Shared_Prefrences.dart';
import 'package:DoorStep/constants.dart';
import 'package:DoorStep/Screens/Login/components/background.dart';

import 'package:gradient_widgets/gradient_widgets.dart';
//import 'file:///C:/Users/Lenovo/AndroidStudioProjects/Login-Signup-OOP/lib/slide.dart';
//import 'file:///C:/Users/Lenovo/AndroidStudioProjects/Login-Signup-OOP/lib/Screens/Onboarding/boarding_screen.dart';
//import 'file:///C:/Users/Lenovo/AndroidStudioProjects/Login-Signup-OOP/lib/Screens/Onboarding/slide.dart';

import 'package:DoorStep/Screens/Signup/signup_screen.dart';
import 'package:DoorStep/Screens/Login/login_screen.dart';


class BoardingPage extends StatefulWidget {
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingPage> {
  // creating all the widget before making our home screen
  // String info1='This app';
  // String info2='The scanning';
  // String info3='Get notified';
  int _currentPage = 0;
  List<Slide> _slides = [];
  PageController _pageController = PageController();

  @override
  void initState() {
    //setting that the boarding screen is already used first time
    SharedPref sharedPref=new SharedPref();
    sharedPref.setFirst();
    _currentPage = 0;
    _slides = [
      Slide("lib/resources/team.png", "Innovative Neighbourhood App.", "This app will truly enhance the way you think about neighbourhood lifestyle with it's rich and useful features."),

      Slide("lib/resources/dancing.png", "Secure Lifestyle.","The scanning capabilities will ensure protection for you and your loved ones!"),

      Slide("lib/resources/love.png", "Stay Updated!","Get notified when an event takes place. This app will help you apprise every single situation occuring near you!"),
    ];
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  // the list which contain the build slides
  List<Widget> _buildSlides() {
    return _slides.map(_buildSlide).toList();
  }

  // building single slide

  Widget _buildSlide(Slide slide) {
    return Background(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.all(32),
              child: Image.asset(slide.image, fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70),
            child: Text(
              slide.heading,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70),
            child: Text(
              slide.info,
              //'This app will truly enhance the way you think about neighbourhood lifestyle!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            height: 230,
          )
        ],
      ),
    );
  }

  // handling the on page changed
  void _handlingOnPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  // building page indicator
  Widget _buildPageIndicator() {
    Row row = Row(mainAxisAlignment: MainAxisAlignment.center, children: []);
    for (int i = 0; i < _slides.length; i++)
    {
      row.children.add(_buildPageIndicatorItem(i));
      if (i != _slides.length - 1)
        row.children.add(SizedBox(
          width: 12,
        ));
    }
    return row;
  }

  Widget _buildPageIndicatorItem(int index) {
    return Container(
      width: index == _currentPage ? 8 : 5,
      height: index == _currentPage ? 8 : 5,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == _currentPage
              ? Color.fromRGBO(136, 144, 178, 1)
              : Color.fromRGBO(206, 209, 223, 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: _handlingOnPageChanged,
            physics: BouncingScrollPhysics(),
            children: _buildSlides(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: <Widget>[
                _buildPageIndicator(),
                SizedBox(
                  height: 32,
                ),
                Container(
                  // see the page indicators

                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: SizedBox(

                      width: double.infinity,
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()));
                      },
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 15,
                            color: kPrimaryLightColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                      //   child: GradientButton(
                      //     callback: () => {},
                      //     gradient: LinearGradient(colors: [
                      //       Color.fromRGBO(11, 198, 200, 1),
                      //       Color.fromRGBO(68, 183, 183, 1)
                      //     ]),
                      //     elevation: 0,
                      //     increaseHeightBy: 28,
                      //     increaseWidthBy: double.infinity,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(100),
                      //     ),
                      //     child: Text(
                      //       "Sign Up",
                      //       style: TextStyle(
                      //         letterSpacing: 4,
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      // ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CupertinoButton(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                    ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

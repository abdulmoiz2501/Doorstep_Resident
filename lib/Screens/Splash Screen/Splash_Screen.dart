import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:DoorStep/Screens/Dashboard/Dashboard.dart';
import 'package:DoorStep/Screens/Login/login_screen.dart';
import 'package:DoorStep/Screens/Onboarding/boarding_screen.dart';
import 'package:DoorStep/Services/Shared_Prefrences.dart';
import 'package:DoorStep/constants.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  final splashDelay = 5;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    SharedPref sharedPref=new SharedPref();
    sharedPref.getFirst().then((value) {
      if(value){
        User user=FirebaseAuth.instance.currentUser;
        if(user==null)
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
        else
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => BoardingPage()));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/splash.png',
                            height: size.height*0.6,
                            width: size.width*0.6,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                          ),
                        ],
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text("DoorStep",style: TextStyle(
                    fontFamily: "Montserrat Medium",
                    fontSize: 28,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                  ),),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
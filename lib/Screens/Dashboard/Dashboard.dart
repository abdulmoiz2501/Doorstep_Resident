import 'package:DoorStep/Screens/AccessControl/AccessControl.dart';
import 'package:DoorStep/Screens/Incident/Incident.dart';
import 'package:DoorStep/Screens/Services/Services.dart';
import 'package:DoorStep/Screens/Survey/Survey.dart';
import 'package:DoorStep/Screens/Announcement/Announcement.dart';
import 'package:DoorStep/Screens/Reservation/Reservation.dart';
import 'package:DoorStep/Screens/navigator/menu_drawer.dart';
import 'package:DoorStep/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Dashboard extends StatefulWidget {
  String url;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Color(0xFF6F35A5),
        ),
      ),
      body:  new Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topCenter,
          child: new Column(
            children: [

              SizedBox(
                height: size.height*0.02,
              ), //15

              Image.asset(
                'assets/images/dashboardMain2.png',
                width: size.height*0.44,
                fit: BoxFit.fitWidth,
              ), // 150 , 240


              SizedBox(
                height: size.height*0.02,
              ), // 15

              /*
              1: In each column  rows are added
              2: In each row two expanded Containers are added which divide the rows in two parts
              3: Now each Expanded Container "Stack" widget is used ,
              4: Black bordered Container , an image and text is stacked in each Expanded container.
              5: to Align the Black bordered Container first "Positioned.filled(centerLeft/right)" and then "padding" is used
              * */

              // ROW # 1 ( ACCESS CONTROL & RESERVATIONS )
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  Expanded(
                    child: new GestureDetector(
                      child: new Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: new Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: new Container(
                                    height: 115,
                                    width: 145,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade400,
                                          blurRadius: 8,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(9),
                                      color: Colors.grey.shade50,
                                      border: Border.all(color: kPrimaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              bottom: -28,
                              child: Image.asset(
                                'assets/images/access.png',
                                height: 155,
                                width: 135,
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 33,
                              child: new Text(
                                'Access Control',
                                style: TextStyle(
                                  fontFamily: 'Montserrat Medium',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap:  ()=> {
                        Navigator.push(context, MaterialPageRoute(builder : (context)=> AccessControl(),),),},
                    ),
                  ),
                  Expanded(
                    child: new GestureDetector(
                      child: new Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: new Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: new Container(
                                    height: 115,
                                    width: 145,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      color: Colors.grey.shade50,
                                      border: Border.all(color:kPrimaryColor),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade400,
                                          blurRadius: 8,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 17,
                              bottom: -5,
                              child: Image.asset(
                                'assets/images/reservation.png',
                              ),
                              height: 115,
                              width: 100,
                            ),
                            Positioned(
                              top: 20,
                              right: 65,
                              child: new Text(
                                'Reservations',
                                style: TextStyle(
                                  fontFamily: 'Montserrat Medium',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: ()=> {
                        Navigator.push(context, MaterialPageRoute(builder : (context)=> Reservation(),),),},
                    ),
                  ),
                ],
              ),

              // ROW # 2 ( ANNOUNCEMENT & SURVEY )
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: new GestureDetector(
                      child: new Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: new Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: new Container(
                                    height: 115,
                                    width: 145,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade400,
                                          blurRadius: 8,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(9),
                                      color: Colors.grey.shade50,
                                      border: Border.all(color: kPrimaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 9,
                              bottom: -26,
                              child: Image.asset(
                                'assets/images/announcement.png',
                                height: 155,
                                width: 135,
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 25,
                              child: new Text(
                                'Announcement',
                                style: TextStyle(
                                  fontFamily: 'Montserrat Medium',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: ()=> {
                        Navigator.push(context, MaterialPageRoute(builder : (context)=> Announcement()),),},
                    ),
                  ),
                  Expanded(
                    child: new GestureDetector(
                      child: new Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: new Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: new Container(
                                    height: 115,
                                    width: 145,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      color: Colors.grey.shade50,
                                      border: Border.all(color: kPrimaryColor),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade400,
                                          blurRadius: 8,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 17,
                              bottom: -1,
                              child: Image.asset(
                                'assets/images/survey.png',
                              ),
                              height: 115,
                              width: 110,
                            ),
                            Positioned(
                              top: 20,
                              left: 19,
                              child: new Text(
                                'Survey',
                                style: TextStyle(
                                  fontFamily: 'Montserrat Medium',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap:  ()=> {
                        Navigator.push(context, MaterialPageRoute(builder : (context)=> Survey()),),},
                    ),
                  ),
                ],
              ),

              // ROW # 3 ( EMERGENCY & SERVICES )
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: new GestureDetector(
                      child: new Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: new Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: new Container(
                                    height: 115,
                                    width: 145,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade400,
                                          blurRadius: 8,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(9),
                                      color: Colors.grey.shade50,
                                      border: Border.all(color: kPrimaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 9,
                              bottom: -24,
                              child: Image.asset(
                                'assets/images/emergency.png',
                                height: 155,
                                width: 145,
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 34,
                              child: new Text(
                                'Incident',
                                style: TextStyle(
                                  fontFamily: 'Montserrat Medium',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap:  ()=> {
                        Navigator.push(context, MaterialPageRoute(builder : (context)=> Incident()),),},
                    ),
                  ),
                  Expanded(
                    child: new GestureDetector(
                      child: new Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: new Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: new Container(
                                    height: 115,
                                    width: 145,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      color: Colors.grey.shade50,
                                      border: Border.all(color: kPrimaryColor),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade400,
                                          blurRadius: 8,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: -10,
                              child: Image.asset(
                                'assets/images/services.png',
                              ),
                              height: 115,
                              width: 150,
                            ),
                            Positioned(
                              top: 20,
                              left: 19,
                              child: new Text(
                                'Services',
                                style: TextStyle(
                                  fontFamily: 'Montserrat Medium',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap:  ()=> {
                        Navigator.push(context, MaterialPageRoute(builder : (context)=> Services()),),},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

    );
  }
}

import 'dart:async';
import 'package:DoorStep/components/rounded_button.dart';
import 'package:DoorStep/components/rounded_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';



class AccessControl extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AccessControl> {
  final _screenshotController = ScreenshotController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  String getUserId() {
    // getting current user id
    final User user = auth.currentUser;
    return user.uid;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

      return Scaffold(

         appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: AppBar(
              backgroundColor: Color(0xFF6F35A5),
            ),
          ),
          body: new SafeArea(
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.white,
              child: new Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'Access Control',
                    style: TextStyle(
                      fontFamily: 'Montserrat Medium',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Image.asset(
                    'assets/images/accessControlScreen.png',
                    width: size.height * 0.35,
                  ),

                  new Expanded(
                    child: new Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: new Column(
                        children: [

                          SizedBox(height: size.height*0.03,),
                          new Container(
                            child: Screenshot(
                              controller: _screenshotController,
                              child:
                              QrImage(
                                //place where the QR Image will be shown
                                data: getUserId().toString(),
                                backgroundColor: Colors
                                    .white, // To NOT make it a png (black on black)
                              ),
                            ),
                            height: size.height * 0.4,
                          ),

                          SizedBox(height: size.height * 0.02,),

                          RoundedButton(
                            text: "Share QR",
                            press: () {_takeScreenshot();},
                          ),

                          /*Row(
                            children: [
                              SizedBox(width: size.width * 0.2,),
                              GestureDetector(
                                onTap: (){

                                  },
                                child: Column(
                                  children: [
                                    Icon(Icons.download_outlined,
                                      color: Colors.green, size: 50,),
                                    Text("Save QR", style: TextStyle(
                                      fontFamily: "Montserrat Regular",
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                    ),),
                                  ],
                                ),
                              ),

                              SizedBox(width: 80,),
                              GestureDetector(
                                onTap: _takeScreenshot,

                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.share_outlined, color: Colors.blue,
                                      size: 45,),
                                    SizedBox(height: size.height * 0.0035,),
                                    Text("Share QR", style: TextStyle(
                                      fontFamily: "Montserrat Regular",
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                    ),),
                                  ],
                                ),
                              ),


                            ],
                          )*/

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      );

  }

  void _takeScreenshot() async
  {
    final uint8List = await _screenshotController.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/image.png');
    await file.writeAsBytes(uint8List);
    await Share.shareFiles([file.path]);
  }



  Future<void> _saveToGallery(File imageFile) async {
    try {
      final result =
      await ImageGallerySaver.saveImage(imageFile.readAsBytesSync());
      debugPrint("Image Stored Successfully !!");
    } on Exception catch (exp) {
      debugPrint("Image Exception ${exp.toString()}");
    }
  }


}
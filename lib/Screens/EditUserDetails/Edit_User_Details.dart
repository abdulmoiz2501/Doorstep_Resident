import 'dart:io';
import 'package:DoorStep/Screens/Dashboard/Dashboard.dart';
import 'package:DoorStep/Services/Firestore_PersonalDetails.dart';
import 'package:DoorStep/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditUserDetails extends StatefulWidget {

  String emailID,fullName,cnic,phone,phase,street,houseNo,postalCode;

  EditUserDetails(this.emailID,this.fullName,this.cnic,this.phone,this.phase,this.street,this.houseNo,this.postalCode);

  @override
  _EditUserDetailsState createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
  String url;
  //final User user = auth.currentUser;


  //String _name;
  //String imageUrl;
  File _image;
  File avatarImageFile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controller = PageController(
    initialPage: 0,
  );

  final TextEditingController _email = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _cnic = TextEditingController();
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _phase = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _houseNo = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();



  @override
  void initState() {
    super.initState();
    setState(() {
      _email.text=widget.emailID;
      _fullName.text=widget.fullName;
      _cnic.text=widget.cnic;
      _phoneNo.text=widget.phone;
      _phase.text=widget.phase;
      _street.text=widget.street;
      _houseNo.text=widget.houseNo;
      _postalCode.text=widget.postalCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Color(0xFF6F35A5),
        ),
      ),
      body: Form(
        key: _formKey,
        child:  PageView
        // PERSONAL DETAILS AND ADDRESS DETAILS
          (
            controller: controller,
            children:
            [
              // personal details
              SingleChildScrollView(
                child: new Container(
                  alignment: Alignment.topCenter,
                  color: Colors.white,
                  child: new Column(
                    children: [
                      SizedBox(
                        height:size.height*0.025,
                      ),
                      Text(
                        'Personal Details',
                        style: TextStyle(
                          fontFamily: 'Montserrat Medium',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height:size.height*0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            // child: (_image == null)
                            //     ?
                            //     CircleAvatar(
                            //       backgroundColor: Colors.red,
                            //       radius: 80,
                            //     ):
                            // CircleAvatar(
                            //   radius: 80,
                            //   backgroundColor: Color(0xFF6F35A5),
                            //   child: ClipOval(
                            //     child: SizedBox(
                            //       width: 180,
                            //       height: 180,
                            //     ),
                            //   ),
                            //   //backgroundImage:,
                            //   )
                            //:
                             child: (_image ==null)?  Icon(Icons.person, size: 60, color: Colors.black,) : FutureBuilder<QuerySnapshot>(
                                 future: FirebaseFirestore.instance.collection('profile').get(),
                               // future: FirebaseFirestore.instance.collection('profile').doc('uid').get(),
                                builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      print('In Loading Picture Function');
                                      final List<DocumentSnapshot> documents = snapshot.data.docs;
                                      final User user = auth.currentUser;
                                      final uid = user.uid;
                                      if (snapshot.data != null) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: documents.map((doc) =>
                                                CircleAvatar(
                                                  radius: 80,
                                                  child: ClipOval(
                                                    child: Image.network(doc['image'] as String,
                                                      fit: BoxFit.fill,
                                                      height: 180,
                                                      width: 180,
                                                      alignment: Alignment.center,
                                                    ),
                                                  ),
                                                ),
                                            ).toList(),
                                          ),
                                        );
                                      }


                                      else {
                                        print('1st else');

                                        return Text('no data');
                                      }
                                    }
                                //  }
                                  else if (snapshot.hasError) {
                                    print('1st else if');
                                    return Text(snapshot.error.toString());
                                  }
                                  else{
                                    print('2nd else');
                                    return Center(child:  CircularProgressIndicator(
                                      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF6F35A5)),
                                    ),);
                                  }

                                }),
                           // child: CircleAvatar(
                           //    radius: 80,
                           //    backgroundColor: Colors.white,
                           //        child: (_image == null) ? Icon(Icons.person, size: 60, color: Colors.black,) : Container(
                           //          child: loadPicture(),
                           //          decoration: BoxDecoration(
                           //            shape: BoxShape.circle,
                           //            image: DecorationImage(
                           //              fit: BoxFit.fill,
                           //              image: FileImage(
                           //                _image,
                           //
                           //              ),
                           //            ),
                           //          ),
                           //        ),
                           //  ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 60),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.cameraRetro,
                                size: 25,
                              ),
                              onPressed: (){
                                getFromGallery();
                              },
                            ),
                          ),
                        ],
                      ),

                      // Image.asset(
                      //   'assets/images/personal_Info.png',
                      //   width: size.height*0.33,
                      // ),
                      SizedBox(
                        height: size.height*0.03,
                      ),
                      /*
                    1: text is wrapped in align
                    2: a sized box is used
                    3: a text field is wrapped in container
                    4: enabled border and focus border is used
                      */

                      // Full Name
                      customTextField("Full Name", _fullName, size ),
                      // CNIC
                      customTextField("Cnic", _cnic, size),
                      // PHONE
                      customTextField("Phone", _phoneNo, size),
                      // EMAIL
                      customTextField("Email", _email, size,readOnly: true),

                      SizedBox(
                        height: size.height*0.01,
                      ),

                      // SUBMIT BUTTON
                      SizedBox(
                        height: size.height*0.08,
                        width: size.width*0.6,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              controller.animateTo(
                                  MediaQuery.of(context).size.width,
                                  duration: new Duration(milliseconds: 600),
                                  curve: Curves.easeIn);
                             // print(url);
                              uploadPicture(_fullName.text, _image, url);
                            }
                          },
                          color: Color(0xff6F35A5),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: 'Montserrat Medium',
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // address details
              SingleChildScrollView(
                child: new Container(
                  alignment: Alignment.topCenter,
                  color: Colors.white,
                  child: new Column(
                    children: [
                      SizedBox(
                        height:size.height*0.025,
                      ),
                      Text(
                        'Address Details',
                        style: TextStyle(
                          fontFamily: 'Montserrat Medium',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height:size.height*0.015,
                      ),
                      Image.asset(
                        'assets/images/address_info.png',
                        width: size.height*0.20,
                      ),
                      SizedBox(
                        height: size.height*0.03,
                      ),

                      /*
                    1: text is wrapped in align
                    2: a sized box is used
                    3: a text field is wrapped in container
                    4: enabled border and focus border is used
                      */

                      // Full Name
                      customTextField("Phase", _phase, size ),
                      // CNIC
                      customTextField("Street", _street, size),
                      // PHONE
                      customTextField("House no", _houseNo, size),
                      // EMAIL
                      customTextField("Postal Code", _postalCode, size,),

                      SizedBox(
                        height: size.height*0.01,
                      ),

                      // Buttons BACK and SUBMIT
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: size.height*0.08,
                            width: size.width*0.4,
                            child: RaisedButton(
                              onPressed: () {
                                controller.previousPage(
                                    duration: Duration(milliseconds: 600),
                                    curve: Curves.easeIn);
                              },
                              color: Color(0xff6F35A5),
                              child: Text(
                                'Back',
                                style: TextStyle(
                                  fontFamily: 'Montserrat Medium',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(color: Colors.black)),
                            ),
                          ),
                          SizedBox(
                            height: size.height*0.08,
                            width: size.width*0.4,
                            child: RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  inputData();

                                  print("submit button"+ url);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder : (context)=> Dashboard()),);
                                }
                              },
                              color: Color(0xff6F35A5),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontFamily: 'Montserrat Medium',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(color: Colors.black)),


                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),

            ],
            physics: NeverScrollableScrollPhysics()
        ),

      ),
    );
  }

  Widget customTextField(String title ,var controller , Size size,{bool readOnly = false} )
  {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '         $title',
            style: TextStyle(
              fontFamily: 'Montserrat Medium',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        SizedBox(
          height: size.height*0.005,
        ),
        new Container(
          height: size.height*0.07,
          width: size.width*0.85,
          child: TextFormField(
            readOnly: readOnly,
            validator: (value) {
              if (value.isEmpty) {
                return 'Field is Empty';
              }
              return null;
            },
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height*0.02,
        ),
      ],
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  //final User user = auth.currentuser;

  void inputData() async {

    final ProgressDialog pr = ProgressDialog(context);
    pr.style(
      message: 'Please Wait...',
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF6F35A5)),
      ),
    );
    pr.show();

    // getting current user id
    final User user = auth.currentUser;
    final uid = user.uid;

    // updating data entered by user
    await DataBaseService(uid: user.uid).editProduct(_fullName.text, _cnic.text, _phoneNo.text,
        _email.text, _phase.text , _street.text, _houseNo.text , _postalCode.text, ).whenComplete(() =>pr.hide());

    if (user != null)
    {
      print(url);
      Navigator.pushReplacement(context, MaterialPageRoute(builder : (context)=> Dashboard(),),);
    }
  }


  getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Widget loadPicture()
  // {
  //   FutureBuilder<QuerySnapshot>(
  //       future: FirebaseFirestore.instance.collection('profile').get(),
  //       builder: (context, snapshot) {
  //         if(snapshot.connectionState == ConnectionState.waiting){
  //           print('waiting');
  //           final ProgressDialog pr = ProgressDialog(context);
  //           pr.style(
  //             message: 'Please Wait...',
  //             progressWidget: CircularProgressIndicator(
  //               valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF6F35A5)),
  //             ),
  //           );
  //           pr.show();
  //         if (snapshot.hasData) {
  //           print('In Loading Picture Function');
  //           final List<DocumentSnapshot> documents = snapshot.data.docs;
  //           if (snapshot.data != null) {
  //             return Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Column(
  //                 children: documents.map((doc) =>
  //                     CircleAvatar(
  //                       radius: 80,
  //                       child: Image.network(doc['image'] as String,
  //                         fit: BoxFit.cover,
  //                         height: double.infinity,
  //                         width: double.infinity,
  //                         alignment: Alignment.center,
  //                       ),
  //                     ),
  //                 ).toList(),
  //               ),
  //             );
  //           }
  //
  //
  //           else {
  //             print('1st else');
  //
  //             return Text('no data');
  //           }
  //         }
  //       }
  //         else if (snapshot.hasError) {
  //           print('1st else if');
  //           return Text(snapshot.error.toString());
  //         }
  //         else{
  //           print('2nd else');
  //           return Center(child:  CircularProgressIndicator(
  //             valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF6F35A5)),
  //           ),);
  //         }
  //
  //       });
  //
  //  // return Image.network(doc['image'] as String;
  // }



  Future <void> uploadPicture(String name,File image, String url) async
  {
   // final FirebaseAuth auth = FirebaseAuth.instance;

    final User user = auth.currentUser;
    final uid = user.uid;
    final CollectionReference profile =  FirebaseFirestore.instance.collection('profile');
    //name = this._fullName as String;
    final ProgressDialog pr = ProgressDialog(context);
    pr.style(
      message: 'Please Wait...',
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF6F35A5)),
      ),
      progress: 0,
      maxProgress: 100,
    );
    pr.show();

    FirebaseStorage storage = FirebaseStorage.instance;
    //String url;
    if (image == null)
    {
      await profile.doc(uid).set({
        "name": name,
        "image": null,
      }).whenComplete(() => {
        pr.hide(),

      });
    }
    else if(image != null)
    {
      Reference ref = storage.ref().child("image" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(image);
      uploadTask.whenComplete(() async{
        url = await ref.getDownloadURL();
        print("url: $url");
        if (url != null )
        {
          await profile.doc(uid).set({
            "name": name,
            "image": url,
          });
        }
      }).catchError((onError) {
        print(onError);
      }).whenComplete(() => {
        pr.hide(),

      });
      //loadPicture(_image);

    }
  }

  // getFromGallery() async {
  //   PickedFile pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 512,
  //     maxHeight: 512,
  //   );
  //   Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");
  //   await ref.putFile(File(pickedFile.path));
  //   ref.getDownloadURL().then((value){
  //     print(value+'value');
  //     setState(() {
  //       imageUrl = value;
  //       _image = File(pickedFile.path);
  //       url = imageUrl;
  //     });
  //   });
  //   if (_image != null) {
  //     setState(() {
  //       avatarImageFile = _image;
  //       print('Image detected');
  //     });
  //   }
  // }





  // uploadPic(File _image1, String url) async {
  //   PickedFile pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 512,
  //     maxHeight: 512,
  //   );
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference ref = storage.ref().child("image1" + DateTime.now().toString());
  //   UploadTask uploadTask = ref.putFile(_image1);
  //   uploadTask.whenComplete(() {
  //     url = ref.getDownloadURL() as String;
  //     print(url);
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  //   return url;
  // }
  //
  // Future<String> downloadURL(String imageName) async{
  //   String downloadURl = await storage.ref('test/$imageName').getDownloadURL();
  // }
  // uploadProfile(File image) async{
  //   final CollectionReference profile =  FirebaseFirestore.instance.collection('User Details');
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   String url;
  //   if (image == null)
  //   {
  //     await profile.doc().set({
  //       "image": null,
  //     }).whenComplete(() => {
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder : (context)=> Dashboard()),),
  //     });
  //   }
  //   else if(image != null)
  //   {
  //     Reference ref = storage.ref().child("image" + DateTime.now().toString());
  //     UploadTask uploadTask = ref.putFile(image);
  //     uploadTask.whenComplete(() async{
  //       url = await ref.getDownloadURL();
  //       print("url: $url");
  //       if (url != null )
  //       {
  //         await profile.doc().set({
  //           "image": url,
  //         });
  //       }
  //
  //     });
  //   }
  // }
  // Future <void> addProfile(File image )async {
  //
  //   final CollectionReference profile =  FirebaseFirestore.instance.collection('User Details');
  //
  //   final ProgressDialog pr = ProgressDialog(context);
  //   pr.style(
  //     message: 'Please Wait...',
  //     progressWidget: CircularProgressIndicator(
  //       valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF6F35A5)),
  //     ),
  //     progress: 0,
  //     maxProgress: 100,
  //   );
  //   pr.show();
  //
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   String url;
  //   if (image == null)
  //   {
  //     await profile.doc().set({
  //       // "title": title,
  //       // "description": description,
  //       "image": null,
  //     }).whenComplete(() => {
  //       pr.hide(),
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder : (context)=> Dashboard()),),
  //     });
  //   }
  //   if(image != null)
  //   {
  //     Reference ref = storage.ref().child("image" + DateTime.now().toString());
  //     UploadTask uploadTask = ref.putFile(image);
  //     uploadTask.whenComplete(() async{
  //       url = await ref.getDownloadURL();
  //       print("url: $url");
  //       if (url != null )
  //       {
  //         await profile.doc().set({
  //           // "title": title,
  //           // "description": description,
  //           "image": url,
  //         });
  //       }
  //
  //     }).catchError((onError) {
  //       print(onError);
  //     }).whenComplete(() => {
  //       pr.hide(),
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder : (context)=> Dashboard()),),
  //     });
  //
  //   }
  //
  // }

}

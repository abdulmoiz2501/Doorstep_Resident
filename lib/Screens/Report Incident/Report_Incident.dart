import 'dart:io';
import 'package:DoorStep/Screens/Incident/Incident.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ReportIncident extends StatefulWidget {
  @override
  _ReportIncidentState createState() => _ReportIncidentState();
}

class _ReportIncidentState extends State<ReportIncident> {
  File _image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [


              SizedBox(
                height: size.height*0.08,
              ),

              Text("Fill the Information",style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),),

              SizedBox(
                height: size.height*0.04,
              ),

              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color:Colors.grey.shade300),
                    color: Colors.grey.shade200,
                  ),
                  height: size.height*0.08,
                  width: size.width*0.9,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0,22,10,10),
                    child: TextFormField(
                      maxLength: 25,
                      buildCounter: (BuildContext context, { int currentLength, int maxLength, bool isFocused }) => null,
                      controller: _title,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Field is Empty';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontFamily: "Montserrat Regular",
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: Colors.black,
                      decoration: InputDecoration (
                        hintText: "Enter Title",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        ),
                      ),

                      ),

                    ),
                  ),

              SizedBox(
                height: size.height*0.04,
              ),


              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color:Colors.grey.shade300),
                    color: Colors.grey.shade200,
                  ),
                  height: size.height*0.25,
                  width: size.width*0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                        maxLines: 25,
                      controller: _description,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Field is Empty';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 18,
                        fontFamily: "Montserrat Regular",
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: Colors.black54,
                      decoration: InputDecoration (
                        hintText: "Enter Description",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),

                  ),

                ),
              ),

              SizedBox(
                height: size.height*0.04,
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color:Colors.grey.shade300),
                  color: Colors.grey.shade200,
                ),
                height: size.height*0.3,
                width: size.width*0.9,
                child: _image == null ?  Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: GestureDetector(
                          onTap: (){getFromGallery();},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFB9C0DA),
                              borderRadius: BorderRadius.all(Radius.circular(8))
                            ),

                            child: Center(child: Text("Upload From Device",style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),)),

                          ),
                        ),
                      ),
                    ),

                    Align(alignment: Alignment.center,child: Text("OR",style: TextStyle(
                      fontSize: 24,
                      color: Colors.black54,
                      fontFamily: "Montserrat Regular",
                      fontWeight: FontWeight.bold,
                    ),)),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: GestureDetector(
                          onTap: (){getFromCamera();},
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFB9C0DA),
                                borderRadius: BorderRadius.all(Radius.circular(8))
                            ),
                            child: Center(child: Text("Take Picture From Camera",style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),)),

                          ),
                        ),
                      ),
                    ),

                  ],
                ) : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.file(_image,
                            fit: BoxFit.cover,                            ),
                          Align( alignment: Alignment.topLeft ,child: GestureDetector(onTap: (){
                            setState(() {
                              _image = null;
                            });
                          },child: Icon(Icons.delete,color: Colors.red,))),
                        ],
                      ),
                  ),
                ) ,
              ),

              SizedBox(
                height: size.height*0.03,
              ),

              // report button
              SizedBox(
                height: size.height*0.08,
                width: size.width*0.8,
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {

                        addIncident(_title.text,_description.text,_image);
                      }
                    },
                    color: Color(0xff6F35A5),
                    child: Text(
                      'Report',
                      style: TextStyle(
                        fontFamily: 'Montserrat Medium',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.black)),


                  ),

              )

            ],
          ),
        ),

      ),
    );

  }//second


  /// Get from gallery
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

  /// Get from Camera
  getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }


  Future <void> addIncident(String title , String description,File image )async {

    final CollectionReference incident =  FirebaseFirestore.instance.collection('Incident');

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
    String url;
    if (image == null)
    {
      await incident.doc().set({
        "title": title,
        "description": description,
        "image": null,
      }).whenComplete(() => {
        pr.hide(),
        Navigator.pushReplacement(context, MaterialPageRoute(builder : (context)=> Incident()),),
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
            await incident.doc().set({
              "title": title,
              "description": description,
              "image": url,
            });
          }

        }).catchError((onError) {
          print(onError);
        }).whenComplete(() => {
          pr.hide(),
          Navigator.pushReplacement(context, MaterialPageRoute(builder : (context)=> Incident()),),
        });

      }

  }

  }// final



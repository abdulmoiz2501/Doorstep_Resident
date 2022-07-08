import 'package:DoorStep/Screens/Reservation/Reservation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../constants.dart';

class MakeReservation extends StatefulWidget {
  @override
  _MakeReservationState createState() => _MakeReservationState();
}

class _MakeReservationState extends State<MakeReservation> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  String getUserId() {
    // getting current user id
    final User user = auth.currentUser;
    return user.uid;
  }

  var _chosenValueVenue ;
  DateTime selectedDate = DateTime.now();
  final TextEditingController _occasion = TextEditingController();
  final TextEditingController _person = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Color(0xFF6F35A5),
        ),
      ),
      body :Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [

                SizedBox(
                  height: size.height*0.08,
                ),

                Text("Make Reservation",style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),),

                SizedBox(
                  height: size.height*0.04,
                ),

                // ENTER OCASSION
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
                        controller: _occasion,
                        validator: (value) {
                          if (value.isEmpty) {
                            return '*';
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
                          hintText: "Enter Occasion",
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

                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color:Colors.grey.shade300),
                      color: Colors.grey.shade200,
                    ),
                    height: size.height*0.08,
                    width: size.width*0.9,
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 26,
                      elevation: 16,
                      underline: SizedBox(),
                      value: _chosenValueVenue,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black54,
                      fontFamily: 'Montserrat Regular',
                        fontSize: 20,
                          fontWeight: FontWeight.w900,
                      ),

                      items: <String>[
                        'Central park',
                        'Coffee Shop',
                        'Cafe 24/7',
                        'Hotel Pearl',
                        'Pizza Hut',
                        'Tokyo Cafe',
                        'Club 90',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        "Choose Venue",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                            fontFamily: 'Montserrat Regular',
                            fontWeight: FontWeight.w900),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _chosenValueVenue = value;
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(
                  height: size.height*0.04,
                ),

                //calender
                Row(
                  children: [
                    SizedBox(
                      width: size.width*0.05,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color:Colors.grey.shade300),
                        color: Colors.grey.shade200,
                      ),
                      height: size.height*0.08,
                      width: size.width*0.55,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12,12,12,12),
                        child: Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontFamily: 'Montserrat Regular'),
                        ),

                      ),

                    ),
                    SizedBox(
                      width: size.width*0.04,
                    ),
                    RaisedButton(
                      onPressed: () => _selectDate(context), // Refer step 3
                      child: Text(
                        'Select date',
                        style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.black)),

                    ),
                  ],
                ),

                SizedBox(
                  height: size.height*0.04,
                ),

                // reserve members
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
                        controller: _person,
                        validator: (value) {
                          if (value.isEmpty) {
                            return '*';
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
                          hintText: "Enter Persons",
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
                  height: size.height*0.2,
                ),

                // reserve button
               SizedBox(
                    height: size.height*0.08,
                    width: size.width*0.8,
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {

                          makeReservation(_occasion.text, _chosenValueVenue.toString() ,selectedDate.toLocal().toString().split(' ')[0], _person.text);
                        }
                      },
                      color: Color(0xff6F35A5),
                      child: Text(
                        'Reserve',
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

                  ),




              ],
            ),
          ),
        ),
      ),
    );
  }
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      /*builder: (context, child) {
        return Theme(
          data: ThemeData., // This will change to light theme.
          child: child,
        );
      },*/
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future <void> makeReservation(String occasion , String venue , String date , String person  )async {

    final CollectionReference incident =  FirebaseFirestore.instance.collection('Reservation');

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
    try{
      await incident.doc().set({
        "occasion": occasion,
        "venue": venue,
        "date": date,
        "person": person,
        "uid": getUserId().toString(),

      }).whenComplete(() => {
        pr.hide(),
        Navigator.pushReplacement(context, MaterialPageRoute(builder : (context)=> Reservation()),),
      });
    }
    catch (e)
    {
      print(e);
    }



  }







}



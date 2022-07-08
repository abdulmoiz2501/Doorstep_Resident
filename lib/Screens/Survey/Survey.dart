import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class Survey extends StatefulWidget {
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Color(0xFF6F35A5),
        ),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Text(
              'Survey',
              style: TextStyle(
                fontFamily: 'Montserrat Medium',
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              'assets/images/surveyScreen.png',
              height: 150,
              width: 300,
            ),
            SizedBox(
              height: 5,
            ),

            Expanded(
                child:FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance.collection('survey').get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents = snapshot.data.docs;
                        if(snapshot.data!=null){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                                children: documents.map((doc) => Card(
                                  child:Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white,
                                          border: Border.all(color: Color(0xFF6F35A5)),
                                        ),

                                        child: GestureDetector(
                                          onTap: (){
                                            _service(doc['link']);
                                          },
                                          child: Container(
                                            height: 100,
                                            child: ListTile(
                                              leading: SizedBox(
                                                height: 50 ,
                                                width: 50,
                                                child: Image.asset('assets/icons/survey.png'),
                                              ),
                                              title:  Text(doc['title'].toString().toUpperCase(),style: TextStyle(
                                                  //fontFamily: "Montserrat Medium",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 24,
                                                  //color: Color(0xFF6F35A5),
                                                ),),
                                              subtitle: SingleChildScrollView(
                                                child: Text( doc['subtitle'],style: TextStyle(
                                                  fontFamily: "Montserrat Regular",
                                                  fontSize: 15,
                                                ),),
                                              ),


                                            ),
                                          ),
                                        ),
                                      ),
                                     )).toList()),
                          );
                        }
                        else {
                          return Center(child: Text('No data'));
                        }
                      }
                      else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      else{
                        return Center(child:  CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF6F35A5)),
                        ),);
                      }
                    })
            ),

          ],
        ),
      ),
    );
  }
  _service(String url) async {
    try{

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    catch (e)
    {
      print(e.code);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}
class _ServicesState extends State<Services> {

  CollectionReference ref = FirebaseFirestore.instance.collection('service');
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
              height: 20,
            ),
            Text(
              'Services',
              style: TextStyle(
                fontFamily: 'Montserrat Medium',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/images/serviceSurvey.png',
              height: 150,
              width: 300,
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child:FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection('service').get(),
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
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                      border: Border.all(color: Color(0xFF6F35A5)),
                                  ),

                                  child: ListTile(
                                    leading: SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: Image.asset('assets/icons/services.png'),
                                    ),

                                    trailing: Wrap(
                                      spacing: 12, // space between two icons
                                      children: <Widget>[
                                      GestureDetector(child: Icon(Icons.message,color: Colors.amber,),
                                        onTap:() {
                                          _service('sms:'+doc['number']);
                                        } ,
                                      ),
                                        GestureDetector(
                                          child: Icon(Icons.call, color: Colors.green,),
                                          onTap: () {
                                            _service('tel:'+doc['number']);
                                          }
                                        ),
                                      ],

                                    ),

                                    title: Text(doc['Service Name'],style: TextStyle(
                                      fontFamily: "Montserrat Medium",
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    subtitle: Text(doc['number'],style: TextStyle(
                                      fontFamily: "Montserrat Regular",
                                    ),),

                                  ),
                                ),)).toList()),
                        );
                      }
                      else {
                        return Text('no data');
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
            )
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


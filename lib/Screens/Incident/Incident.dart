import 'package:DoorStep/Screens/Report%20Incident/Report_Incident.dart';
import 'package:DoorStep/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';


class Incident extends StatefulWidget {
  @override
  _IncidentState createState() => _IncidentState();
}

class _IncidentState extends State<Incident> {
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
                'Incident',
                style: TextStyle(
                  fontFamily: 'Montserrat Medium',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Image.asset(
                'assets/images/emergencyScreen.png',
                height: 150,

              ),
              SizedBox(
                height: 15,
              ),

              // report an incident
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    border: Border.all(color: Colors.black),
                    color: kPrimaryColor,
                  ),
                  height: 40,
                  width: 280,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Report an Incident ",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat Regular",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ReportIncident()),
                  );
                },
              ),

              SizedBox(
                height: 4,
              ),

              Expanded(
                  child:FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance.collection('Incident').get(),
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
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white,
                                        border: Border.all(color: Color(0xFF6F35A5)),
                                      ),

                                        child: GestureDetector(
                                          onTap: (){
                                            return showDialog(context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: Column(
                                                  children: [
                                                    // closing buttons
                                                      Align(
                                                        child: GestureDetector(
                                                          onTap: (){Navigator.of(ctx).pop();},
                                                          child:Icon(Icons.close,color: kPrimaryColor,),
                                                        ),
                                                        alignment: Alignment.centerRight,
                                                      ),

                                                    // Title text
                                                      Align(
                                                          child: Container(
                                                            child: Text("Title",style: TextStyle(
                                                              color:Colors.grey.shade700 ,
                                                            ),),
                                                          ),
                                                          alignment: Alignment.centerLeft,
                                                        ),

                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Align(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(color: Color(0xFF6F35A5)),
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(doc["title"],style: TextStyle(
                                                            color:Colors.black54 ,
                                                          ),),
                                                        ),
                                                      ),
                                                      alignment: Alignment.centerLeft,
                                                    ),
                                                  ],
                                                ),

                                                content: Container(
                                                  height: MediaQuery.of(context).size.height / 3,
                                                  child: Column(
                                                    children: [

                                                      Align(
                                                        child: SingleChildScrollView(
                                                          child: Container(
                                                           child: Text("Description",style: TextStyle(
                                                              color:Colors.grey.shade700 ,
                                                            ),),
                                                          ),
                                                        ),
                                                        alignment: Alignment.centerLeft,
                                                      ),

                                                      SizedBox(
                                                        height: 4,
                                                      ),

                                                      Container(

                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(color: Color(0xFF6F35A5)),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(doc["description"],style: TextStyle(
                                                              color:Colors.black54 ,
                                                            ),),
                                                          )
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              ),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Container (
                                                decoration: BoxDecoration(
                                                  color: Colors.black87,
                                                  border: Border.all(color: Color(0xFF6F35A5)),
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(12.0),
                                                      topLeft: Radius.circular(12.0)),
                                                ),
                                                child: doc['image'] == null ? Center(
                                                  child: Text("No Image",style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                  ),),
                                                ) : Image.network(doc['image'],
                                                  fit: BoxFit.cover,
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  alignment: Alignment.center,),
                                                height: 150 ,
                                                width: double.infinity ,
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Align(alignment: Alignment.centerLeft,child: Text(doc['title'],style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black87,
                                                 // fontFamily: "Montserrat Medium",
                                                  fontWeight: FontWeight.bold,
                                                ),)),
                                              ),
                                              Divider(
                                                height: 2,
                                                thickness: 1,
                                                indent : 5,
                                                endIndent: 5,
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(6.0),
                                                    child: Align(alignment: Alignment.centerLeft,child: Text("Description",style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black54,
                                                      // fontFamily: "Montserrat Medium",

                                                    ),)),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(6.0),
                                                    child: Container(
                                                      height: 20,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(color: Color(0xFF6F35A5)),
                                                          borderRadius: BorderRadius.circular(25),
                                                        ),

                                                      child:Center(
                                                        child: Text("Incident",style : TextStyle(
                                                          color: kPrimaryColor,
                                                        ),),
                                                      )
                                                    ),
                                                  ),

                                                ],
                                              ),

                                              SizedBox(
                                                height: 10,
                                              ),

                                            ],
                                          ),
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
              ),
            ],
          ),
        ),

    );
  }
}

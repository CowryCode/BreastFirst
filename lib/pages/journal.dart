import 'package:breastfirst/api/FireStore.dart';
import 'package:breastfirst/api/model/leaderboard.dart';
import 'package:breastfirst/api/network.dart';
import 'package:breastfirst/pages/babyroom.dart';
import 'package:breastfirst/pages/components/performancetable.dart';
import 'package:breastfirst/pages/journalInput.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class JournalScreen extends StatefulWidget {
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  Future<LeaderBoard>? leaderboard;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leaderboard = ApiAccess().getLeaderBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: const Text('User Journal'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {

            },
          ),
        ],
      ),
      body:
      //SingleChildScrollView( child:
          FutureBuilder<LeaderBoard>(
            future: leaderboard,
            builder: (BuildContext context,
                AsyncSnapshot<LeaderBoard> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                //return Center(child: Text('Error: having some delays at the moment'));
                return Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData) {
                return Center(child: Text('No data available'));
              }

              LeaderBoard? data = snapshot.data;
              // Do something with 'data'...

              return _body(leaderBoard: data!);
            },
          ),
      //),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Journal()));
        },
        child: Icon(Icons.add), // You can use any Icon here
        backgroundColor: Colors.purple[100], // Customize button color if needed
      ),
    );
  }

  Widget _body({required LeaderBoard leaderBoard}) {
    String? USERid = motherDataNotifier.value.email;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('JournalCollection')
                  .doc(USERid).collection("Journal")
                  //.orderBy("dateCreated", descending:  true).limit(10)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                if (snapshot.data!.docs.length <  1) {
                  return Center(child: Text("No record yet . . ."));// Show TextBox when the list is empty
                }

                return Expanded(
                  child: ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      if (document == null)
                        return SizedBox(
                          height: 10,
                        );
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      Timestamp timestamp = data['timestamp'];
                      return Container(
                        padding:EdgeInsets.all(26.0),
                        margin:EdgeInsets.only(top: 10.0,left: 2.0,right: 2.0,bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [BoxShadow( color: Colors.grey.withOpacity(0.4), offset: Offset(2,4), blurRadius: 10)],
                           color: Colors.purple[100],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                'Date : ${comvertDateTimetoDate(dateTime: timestamp.toDate())}',
                                style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.0,
                                color: Colors.grey,

                              ),
                            ),
                            Text(
                                '${data['journal']}',
                                 style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.0,
                                //fontWeight: FontWeight.bold,
                                color:Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ]

      ),
    );
  }
  String comvertDateTimetoDate({required DateTime dateTime}) {
    var formatter = DateFormat('yyyy-MM-dd');
    String date = formatter.format(dateTime);
    return date;
  }
}
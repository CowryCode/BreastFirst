import 'package:breastfirst/api/FireStore.dart';
import 'package:breastfirst/api/model/leaderboard.dart';
import 'package:breastfirst/api/network.dart';
import 'package:breastfirst/pages/babyroom.dart';
import 'package:breastfirst/pages/components/performancetable.dart';
import 'package:breastfirst/pages/store.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AchievementsScreen extends StatefulWidget {
  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  Future<LeaderBoard>? leaderboard;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leaderboard  =  ApiAccess().getLeaderBoard();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: Text('Achievements'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle the menu button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<LeaderBoard>(
          future: leaderboard,
          builder: (BuildContext context, AsyncSnapshot<LeaderBoard> snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // If there's an error with the Future, display an error message.
              return Center(child: Text('Error: having some delays at the moment ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data available'));
            }

            LeaderBoard? data = snapshot.data;
            // Do something with 'data'...

            return _body(leaderBoard: data!);
          },
        ) ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.room), label: 'Room'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      //   Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Column(
      //       children: [
      //         achievementItem(title:'Breastfeeding', target: '< 8 times per day', score: 5, progress: 80, isbreastfeeding: true),
      //         achievementItem(title: 'Pumping', target: '< 5 times per day', score:  4, progress: 90, isPumping: true),
      //         achievementItem(title: 'Diaper', target: '8 times per day', score: 2, progress: 16),
      //         achievementItem(title:'Sleep', target: '< 15 hours per day', score: 15, progress: 100),
      //         SizedBox(height : 30),
      //         Wrap(
      //           children: [
      //             ElevatedButton(
      //               child: Text('store test'),
      //               onPressed: () {
      //                 ApiAccess().getLeaderBoard();
      //                 //Navigator.push(context, MaterialPageRoute(builder: (context) => StoreScreen()),);
      //               },
      //             ),
      //             ElevatedButton(
      //               child: Text('babyroom'),
      //               onPressed: () {
      //                 Navigator.push(context, MaterialPageRoute(builder: (context) => BabysRoomScreen()),);
      //               },
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.room), label: 'Room'),
      //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      //   ],
      // ),
    );
  }

  Widget _body({required LeaderBoard leaderBoard}){
    return    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          achievementItem(title:'Breastfeeding', target: '< ${leaderBoardNotifier.value.userStatus!.todayBreastFeedingCount} times per day', score: 5, progress: 80, isbreastfeeding: true),
          achievementItem(title: 'Pumping', target: '< ${leaderBoardNotifier.value.userStatus!.todayPumpingCount} times per day', score:  4, progress: 90, isPumping: true),
          achievementItem(title: 'Bottling', target: ' < ${leaderBoardNotifier.value.userStatus!.todayBottlingCount} times per day', score: 2, progress: 16),
          achievementItem(title:'Sleep', target: '< 15 hours per day', score: 15, progress: 100),
          SizedBox(height : 30),
          Wrap(
            children: [
              ElevatedButton(
                child: Text('store test'),
                onPressed: () {
                  ApiAccess().getLeaderBoard();
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => StoreScreen()),);
                },
              ),
              ElevatedButton(
                child: Text('babyroom'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BabysRoomScreen()),);
                },
              ),
            ],
          ),
          PerformanceTable(),
        ],
      ),
    );
  }

  Widget achievementItem({required String title, required String target, required int score, required double progress, bool isPumping = false, bool isbreastfeeding = false, bool isbottling = false,}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(target),
          Text('$score'),
          Container(
            width: 100,
            child: LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[300]!),
            ),
          ),
          Text('$progress%')
        ],
      ),
    );

    String dataType = (isPumping == true) ? FireStoreConnect().pumpingCollection : (isbreastfeeding == true) ?  FireStoreConnect().bottlingcollection : FireStoreConnect().breastCollection;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("BreastFeedingData").doc(
          motherDataNotifier.value.email).collection(
          dataType).snapshots(),

      // stream: FirebaseFirestore.instance.collection("BreastFeedingData").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

       // FireStoreConnect().getbreastData(snapshot as QuerySnapshot<Map<String, dynamic>>);
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        // print('${snapshot.data!.docs.length} DOCUMENTS Returned');
        print('All Docs : ${snapshot.data!.docs.length}');
        List<QueryDocumentSnapshot<Object?>> allDocs = snapshot.data!.docs;
        print('Number of items for dataType :  ${allDocs.length}');

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(target),
              Text('$score'),
              Container(
                width: 100,
                child: LinearProgressIndicator(
                  value: progress / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[300]!),
                ),
              ),
              Text('$progress%')
            ],
          ),
        );
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(target),
          Text('$score'),
          Container(
            width: 100,
            child: LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[300]!),
            ),
          ),
          Text('$progress%')
        ],
      ),
    );
  }
}
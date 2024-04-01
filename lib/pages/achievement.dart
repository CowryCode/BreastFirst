import 'package:breastfirst/api/FireStore.dart';
import 'package:breastfirst/api/model/leaderboard.dart';
import 'package:breastfirst/api/model/motherdata.dart';
import 'package:breastfirst/api/network.dart';
import 'package:breastfirst/pages/babyroom.dart';
import 'package:breastfirst/pages/components/performancetable.dart';
import 'package:breastfirst/pages/invitation.dart';
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
  
  bool viewOthersAchievement = false;
  bool selectUser = false;
  String? selectedUser = '';

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
          builder: (BuildContext context, AsyncSnapshot<LeaderBoard> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Press button to start.');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.hasError)
                  return Center(child: Text('No data yet!'));
                return _body();
            }
          },
        )

        //_body(),
       )
    );
  }

  Widget _othersPersonalAchievements(){
    return FutureBuilder<LeaderBoard>(
      future: leaderboard,
      builder: (BuildContext context, AsyncSnapshot<LeaderBoard> snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          // return Center(child: Text('Error: having some delays at the moment ${snapshot.error}'));
          return Center(child: Text('No data available'));
        }
        if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        }else{
          LeaderBoard? leaderboard = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // achievementItem(title:'Breastfeeding', target: '< ${leaderboard!.userStatus!.todayBreastFeedingCount} daily Avg', score: 5, progress: 80, isbreastfeeding: true),
                // achievementItem(title: 'Pumping', target: '< ${leaderboard.userStatus!.todayPumpingCount} daily Avg', score:  4, progress: 90, isPumping: true),
                // achievementItem(title: 'Bottling', target: ' < ${leaderboard.userStatus!.todayBottlingCount} daily Avg', score: 2, progress: 16),
                // achievementItem(title:'Sleep', target: '< 15 hours per day', score: 15, progress: 100),
                achievementItem(title:'Breastfeeding: (${leaderboard!.userStatus!.todayBreastFeedingCount})', target: 10, score: leaderboard.userStatus!.todayBreastFeedingCount!, progress: 0, isbreastfeeding: true),
                achievementItem(title: 'Pumping: (${leaderboard.userStatus!.todayPumpingCount})', target: 10, score:  leaderboard.userStatus!.todayPumpingCount!, progress: 0, isPumping: true),
                achievementItem(title: 'Bottling: (${leaderboard.userStatus!.todayBottlingCount})', target: 10, score: leaderboard.userStatus!.todayBottlingCount!, progress: 0),
                achievementItem(title:'Sleep (0)', target: 10, score: 0, progress: 0),
                SizedBox(height : 10),
                Wrap(
                  children: [
                    ElevatedButton(
                      child: Text('Share My \n Achievements', textAlign: TextAlign.center,),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InvitationScreen()),);
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => StoreScreen()),);
                      },
                    ),
                    ElevatedButton(
                      child: (viewOthersAchievement)? Text('View \n Leaderboard', textAlign: TextAlign.center,) : Text('View Others \n Achievements', textAlign: TextAlign.center,),
                      onPressed: () {
                        setState(() {
                          viewOthersAchievement = !viewOthersAchievement;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height : 10),
                Divider(height: 5,),
                // SizedBox(height : 10),
                // (!viewOthersAchievement)? PerformanceTable()
                //     :
                // ValueListenableBuilder(
                //   valueListenable: motherDataNotifier,
                //   builder: (context, Motherdata motherdata, child){
                //     return StreamBuilder<QuerySnapshot>(
                //         stream: FirebaseFirestore.instance.collection('ShareCollection').where("sharedTo", isEqualTo: motherdata.email)
                //             .snapshots(),
                //         builder: (BuildContext context,
                //             AsyncSnapshot<QuerySnapshot> snapshot) {
                //           if (snapshot.hasError) {
                //             return const Text('No shared progress yet');
                //           }
                //           if (snapshot.connectionState == ConnectionState.waiting) {
                //             return const Text('No shared progress yet');
                //           }
                //           if (!snapshot.hasData) {
                //             return const Text('No shared progress yet');
                //           } else {
                //             if (snapshot.data!.size > 0) {
                //               Map<String, dynamic> data = snapshot.data!.docs.first
                //                   .data() as Map<String, dynamic>;
                //               //return Text(data["name"], style: TextStyle(color: Colors.black));
                //               return Wrap(
                //                 children: snapshot.data!.docs.map((
                //                     DocumentSnapshot document) {
                //                   if (document == null)
                //                     return SizedBox(
                //                       height: 10,
                //                     );
                //                   Map<String, dynamic> data = document.data()! as Map<
                //                       String,
                //                       dynamic>;
                //                   //Timestamp timestamp = data['timestamp'];
                //                   return ElevatedButton(
                //                     child: Text('${data['name']}'),
                //                     onPressed: () {
                //                     },
                //                   );
                //                 }).toList(),
                //               );
                //             }
                //           }
                //           return const Text('');
                //         });
                //   },
                // ),
              ],
            ),
          );
        }
      },
    );
  }


  Widget _personalAchievements(){
    return ValueListenableBuilder(
        valueListenable: leaderBoardNotifier,
        builder: (context, LeaderBoard leaderboard, child){
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child:Column(
              children: [
                // achievementItem(title:'Breastfeeding:', target: '< ${leaderboard.userStatus!.todayBreastFeedingCount} times per day', score: 5, progress: 80, isbreastfeeding: true),
                // achievementItem(title: 'Pumping: ', target: '< ${leaderboard.userStatus!.todayPumpingCount} times per day', score:  4, progress: 90, isPumping: true),
                // achievementItem(title: 'Bottling: ', target: ' < ${leaderboard.userStatus!.todayBottlingCount} times per day', score: 2, progress: 16),
                // achievementItem(title:'Sleep: ', target: '< 15 hours per day', score: 15, progress: 100),
                achievementItem(title:'Breastfeeding: (${leaderboard.userStatus!.todayBreastFeedingCount})', target: 10, score: leaderboard.userStatus!.todayBreastFeedingCount!, progress: 0, isbreastfeeding: true),
                achievementItem(title: 'Pumping: (${leaderboard.userStatus!.todayPumpingCount})', target: 10, score: leaderboard.userStatus!.todayPumpingCount!, progress: 0, isPumping: true),
                achievementItem(title: 'Bottling: (${leaderboard.userStatus!.todayBottlingCount})', target: 10, score: leaderboard.userStatus!.todayBottlingCount!, progress: 0),
                achievementItem(title:'Sleep: (0)', target: 10, score: 0, progress: 0),
                SizedBox(height : 10),
                Wrap(
                  children: [
                    ElevatedButton(
                      child: Text('Share My \n Achievements', textAlign: TextAlign.center,),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InvitationScreen()),);
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => StoreScreen()),);
                      },
                    ),
                    ElevatedButton(
                      child: (viewOthersAchievement)? Text('View \n Leaderboard', textAlign: TextAlign.center,) : Text('View Others \n Achievements', textAlign: TextAlign.center,),
                      onPressed: () {
                        setState(() {
                          viewOthersAchievement = !viewOthersAchievement;
                        });
                      },
                    ),
                    // ElevatedButton(
                    //   child: Text('babyroom'),
                    //   onPressed: () {
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => BabysRoomScreen()),);
                    //   },
                    // ),
                  ],
                ),
                SizedBox(height : 10),
                Divider(height: 5,),
                // SizedBox(height : 10),
                // (!viewOthersAchievement)? PerformanceTable()
                //     :
                // ValueListenableBuilder(
                //   valueListenable: motherDataNotifier,
                //   builder: (context, Motherdata motherdata, child){
                //     return StreamBuilder<QuerySnapshot>(
                //         stream: FirebaseFirestore.instance.collection('ShareCollection').where("sharedTo", isEqualTo: motherdata.email)
                //             .snapshots(),
                //         builder: (BuildContext context,
                //             AsyncSnapshot<QuerySnapshot> snapshot) {
                //           if (snapshot.hasError) {
                //             return const Text('No shared progress yet');
                //           }
                //           if (snapshot.connectionState == ConnectionState.waiting) {
                //             return const Text('No shared progress yet');
                //           }
                //           if (!snapshot.hasData) {
                //             return const Text('No shared progress yet');
                //           } else {
                //             if (snapshot.data!.size > 0) {
                //               Map<String, dynamic> data = snapshot.data!.docs.first
                //                   .data() as Map<String, dynamic>;
                //               //return Text(data["name"], style: TextStyle(color: Colors.black));
                //               return Wrap(
                //                 children: snapshot.data!.docs.map((
                //                     DocumentSnapshot document) {
                //                   if (document == null)
                //                     return SizedBox(
                //                       height: 10,
                //                     );
                //                   Map<String, dynamic> data = document.data()! as Map<
                //                       String,
                //                       dynamic>;
                //                   //Timestamp timestamp = data['timestamp'];
                //                   return ElevatedButton(
                //                     child: Text('${data['name']}'),
                //                     onPressed: () {
                //                     },
                //                   );
                //                 }).toList(),
                //               );
                //             }
                //           }
                //           return const Text('');
                //         });
                //   },
                // ),
              ],
            ),
          );
        });





  }

  Widget _body(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          (selectUser)? _othersPersonalAchievements() : _personalAchievements(),
          SizedBox(height : 10),
          (!viewOthersAchievement)? PerformanceTable()
              :
          ValueListenableBuilder(
            valueListenable: motherDataNotifier,
            builder: (context, Motherdata motherdata, child){
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('ShareCollection').where("sharedTo", isEqualTo: motherdata.email)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('No shared progress yet');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('No shared progress yet');
                    }
                    if (!snapshot.hasData) {
                      return const Text('No shared progress yet');
                    } else {
                      if (snapshot.data!.size > 0) {
                        Map<String, dynamic> data = snapshot.data!.docs.first
                            .data() as Map<String, dynamic>;
                        //return Text(data["name"], style: TextStyle(color: Colors.black));
                        return Wrap(
                          children: snapshot.data!.docs.map((
                              DocumentSnapshot document) {
                            if (document == null)
                              return SizedBox(
                                height: 10,
                              );
                            Map<String, dynamic> data = document.data()! as Map<
                                String,
                                dynamic>;
                            //Timestamp timestamp = data['timestamp'];
                            return ElevatedButton(
                              child: Text('${data['sharerName']}'),
                              onPressed: () {
                                setState(() {
                                  selectUser = !selectUser;
                                  selectedUser = (selectUser)? data['sharerName']: null;
                                  leaderboard = ApiAccess().getLeaderBoard(user: data['sharedBy'] );
                                });
                              },
                            );
                          }).toList(),
                        );
                      }
                    }
                    return const Text('Nobody has shared result with you yet.');
                  });
            },
          ),
        ],
      ),
    );
  }

  Widget achievementItem({required String title, required int target, required int score, required double progress, bool isPumping = false, bool isbreastfeeding = false, bool isbottling = false,}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
         // Text(target),
         // Text('$score'),
          Container(
            width: 100,
            child: LinearProgressIndicator(
             // value: progress / 100,
              value: (score == 0) ? 0 : ((score/target) * 100 )/100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[300]!),
            ),
          ),
          Text('${(score/target) * 100 }%')
        ],
      ),
    );

    // String dataType = (isPumping == true) ? FireStoreConnect().pumpingCollection : (isbreastfeeding == true) ?  FireStoreConnect().bottlingcollection : FireStoreConnect().breastCollection;
    //
    // return StreamBuilder<QuerySnapshot>(
    //   stream: FirebaseFirestore.instance.collection("BreastFeedingData").doc(
    //       motherDataNotifier.value.email).collection(
    //       dataType).snapshots(),
    //
    //   // stream: FirebaseFirestore.instance.collection("BreastFeedingData").snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //
    //    // FireStoreConnect().getbreastData(snapshot as QuerySnapshot<Map<String, dynamic>>);
    //     if (snapshot.hasError) {
    //       return Text('Something went wrong');
    //     }
    //
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Text("Loading");
    //     }
    //
    //     if (!snapshot.hasData) {
    //       return CircularProgressIndicator();
    //     }
    //
    //     // print('${snapshot.data!.docs.length} DOCUMENTS Returned');
    //     print('All Docs : ${snapshot.data!.docs.length}');
    //     List<QueryDocumentSnapshot<Object?>> allDocs = snapshot.data!.docs;
    //     print('Number of items for dataType :  ${allDocs.length}');
    //
    //     return Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 10.0),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(title),
    //           Text(target),
    //           Text('$score'),
    //           Container(
    //             width: 100,
    //             child: LinearProgressIndicator(
    //               value: progress / 100,
    //               backgroundColor: Colors.grey[300],
    //               valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[300]!),
    //             ),
    //           ),
    //           Text('$progress%')
    //         ],
    //       ),
    //     );
    //   },
    // );
    //
    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 10.0),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Text(title),
    //       Text(target),
    //       Text('$score'),
    //       Container(
    //         width: 100,
    //         child: LinearProgressIndicator(
    //           value: progress / 100,
    //           backgroundColor: Colors.grey[300],
    //           valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[300]!),
    //         ),
    //       ),
    //       Text('$progress%')
    //     ],
    //   ),
    // );
  }
}
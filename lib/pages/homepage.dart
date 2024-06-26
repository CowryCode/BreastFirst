import 'package:breastfirst/api/FireStore.dart';
import 'package:breastfirst/api/model/AWSuserProfile.dart';
import 'package:breastfirst/api/model/motherdata.dart';
import 'package:breastfirst/api/network.dart';
import 'package:breastfirst/notification/notification.dart';
import 'package:breastfirst/pages/achievement.dart';
import 'package:breastfirst/pages/addbaby_page1.dart';
import 'package:breastfirst/pages/addbaby_page3.dart';
import 'package:breastfirst/pages/contactus.dart';
import 'package:breastfirst/pages/invitation.dart';
import 'package:breastfirst/pages/journal.dart';
import 'package:breastfirst/pages/journalInput.dart';
import 'package:breastfirst/pages/login-screen.dart';
import 'package:breastfirst/pages/pumping.dart';
import 'package:breastfirst/pages/remindaerpage.dart';
import 'package:breastfirst/pages/setting.dart';
import 'package:breastfirst/pages/trackbaby.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {

  const MyHomePage({
    super.key,
  });

  //final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  bool _isCelsius = true;
  bool _isCentimeter = true;
  bool _isKilogram = true;
  bool _isMilliliter = true;

  int _selectedDateIndex = 2;

  static List<Widget> _widgetoptions = <Widget>[
    MyHomePage(),
    ReminderPage(),
    SettingsScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //AWSuserProfile profile = await ApiAccess().getAwsUserPrfoile();
      Motherdata profile = motherDataNotifier.value;
      if(profile == null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()),);
      }else{
        await Firebase.initializeApp();
        await FirebaseMessaging.instance.getToken().then((token) {
          ApiAccess().uploadDeviceIdentifier(deviceID: token!);
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
   // String? USERid = motherDataNotifier.value.email;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.person, color: Colors.grey),
        //title: Text("<Baby's name>", style: TextStyle(color: Colors.black)),
        title:
        ValueListenableBuilder(
          valueListenable: motherDataNotifier,
          builder: (context, Motherdata motherdata, child){
            return (motherdata.name != null) ? Text('${motherdata.name}') : Text('');
            return Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('MotherCollection').where("email", isEqualTo: motherdata.email)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('');
                  }
                  if (!snapshot.hasData) {
                    return Text('');
                  } else {
                    if(snapshot.data!.size > 0){
                      Map<String, dynamic> data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                      return Text(data["name"], style: TextStyle(color: Colors.black));
                    }else{
                      return Text("");
                    }

                  }

                },
              ),
            );
          },

        ),
        //


        // Container(
        //   child: StreamBuilder<QuerySnapshot>(
        //     stream: FirebaseFirestore.instance.collection('MotherCollection').where("email", isEqualTo: USERid)
        //         .snapshots(),
        //     builder: (BuildContext context,
        //         AsyncSnapshot<QuerySnapshot> snapshot) {
        //       if (snapshot.hasError) {
        //         return Text('');
        //       }
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Text('');
        //       }
        //       if (!snapshot.hasData) {
        //         return Text('');
        //       } else {
        //         if(snapshot.data!.size > 0){
        //           Map<String, dynamic> data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
        //           return Text(data["name"], style: TextStyle(color: Colors.black));
        //         }else{
        //           return Text("");
        //         }
        //
        //       }
        //
        //     },
        //   ),
        // ),
        actions: [
          Icon(Icons.equalizer, color: Colors.purple),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: (_selectedIndex == 0) ? _home() : (_selectedIndex == 1) ? _reminder() : _setting()
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Reminder'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _home(){
    return Column(
      children: [
        _activityButton(Icons.score, 'Achievements', Colors.green,
            actionChoice: 0),
        _activityButton(Icons.feed, 'Feeding', Colors.orange,
            actionChoice: 1),
        _activityButton(Icons.child_care, 'My Journal', Colors.blue,
            actionChoice: 2),
        //_activityButton(Icons.bedtime, 'Sleep', Colors.red, actionChoice: 3),
        _activityButton(
            Icons.baby_changing_station, 'Pumping', Colors.pink,
            actionChoice: 4),
        // _activityButton(Icons.add, 'Other activity', Colors.yellow, actionChoice: 5),

        SizedBox(
          height: 30,
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image.asset(
                'images/baby.webp',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
          ),
        ),

      ],
    );
  }

  Widget _setting(){
    return Column(
      children: [
        Container(
          height: 500,
          child: ListView(
            children: [
              ListTile(title: Text('Growth standards')),
              _buildListTile('Sleep', pageID: 0),
              _buildListTile('Height', pageID: 1),
              _buildListTile('Weight', pageID: 2),
              ListTile(title: Text('Measurement units')),
              SwitchListTile(
                title: Text('Temperature'),
                value: _isCelsius,
                onChanged: (value) {
                  setState(() {
                    _isCelsius = value;
                  });
                },
                secondary: _isCelsius ? Text('°C') : Text('°F'),
              ),
              SwitchListTile(
                title: Text('Height'),
                value: _isCentimeter,
                onChanged: (value) {
                  setState(() {
                    _isCentimeter = value;
                  });
                  String ht = _isCentimeter ? 'cm' : 'inch';
                  //print('Height is : $ht');
                  //measurementUnitNotifier.upDateHeight(heightunit: ht);
                  FireStoreConnect().updateHeightUnit(heightUnit: ht);
                },
                secondary: _isCentimeter ? Text('cm') : Text('inch'),
              ),
              SwitchListTile(
                title: Text('Weight'),
                value: _isKilogram,
                onChanged: (value) {
                  setState(() {
                    _isKilogram = value;
                  });
                  String wt = _isKilogram ? 'kg' : 'lb';
                  //measurementUnitNotifier.upDateWeight(weightunit: wt);
                  FireStoreConnect().updateWeightUnit(weightUnit: wt);
                },
                secondary: _isKilogram ? Text('kg') : Text('lb'),
              ),
              SwitchListTile(
                title: Text('Volume'),
                value: _isMilliliter,
                onChanged: (value) {
                  setState(() {
                    _isMilliliter = value;
                  });
                },
                secondary: _isMilliliter ? Text('mL') : Text('fl oz'),
              ),
              _buildListTile('Journal', pageID: 3),
              _buildListTile('Background color', pageID: 4),
              _buildListTile('Share with family/friend', pageID: 5),
              // _buildListTile('Help & support', pageID: 6),
              _buildListTile('Send feedback', pageID: 7),
              ListTile(title: Text('App version 1.0')),
              ElevatedButton(
                  onPressed: (){
                    ApiAccess().logout();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()),);
                  },
                  child: Text('Sign Out')
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _reminder(){
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDateIndex = index;
                });
              },
              child: CircleAvatar(
                backgroundColor: (_selectedDateIndex == index)
                    ? Colors.purple
                    : Colors.grey[200],
                child: Text(
                  '${17 + index}',
                  style: TextStyle(color: (_selectedDateIndex == index)
                      ? Colors.white
                      : Colors.black,
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 10),
        Container(
          height: 400,
          child: ListView(
            children: [
              _timeEntry('7 AM', 'Breastfeed baby\'s name', '7:00 - 8:00'),
              _timeEntry('8 AM', '', ''),
              _timeEntry('9 AM', '', ''),
              _timeEntry('10 AM', 'Diaper change', '10:30'),
              _timeEntry('11 AM', '', ''),
              _timeEntry('12 PM', 'Temperature check', '12:30'),
              _timeEntry('1 PM', 'Time to sleep', '1:00 - 3:00'),
              _timeEntry('2 PM', 'Pump breast milk', '2:00 - 2:30'),
              _timeEntry('3 PM', '', ''),
              // ... add more entries as needed
            ],
          ),
        ),
        // SizedBox(height: 10),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     Text('Weekly'),
        //     Text('Monthly'),
        //     Text('Yearly'),
        //   ],
        // ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _activityButton(IconData icon, String label, Color color,
      {required int actionChoice}) {
    return InkWell(
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: color, child: Icon(icon, color: Colors.white)),
        title: Text(label),
      ),
      onTap: () {
        switch (actionChoice) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AchievementsScreen()),
            );
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => FeedingsTracker()),);
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => JournalScreen()));
          case 3:
            print('Sleep clicked');
          case 4:
            print('Pumping clicked');
            Navigator.push(context, MaterialPageRoute(builder: (context) => PumpingScreen(pumping: true)),);
          case 5:
            print('Other Activities clicked');
        }
      },
    );
  }

  ListTile _buildListTile(String title, {required int pageID}) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        if(pageID == 1){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddBabyPage()),);
        }else if(pageID == 2){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddBabyPage3()),);
        }else if(pageID == 3){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Journal()),);
        }else if(pageID == 4){

        }else if(pageID == 5){
          Navigator.push(context, MaterialPageRoute(builder: (context) => InvitationScreen()),);
        }else if(pageID == 6){
          //Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()),);
        }else if(pageID == 7){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()),);
        }
        // Handle list tile tap
      },
    );
  }

  Widget _timeEntry(String time, String title, String duration) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(time)),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.purple[100],  // adjust this to your desired shade
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  if (duration.isNotEmpty) Text(duration),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

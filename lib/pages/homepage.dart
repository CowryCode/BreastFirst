import 'package:breastfirst/pages/achievement.dart';
import 'package:breastfirst/pages/addbaby_page1.dart';
import 'package:breastfirst/pages/addbaby_page2.dart';
import 'package:breastfirst/pages/addbaby_page3.dart';
import 'package:breastfirst/pages/appreciation.dart';
import 'package:breastfirst/pages/babyroom.dart';
import 'package:breastfirst/pages/breastfeedingstat.dart';
import 'package:breastfirst/pages/congratpage.dart';
import 'package:breastfirst/pages/invitation.dart';
import 'package:breastfirst/pages/login-screen.dart';
import 'package:breastfirst/pages/musicplayers/lullabypage.dart';
import 'package:breastfirst/pages/pumping.dart';
import 'package:breastfirst/pages/pumpingreport.dart';
import 'package:breastfirst/pages/remindaerpage.dart';
import 'package:breastfirst/pages/selectoptions.dart';
import 'package:breastfirst/pages/setting.dart';
import 'package:breastfirst/pages/signup.dart';
import 'package:breastfirst/pages/store.dart';
import 'package:breastfirst/pages/survey.dart';
import 'package:breastfirst/pages/trackbaby.dart';
import 'package:breastfirst/pages/welcomepage.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  //const MyHomePage({super.key, required this.title});
  const MyHomePage({super.key,});


  //final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetoptions = <Widget>[
    MyHomePage(),
    ReminderPage(),
    SettingsScreen()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.person, color: Colors.grey),
        title: Text("Baby's name", style: TextStyle(color: Colors.black)),
        actions: [
          Icon(Icons.equalizer, color: Colors.purple),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _activityButton(Icons.score, 'Achievements', Colors.green, actionChoice: 0),
              _activityButton(Icons.feed, 'Feeding', Colors.orange, actionChoice: 1),
              _activityButton(Icons.child_care, 'Diaper change', Colors.blue, actionChoice: 2),
              //_activityButton(Icons.bedtime, 'Sleep', Colors.red, actionChoice: 3),
              _activityButton(Icons.baby_changing_station, 'Pumping', Colors.pink, actionChoice: 4),
             // _activityButton(Icons.add, 'Other activity', Colors.yellow, actionChoice: 5),

              SizedBox(height: 30,),
              Image.asset(  //
                'images/baby.webp',
                height: 250, // adjust this to your preference
              ),
              Wrap(
                children: [
                  ElevatedButton(
                    child: Text('Login'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('Reminder'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ReminderPage()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('Add_Baby1'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddBabyPage()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('Add_Baby2'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddBabyDetailsPage()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('Add_Baby3'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddBabyPage3()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('welcome'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('tracker'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FeedingsTracker()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('lullaby'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LullabiesScreen()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('congrat'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CongratulationsScreen()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('selection'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectionScreen()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('appreciate'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AppreciationScreen()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('pumping'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PumpingScreen()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('pumpingreport'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PumpingReportsScreen()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('store'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StoreScreen()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('achievement'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AchievementsScreen()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('babyroom'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BabysRoomScreen()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('stat'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BreastfeedingStatsScreen()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('moodcheck'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MoodCheckScreen()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('setting'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('invitation'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InvitationScreen()),);
                    },
                  ),
                  ElevatedButton(
                    child: Text('signup'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()),);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Reminder'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
  Widget _activityButton(IconData icon, String label, Color color, {required int actionChoice}) {
    return InkWell(
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)),
        title: Text(label),
      ),
      onTap: (){
        switch(actionChoice){
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) => AchievementsScreen()),);
          case 1:
            print('Feeding clicked');
            Navigator.push(context, MaterialPageRoute(builder: (context) => FeedingsTracker()),);
          case 2:
            print('Diaper Change clicked');
          case 3:
            print('Sleep clicked');
          case 4:
            print('Pumping clicked');
            Navigator.push(context, MaterialPageRoute(builder: (context) => PumpingScreen(pumping: true,)),);
          case 5:
            print('Other Activities clicked');
        }
      },
    );
  }
}

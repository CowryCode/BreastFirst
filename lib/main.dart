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
import 'package:breastfirst/pages/lullabypage.dart';
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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(/**/
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
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
              _activityButton(Icons.feed, 'Feeding', Colors.orange),
              _activityButton(Icons.child_care, 'Diaper change', Colors.blue),
              _activityButton(Icons.bedtime, 'Sleep', Colors.red),
              _activityButton(Icons.baby_changing_station, 'Pumping', Colors.green),
              _activityButton(Icons.add, 'Other activity', Colors.yellow),
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
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         const Text(
    //           'You have pushed the button this many times:',
    //         ),
    //         Text(
    //           '$_counter',
    //           style: Theme.of(context).textTheme.headlineMedium,
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: _incrementCounter,
    //     tooltip: 'Increment',
    //     child: const Icon(Icons.add),
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // );
  }
  Widget _activityButton(IconData icon, String label, Color color) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)),
      title: Text(label),
    );
  }
}



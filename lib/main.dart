import 'package:breastfirst/pages/addbaby_page1.dart';
import 'package:breastfirst/pages/login-screen.dart';
import 'package:breastfirst/pages/remindaerpage.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _activityButton(Icons.feed, 'Feeding', Colors.orange),
            _activityButton(Icons.child_care, 'Diaper change', Colors.blue),
            _activityButton(Icons.bedtime, 'Sleep', Colors.red),
            _activityButton(Icons.baby_changing_station, 'Pumping', Colors.green),
            _activityButton(Icons.add, 'Other activity', Colors.yellow),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()),);
              },
            ),
            ElevatedButton(
              child: Text('ReminderPage'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ReminderPage()),);
              },
            ),
            ElevatedButton(
              child: Text('Add_Baby_Page1'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddBabyPage()),);
              },
            ),
          ],
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



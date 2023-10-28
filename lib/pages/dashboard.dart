import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BabyScreen(),
    );
  }
}

class BabyScreen extends StatelessWidget {
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
  }

  Widget _activityButton(IconData icon, String label, Color color) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)),
      title: Text(label),
    );
  }
}

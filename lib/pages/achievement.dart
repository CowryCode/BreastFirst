import 'package:flutter/material.dart';

class AchievementsScreen extends StatefulWidget {
  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            achievementItem('Breastfeeding', '< 8 times per day', 5, 80),
            achievementItem('Pumping', '< 5 times per day', 4, 90),
            achievementItem('Diaper', '8 times per day', 2, 16),
            achievementItem('Sleep', '< 15 hours per day', 15, 100),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.room), label: 'Room'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget achievementItem(String title, String target, int score, double progress) {
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
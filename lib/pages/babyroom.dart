import 'package:breastfirst/pages/store.dart';
import 'package:flutter/material.dart';

class BabysRoomScreen extends StatefulWidget {
  @override
  _BabysRoomScreenState createState() => _BabysRoomScreenState();
}

class _BabysRoomScreenState extends State<BabysRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: Text("Baby's room"),
        actions: [
          achievementItem('Pts ', '', 5, 80),
          // IconButton(
          //   icon: Icon(Icons.local_mall),
          //   onPressed: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => StoreScreen()),);
          //     // Handle the menu button press
          //   },
          // ),
        ],
        leading: Icon(Icons.star, color: Colors.yellow),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Image.asset(  //
              'images/baby.webp',
              height: 200,  // adjust this to your preference
            ),// Replace with the path to your window image
            SizedBox(height: 20),
            Image.asset(  //
              'images/baby.webp',
              height: 200,  // adjust this to your preference
            ), // Replace with the path to your closet image
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
          BottomNavigationBarItem(icon: Icon(Icons.wind_power), label: 'Achievements'),
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
              backgroundColor: Colors.purple[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300]!),
            ),
          ),
          Text('$progress')
        ],
      ),
    );
  }
}
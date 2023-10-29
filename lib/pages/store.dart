import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: Text('Store'),
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
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            storeItem('Bassinet', Icons.child_care),
            storeItem('Glider', Icons.chair),
            storeItem('Dresser', Icons.desk),
            storeItem('Storage bins', Icons.storage),
            storeItem('Toys', Icons.toys),
            storeItem('Nightlight', Icons.lightbulb),
            storeItem('Blanket', Icons.bed),
            storeItem('Curtains', Icons.vertical_align_bottom),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.room), label: 'Room'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Achievements'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget storeItem(String title, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 50.0, color: Colors.purple[300]),
        SizedBox(height: 10),
        Text(title),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class BreastfeedingStatsScreen extends StatefulWidget {
  @override
  _BreastfeedingStatsScreenState createState() => _BreastfeedingStatsScreenState();
}

class _BreastfeedingStatsScreenState extends State<BreastfeedingStatsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: Text("Breastfeeding stats"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ToggleButtons(
              children: [Text("Daily"), Text("Weekly")],
              isSelected: [false, true],
              onPressed: (int index) {
                // Handle toggle button press
              },
            ),
            SizedBox(height: 20),
            // A placeholder for the chart; consider using a package like "fl_chart" for real charts
            Container(
              height: 200,
              color: Colors.purple[100],
              child:  Center(child: Text("Chart Placeholder")),
            ),
            SizedBox(height: 20),
            Text("Average 19.1oz"),
            Text("High 25.2oz"),
            Text("Low 13.5oz"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Achievements'),
          BottomNavigationBarItem(icon: Icon(Icons.share), label: 'Share'),
        ],
      ),
    );
  }
}
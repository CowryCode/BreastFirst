import 'package:flutter/material.dart';

class PumpingReportsScreen extends StatefulWidget {
  @override
  _PumpingReportsScreenState createState() => _PumpingReportsScreenState();
}

class _PumpingReportsScreenState extends State<PumpingReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
        title: Text('Pumping reports'),
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
        child: ListView(
          children: [
            // Daily section
            Text('Daily', style: TextStyle(fontWeight: FontWeight.bold)),
            buildReportTable(title: 'Per Pump'),
            SizedBox(height: 10),
            buildReportTable(title: 'Per Day'),
            SizedBox(height: 10),
            buildStatistics(),

            // Weekly section
            SizedBox(height: 20),
            Text('Weekly', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            buildWeeklyGraph(),
            SizedBox(height: 10),
            buildStatistics(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Achievements'),
          BottomNavigationBarItem(icon: Icon(Icons.share), label: 'Share'),
        ],
      ),
    );
  }

  Widget buildReportTable({required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Table(
          children: [
            TableRow(
              children: [
                TableCell(child: Container()),
                TableCell(child: Text('Amount (oz)', textAlign: TextAlign.center)),
                TableCell(child: Text('Duration (mins)', textAlign: TextAlign.center)),
                TableCell(child: Container()),
              ],
            ),
            TableRow(
              children: [
                TableCell(child: Container()),
                TableCell(child: Text('0', textAlign: TextAlign.center)),
                TableCell(child: Text('0:00', textAlign: TextAlign.center)),
                TableCell(child: Container()),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStatistics() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Average'),
            Text('0.0oz'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('High'),
            Text('0.0oz'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Low'),
            Text('0.0oz'),
          ],
        ),
      ],
    );
  }

  Widget buildWeeklyGraph() {
    // This is a placeholder, you can replace this with a graph library
    return Container(
      height: 120,
      color: Colors.purple[100],
      child: Center(child: Text('Graph Here')),
    );
  }
}
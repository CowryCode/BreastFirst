import 'package:breastfirst/pages/lullabypage.dart';
import 'package:breastfirst/pages/pumping.dart';
import 'package:breastfirst/pages/pumpingreport.dart';
import 'package:flutter/material.dart';

class FeedingsTracker extends StatefulWidget {
  @override
  _FeedingsTrackerState createState() => _FeedingsTrackerState();
}

class _FeedingsTrackerState extends State<FeedingsTracker> {
  int minutes = 0;
  int seconds = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.purple[100],
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("Track baby's feedings"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.purple[100]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: () {}, child: Text('Breastfeeding')),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PumpingScreen()),);
                  }, child: Text('Bottle')),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PumpingScreen()),);
                  }, child: Text('Pumping')),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Monday 20th March 2023\n16:41'),
                ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PumpingReportsScreen()),);
                }, child: Text('History')),
                ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LullabiesScreen()),);
                }, child: Text('Lullaby'))
              ],
            ),
            SizedBox(height: 30),
            Text(
              '$minutes:$seconds',
              style: TextStyle(fontSize: 50),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle left button press
                      },
                      icon: Icon(Icons.play_arrow, size: 40),
                    ),
                    Text('Left')
                  ],
                ),
                SizedBox(width: 50),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle right button press
                      },
                      icon: Icon(Icons.pause, size: 40),
                    ),
                    Text('Right')
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle done action
              },
              child: Text('Done'),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.home, size: 30),
                Icon(Icons.music_note, size: 30),
                Icon(Icons.settings, size: 30),
              ],
            )
          ],
        ),
      ),
    );
  }
}
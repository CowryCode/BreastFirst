import 'package:flutter/material.dart';

class PumpingScreen extends StatefulWidget {
  @override
  _PumpingScreenState createState() => _PumpingScreenState();
}

class _PumpingScreenState extends State<PumpingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text('Pumping'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle the menu button press
            },
          ),
          TextButton(onPressed: () {}, child: Text('Done'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          '00:00',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle countdown button press
                          },
                          child: Text('Set Countdown'),
                          style: ElevatedButton.styleFrom(primary: Colors.white, onPrimary: Colors.purple),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle start button press
                          },
                          child: Text('Start'),
                          style: ElevatedButton.styleFrom(primary: Colors.white, onPrimary: Colors.purple),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text('Last pumping\n45 mins ago', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Table(
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Start time', textAlign: TextAlign.center),
                    ),
                    TableCell(
                      child: Text('Amount', textAlign: TextAlign.center),
                    ),
                    TableCell(
                      child: Text('Duration', textAlign: TextAlign.center),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('4:45pm', textAlign: TextAlign.center),
                    ),
                    TableCell(
                      child: Text('4.05oz', textAlign: TextAlign.center),
                    ),
                    TableCell(
                      child: Text('1min', textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.insert_chart), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.videocam), label: 'Room'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        backgroundColor: Colors.purple[200],
      ),
    );
  }
}
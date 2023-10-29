import 'package:flutter/material.dart';

class AppreciationScreen extends StatefulWidget {
  @override
  _AppreciationScreenState createState() => _AppreciationScreenState();
}

class _AppreciationScreenState extends State<AppreciationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle the menu button press
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8.0,
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: Colors.purple,
                  size: 70,
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Your time and energy\nspent on breastfeeding\nis appreciated. \n Create more appreciation messages and Images',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                // Handle continue button press
              },
              child: Text('Continue'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
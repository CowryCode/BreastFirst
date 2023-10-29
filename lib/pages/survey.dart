import 'package:flutter/material.dart';

class MoodCheckScreen extends StatefulWidget {
  @override
  _MoodCheckScreenState createState() => _MoodCheckScreenState();
}

class _MoodCheckScreenState extends State<MoodCheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text(""),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle next button press
            },
            child: Text("Next"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "User, how you doin' right now?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            buildMoodButton("🎉 Absolutely awesome"),
            buildMoodButton("😊 Pretty good"),
            buildMoodButton("🙂 Totally fine"),
            buildMoodButton("🙁 Somewhat bad"),
            buildMoodButton("😢 Really terrible"),
          ],
        ),
      ),
    );
  }

  Widget buildMoodButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        // color: Colors.purple[100],
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(12.0),
        // ),
        onPressed: () {
          // Handle mood button press
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
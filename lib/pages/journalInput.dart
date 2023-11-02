import 'package:flutter/material.dart';

class Journal extends StatefulWidget {
  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  TextEditingController _emailController = TextEditingController();
  bool _shareSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("Journal"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle done button press
            },
            child: Text("Done"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Let us know how you are feeling today.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "... what's on your mind?",
                filled: true,
                fillColor: Colors.purple[50],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _shareSuccess = true;
                });
              },
              child: Text("Send"),
            ),
            if (_shareSuccess) ...[
              SizedBox(height: 16),
              Text(
                "Share success. User ${_emailController.text} will see My baby after logged in EasyFeed",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle tell him/her to download
                },
                child: Text("Tell him/her to download"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
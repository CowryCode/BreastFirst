import 'package:flutter/material.dart';

class SelectionScreen extends StatefulWidget {
  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  List<String> options = [
    'Sickness',
    'Bad appetite',
    'Relationship',
    'Health',
    'Family',
    'Sleep',
    'Food',
    'Social media',
    'Hydration',
    'Music',
    'Hobbies',
    'Nutrition',
    'Breast milk',
    'Exercise'
  ];
  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
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
            child: Text('Next', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What is making your day 'somewhat bad'?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Select up to 2 options'),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return ChoiceChip(
                    label: Text(options[index]),
                    selected: selectedOptions.contains(options[index]),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          if (selectedOptions.length < 2) {
                            selectedOptions.add(options[index]);
                          }
                        } else {
                          selectedOptions.remove(options[index]);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
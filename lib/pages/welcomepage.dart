import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? selectedMonth;
  int? selectedDay;
  int? selectedYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("Welcome!"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose your due date to personalize your experience.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            DropdownButton<String>(
              hint: Text("Month"),
              value: selectedMonth,
              items: ['December', 'January', 'February']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedMonth = newValue!;
                });
              },
            ),
            SizedBox(height: 15),
            // Similarly, add Dropdowns for Day and Year
            ElevatedButton(
              onPressed: () {
                // Handle the 'Get Started' button press
              },
              child: Text('Get Started'),
            ),
            TextButton(
              onPressed: () {
                // Handle "I don't know my due date" action
              },
              child: Text('I don\'t know my due date'),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                // Handle login action
              },
              child: Text('Have an account? Login'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle 'I'm a Mother' button press
              },
              child: Text('I\'m a Mother'),
            ),
          ],
        ),
      ),
    );
  }
}
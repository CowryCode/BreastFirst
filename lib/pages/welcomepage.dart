import 'package:breastfirst/api/FireStore.dart';
import 'package:breastfirst/pages/homepage.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? selectedMonth;
  int? selectedDay;
  String? selectedYear;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              DropdownButton<String>(
                hint: Text("Year"),
                value: selectedYear,
                items: ['2024', '2025']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedYear = newValue!;
                  });
                },
              ),
              SizedBox(width: 3,),
              DropdownButton<String>(
                hint: Text("Month"),
                value: selectedMonth,
                items: ['February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November','December', 'January']
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
            ],),
            SizedBox(height: 15),
            // Similarly, add Dropdowns for Day and Year
            ElevatedButton(
              onPressed: () {
                // Handle the 'Get Started' button press
                if(_submitAction(knowsDueDate: true)){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
                }else{
                  _showSnackBar(context);
                }
              },
              child: Text('Get Started'),
            ),
            TextButton(
              onPressed: () {
                // Handle "I don't know my due date" action
                _submitAction(knowsDueDate: false);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
              },
              child: Text('I don\'t know my due date'),
            ),
            // Spacer(),
            // TextButton(
            //   onPressed: () {
            //     // Handle login action
            //   },
            //   child: Text('Have an account? Login'),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     // Handle 'I'm a Mother' button press
            //   },
            //   child: Text('I\'m a Mother'),
            // ),
          ],
        ),
      ),
    );
  }

  bool _submitAction({required bool knowsDueDate}){
    if(knowsDueDate == false){
      FireStoreConnect().saveDueDate(dueDate: "unknown");
      return true;
    }

    if(selectedYear == null || selectedMonth ==null){
      return false;
    }else{
      FireStoreConnect().saveDueDate(dueDate: '$selectedYear-$selectedMonth');
      return true;
    }
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Select due year and month'),
      action: SnackBarAction(
        label: 'Warning',
        onPressed: () {
          // Perform some action when the "Close" button is pressed.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
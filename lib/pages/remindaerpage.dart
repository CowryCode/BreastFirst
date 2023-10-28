import 'package:flutter/material.dart';

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  int _selectedDateIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // handle back button press
          },
        ),
        title: Text('Reminders'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // handle menu button press
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // handle add button press
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDateIndex = index;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: (_selectedDateIndex == index)
                        ? Colors.purple
                        : Colors.grey[200],
                    child: Text(
                      '${17 + index}',
                      style: TextStyle(color: (_selectedDateIndex == index)
                          ? Colors.white
                          : Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  timeEntry('7 AM', 'Breastfeed baby\'s name', '7:00 - 8:00'),
                  timeEntry('8 AM', '', ''),
                  timeEntry('9 AM', '', ''),
                  timeEntry('10 AM', 'Diaper change', '10:30'),
                  timeEntry('11 AM', '', ''),
                  timeEntry('12 PM', 'Temperature check', '12:30'),
                  timeEntry('1 PM', 'Time to sleep', '1:00 - 3:00'),
                  timeEntry('2 PM', 'Pump breast milk', '2:00 - 2:30'),
                  timeEntry('3 PM', '', ''),
                  // ... add more entries as needed
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Weekly'),
                Text('Monthly'),
                Text('Yearly'),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget timeEntry(String time, String title, String duration) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(time)),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.purple[100],  // adjust this to your desired shade
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  if (duration.isNotEmpty) Text(duration),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
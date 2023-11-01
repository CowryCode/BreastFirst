import 'package:breastfirst/main.dart';
import 'package:flutter/material.dart';

class AddBabyPage3 extends StatefulWidget {
  @override
  _AddBabyPage3State createState() => _AddBabyPage3State();
}

class _AddBabyPage3State extends State<AddBabyPage3> {
  TextEditingController _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("Let's add your baby!"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Baby\'s weight', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                hintText: '--',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Image.asset(  //
              'images/baby.webp',
              height: 300,  // adjust this to your preference
            ), // replace with your image path
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
                // handle button press
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
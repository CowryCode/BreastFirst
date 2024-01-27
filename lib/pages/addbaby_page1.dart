import 'package:breastfirst/api/model/babydata.dart';
import 'package:breastfirst/pages/addbaby_page3.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:flutter/material.dart';

class AddBabyPage extends StatefulWidget {
  @override
  _AddBabyPageState createState() => _AddBabyPageState();
}

class _AddBabyPageState extends State<AddBabyPage> {
  TextEditingController _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        actions: [Icon(Icons.more_vert)],  // placeholder for the dots in the top right
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Let's add your baby!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  Text("Baby's height"),
                  SizedBox(height: 8),
                  TextField(
                    controller: _heightController,
                    decoration: InputDecoration(
                      hintText: '--',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              Image.asset(  //
                  'images/baby.webp',
                  height: 200,  // adjust this to your preference
                ),
              ElevatedButton(
                onPressed: () {
                  if(_heightController.text.isEmpty){
                    _showSnackBar(context);
                  }else{
                    BabyData babyData = babyDataNotifier.value;
                    babyData.setBabyHeight(babyHeight: _heightController.text.toString().trim());
                    babyDataNotifier.updateBabyDataNotifier(babydata: babyData);
                    print('BAY HEIGHT IS : ${babyData.babyHeight}');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddBabyPage3()),);
                  }
                  // Handle continue button press
                },
                child: Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Input baby height'),
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
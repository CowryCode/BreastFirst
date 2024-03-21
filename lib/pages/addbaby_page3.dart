import 'package:breastfirst/api/FireStore.dart';
import 'package:breastfirst/api/model/MeasurementUnit.dart';
import 'package:breastfirst/api/model/babydata.dart';
import 'package:breastfirst/api/network.dart';
import 'package:breastfirst/main.dart';
import 'package:breastfirst/pages/homepage.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:flutter/material.dart';

class AddBabyPage3 extends StatefulWidget {
  final bool isSignUp;

  const AddBabyPage3({Key? key, this.isSignUp = false}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder(
                valueListenable: measurementUnitNotifier,
                builder: (context, MeasurementUnit measurementUnit, child) {
                  return Text("Baby\'s weight (${measurementUnit.weightUnit})",
                      style: TextStyle(fontSize: 18));
                },
              ),
              // Text('Baby\'s weight', style: TextStyle(fontSize: 18)),
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
              Image.asset(
                //
                'images/baby.webp',
                height: 300, // adjust this to your preference
              ), // replace with your image path
              SizedBox(height: 30),
              ValueListenableBuilder(
                valueListenable: measurementUnitNotifier,
                builder: (context, MeasurementUnit measurementUnit, child) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_weightController.text.isEmpty) {
                        _showSnackBar(context);
                      } else {
                        if (widget.isSignUp == false) {
                          ApiAccess().saveWeight(
                              weight:
                                  "${_weightController.text.toString().trim()}${measurementUnit.weightUnit}");
                          Navigator.pop(context);
                        } else {
                          BabyData babyData = babyDataNotifier.value;
                          babyData.setBabyWeight(
                              babyWeight:
                                  _weightController.text.toString().trim());
                          babyDataNotifier.updateBabyDataNotifier(
                              babydata: babyData);
                          print('BAY Weight IS : ${babyData.babyWeight}');
                          FireStoreConnect().saveBabyData(babydata: babyData);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          );
                        }
                      }
                      // handle button press
                    },
                    child: (widget.isSignUp == false)? Text('Submit') :  Text('Continue'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Input baby weight'),
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

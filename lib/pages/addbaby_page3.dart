import 'package:breastfirst/api/FireStore.dart';
import 'package:breastfirst/api/model/MeasurementUnit.dart';
import 'package:breastfirst/api/model/babydata.dart';
import 'package:breastfirst/api/model/motherdata.dart';
import 'package:breastfirst/api/network.dart';
import 'package:breastfirst/main.dart';
import 'package:breastfirst/pages/homepage.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
              // ValueListenableBuilder(
              //   valueListenable: measurementUnitNotifier,
              //   builder: (context, MeasurementUnit measurementUnit, child) {
              //     String? mstUnit = widget.isSignUp == true ? "(kg)" :  measurementUnit.heighUnit == null? "(kg)" : "(${measurementUnit.weightUnit})";
              //     return Text("Baby\'s weight $mstUnit",
              //     //return Text("Baby\'s weight (${measurementUnit.weightUnit})",
              //         style: TextStyle(fontSize: 18));
              //   },
              // ),
              ValueListenableBuilder(
                valueListenable: motherDataNotifier,
                builder: (context, Motherdata motherdata, child){
                  return Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('MotherCollection').where("email", isEqualTo: motherdata.email)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text('');
                        }
                        if (!snapshot.hasData) {
                          return Text('');
                        } else {
                          if(snapshot.data!.size > 0){
                            Map<String, dynamic> data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                            return Text("Baby\'s weight (${data["weightUnit"]})" , style: TextStyle(color: Colors.black, fontSize: 18));
                            //return Text(data["heightUnit"], style: TextStyle(color: Colors.black));
                          }else{
                            return Text("");
                          }

                        }

                      },
                    ),
                  );
                },
              ),
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
                valueListenable: motherDataNotifier,
                builder: (context, Motherdata motherdata, child){
                  return Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('MotherCollection').where("email", isEqualTo: motherdata.email)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text('');
                        }
                        if (!snapshot.hasData) {
                          return Text('');
                        } else {
                          if(snapshot.data!.size > 0){
                            Map<String, dynamic> data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                          //  return Text("Baby\'s weight (${data["weightUnit"]})" , style: TextStyle(color: Colors.black, fontSize: 18));
                            return ElevatedButton(
                              onPressed: () {
                                if (_weightController.text.isEmpty) {
                                  _showSnackBar(context);
                                } else {
                                  if (widget.isSignUp == false) {
                                    ApiAccess().saveWeight(
                                        weight:
                                        "${_weightController.text.toString().trim()}${data["weightUnit"]}");
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
                          }else{
                            return Text("");
                          }

                        }

                      },
                    ),
                  );
                },
              ),
              // ValueListenableBuilder(
              //   valueListenable: measurementUnitNotifier,
              //   builder: (context, MeasurementUnit measurementUnit, child) {
              //     return ElevatedButton(
              //       onPressed: () {
              //         if (_weightController.text.isEmpty) {
              //           _showSnackBar(context);
              //         } else {
              //           if (widget.isSignUp == false) {
              //             ApiAccess().saveWeight(
              //                 weight:
              //                     "${_weightController.text.toString().trim()}${measurementUnit.weightUnit}");
              //             Navigator.pop(context);
              //           } else {
              //             BabyData babyData = babyDataNotifier.value;
              //             babyData.setBabyWeight(
              //                 babyWeight:
              //                     _weightController.text.toString().trim());
              //             babyDataNotifier.updateBabyDataNotifier(
              //                 babydata: babyData);
              //             print('BAY Weight IS : ${babyData.babyWeight}');
              //             FireStoreConnect().saveBabyData(babydata: babyData);
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => MyHomePage()),
              //             );
              //           }
              //         }
              //         // handle button press
              //       },
              //       child: (widget.isSignUp == false)? Text('Submit') :  Text('Continue'),
              //     );
              //   },
              // ),
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

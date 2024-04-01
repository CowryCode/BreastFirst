import 'package:breastfirst/api/model/MeasurementUnit.dart';
import 'package:breastfirst/api/model/babydata.dart';
import 'package:breastfirst/api/model/motherdata.dart';
import 'package:breastfirst/api/network.dart';
import 'package:breastfirst/pages/addbaby_page3.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/MeasurementUnitNotifier.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddBabyPage extends StatefulWidget {
  final bool isSignUp;

  const AddBabyPage({Key? key, this.isSignUp = false}) : super(key: key);

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
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Icon(Icons.more_vert)
        ], // placeholder for the dots in the top right
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
                  // ValueListenableBuilder(
                  //   valueListenable: measurementUnitNotifier,
                  //   builder: (context, MeasurementUnit measurementUnit, child) {
                  //     String? mstUnit = widget.isSignUp == true
                  //         ? "(cm)"
                  //         : measurementUnit.heighUnit == null
                  //             ? "(cm)"
                  //             : "(${measurementUnit.heighUnit})";
                  //     return Text(
                  //       // "Baby's height (${measurementUnit.heighUnit})",
                  //       "Baby's height $mstUnit",
                  //     );
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
                                return Text("Baby's height (${data["heightUnit"]})" , style: TextStyle(color: Colors.black));
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
                  SizedBox(height: 8),
                  TextField(
                    controller: _heightController,
                    decoration: InputDecoration(
                      hintText: '--',
                      border: OutlineInputBorder(),
                    ),
                    // keyboardType: TextInputType., // Set keyboard type to number
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.digitsOnly // Allow only digits
                    // ],
                  ),
                ],
              ),

              Image.asset(
                //
                'images/baby.webp',
                height: 200, // adjust this to your preference
              ),
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
                                if (_heightController.text.isEmpty) {
                                  _showSnackBar(context);
                                } else {
                                  if (widget.isSignUp == false) {
                                    ApiAccess().saveHeight(
                                        height:
                                        "${_heightController.text.toString().trim()}${data["heightUnit"]}");
                                    Navigator.pop(context);
                                  } else {
                                    BabyData babyData = babyDataNotifier.value;
                                    babyData.setBabyHeight(
                                        babyHeight:
                                        _heightController.text.toString().trim());
                                    babyDataNotifier.updateBabyDataNotifier(
                                        babydata: babyData);
                                    print('BAY HEIGHT IS : ${babyData.babyHeight}');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddBabyPage3(
                                            isSignUp: widget.isSignUp,
                                          )),
                                    );
                                  }
                                }
                                // Handle continue button press
                              },
                              child: (widget.isSignUp == false)
                                  ? Text('Submit')
                                  : Text('Continue'),
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
              //         if (_heightController.text.isEmpty) {
              //           _showSnackBar(context);
              //         } else {
              //           if (widget.isSignUp == false) {
              //             ApiAccess().saveHeight(
              //                 height:
              //                     "${_heightController.text.toString().trim()}${measurementUnit.heighUnit}");
              //             Navigator.pop(context);
              //           } else {
              //             BabyData babyData = babyDataNotifier.value;
              //             babyData.setBabyHeight(
              //                 babyHeight:
              //                     _heightController.text.toString().trim());
              //             babyDataNotifier.updateBabyDataNotifier(
              //                 babydata: babyData);
              //             print('BAY HEIGHT IS : ${babyData.babyHeight}');
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => AddBabyPage3(
              //                         isSignUp: widget.isSignUp,
              //                       )),
              //             );
              //           }
              //         }
              //         // Handle continue button press
              //       },
              //       child: (widget.isSignUp == false)
              //           ? Text('Submit')
              //           : Text('Continue'),
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

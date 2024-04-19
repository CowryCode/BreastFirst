import 'package:breastfirst/api/model/motherdata.dart';
import 'package:breastfirst/pages/components/countdownwidget.dart';
import 'package:breastfirst/pages/pumpingreport.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:flutter/material.dart';

class PumpingScreen extends StatefulWidget {
  @override
  _PumpingScreenState createState() => _PumpingScreenState();
  final bool bottle;
  final bool pumping;
  const PumpingScreen({Key? key, this.bottle = false, this.pumping = false}) : super(key: key);
}

class _PumpingScreenState extends State<PumpingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        //title: Text('Pumping'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle the menu button press
            },
          ),
          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PumpingReportsScreen()),);
          }, child: Text('History'))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:

          ValueListenableBuilder(
            valueListenable: motherDataNotifier,
            builder: (context, Motherdata motherdata, child){
              return Column(
                children: [
                  Center(
                      child: CountDownWidget(breastFeeding: false, bottle: widget.bottle, pumping: widget.pumping,)
                  ),
                  (widget.pumping == true && motherdata.lastfeeding != null && motherdata.lastfeeding!.pumping != null)? Text('Last pumping duration ${motherdata.lastfeeding!.pumping!.breastfeedingduration}(sec)', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))
                      :
                  (widget.bottle  == true && motherdata.lastfeeding != null && motherdata.lastfeeding!.bottling != null)? Text('Last pumping duration ${motherdata.lastfeeding!.bottling!.breastfeedingduration}(sec)', textAlign: TextAlign.center, style: TextStyle(fontSize: 16))
                  :
                  Text(""),
                  // SizedBox(height: 10),
                  // Table(
                  //   children: [
                  //     TableRow(
                  //       children: [
                  //         TableCell(
                  //           child: Text('Start time \n ${motherdata.lastfeeding!.pumping!.breastfeedingduration}', textAlign: TextAlign.center),
                  //         ),
                  //         TableCell(
                  //           child: Text('Amount \n ${motherdata.lastfeeding!.pumping!.pumpedQuantityML}', textAlign: TextAlign.center),
                  //         ),
                  //         TableCell(
                  //           child: Text('Duration \n ', textAlign: TextAlign.center),
                  //         ),
                  //       ],
                  //     ),
                  //     // TableRow(
                  //     //   children: [
                  //     //     TableCell(
                  //     //       child: Text('4:45pm', textAlign: TextAlign.center),
                  //     //     ),
                  //     //     TableCell(
                  //     //       child: Text('4.05oz', textAlign: TextAlign.center),
                  //     //     ),
                  //     //     TableCell(
                  //     //       child: Text('1min', textAlign: TextAlign.center),
                  //     //     ),
                  //     //   ],
                  //     // ),
                  //   ],
                  // ),
                ],
              );

            },

          ),


        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.insert_chart), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.videocam), label: 'Room'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        backgroundColor: Colors.purple[200],
      ),
    );
  }
}
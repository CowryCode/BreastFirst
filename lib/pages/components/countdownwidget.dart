import 'dart:async';

import 'package:breastfirst/api/FireStore.dart';
import 'package:breastfirst/api/network.dart';
import 'package:breastfirst/pages/components/musicselector.dart';
import 'package:flutter/material.dart';

class CountDownWidget extends StatefulWidget {
  final bool breastFeeding;
  final bool bottle;
  final bool pumping;
  const CountDownWidget({Key? key, this.breastFeeding = true, this.bottle = false, this.pumping = false}) : super(key: key);

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  int count = 0;
  bool isCounting = false;
  bool leftBreastActive = false;
  bool rightBreastActive = false;
  Duration elapsedDuration = Duration();
  late Timer _timer;

  int minutes = 0;
  int seconds = 0;

  @override
  Widget build(BuildContext context) {
    return _countdowntimer();
  }

  Widget _countdowntimer(){
    var msg =  (widget.breastFeeding == true) ?
    'Click on the breast side your are using now!'
        :
    (widget.pumping == true)?
        'Start pumping' : 'Start Bottling';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Center(
          child: Text(
            msg,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20),

        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            //color: Colors.white,
            color: Colors.purple[200],
          ),
          child: Center(
            child: Text(
              '$minutes:$seconds',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ),
        ),
        // Text(
        //   '$minutes:$seconds',
        //   style: TextStyle(fontSize: 50),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(widget.breastFeeding == true)
            ElevatedButton(
              onPressed: () {
                selectedBreast(isLeft: true);
                // startCountdown();
              },
              child: Row(
                children: [
                  Text((leftBreastActive == false) ? 'Left' : 'Stop'),
                  Icon((leftBreastActive == false)? Icons.play_arrow : Icons.pause, size: 20)
                ],

              ),
            ),
            if(widget.breastFeeding == true)
            SizedBox(width: 50),

           if(widget.breastFeeding == false && widget.bottle == true)
             ElevatedButton(
              onPressed: () {
                if(isCounting == false){
                  startCountdown();
                }else{
                  print('BOTTLE DURATION : ${elapsedDuration.inSeconds}');
                  startCountdown();
                }
              },
              child: Row(
                children: [
                  Text((isCounting == false) ? 'Start Feeding' : 'Pause Feeding'),
                  Icon((isCounting == false)? Icons.play_arrow : Icons.pause, size: 20)
                ],

              ),
            ),
            if(widget.breastFeeding == false && widget.pumping == true)
              ElevatedButton(
                onPressed: () {
                  if(isCounting == false){
                    startCountdown();
                  }else{
                    print('PUMPING DURATION : ${elapsedDuration.inSeconds}');
                    startCountdown();
                  }
                },
                child: Row(
                  children: [
                    Text((isCounting == false) ? 'Start Pumping' : 'Pause Pumping'),
                    Icon((isCounting == false)? Icons.play_arrow : Icons.pause, size: 20)
                  ],

                ),
              ),
            if(widget.breastFeeding == true)
            ElevatedButton(
              onPressed: () {
                selectedBreast(isLeft: false);
                // startCountdown();
              },
              child: Row(
                children: [
                  Text((rightBreastActive == false)?  'Right' : 'Stop'),
                  Icon((rightBreastActive == false)? Icons.play_arrow : Icons.pause, size: 20)
                ],

              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        if(isCounting == true)
        ElevatedButton(
          onPressed: () {
            print('GOT here 1');
            if(widget.pumping == true ) {
              _showDigitInputDialog(context, breastFeedingDuration: elapsedDuration.inSeconds);
            }else if(widget.bottle == true){
              print('GOT here 2');
              saveBreastMilkData(duration: elapsedDuration.inSeconds, isPumping: false, isBottling: true);
            } else {
              // Handle done action
              if(leftBreastActive == true){
                // Save this data for left Breast
                print('LEFT BREAST DURATION : ${elapsedDuration.inSeconds}');
                saveBreastMilkData(duration: elapsedDuration.inSeconds, isLeft: true, isPumping: false);
              }else{
                // Save this data for right Breast
                print('Right BREAST DURATION : ${elapsedDuration.inSeconds}');
                saveBreastMilkData(duration: elapsedDuration.inSeconds, isLeft: false, isPumping: false);
              }
            }
            initializeCounter(lbActive: false, rbActive: false, doneButton: true);
            stopCountdown();
          },
          child: Text('Done'),
        ),
        Divider(height: 2,),
      ],
    );
  }

  void selectedBreast({required bool isLeft}) {
    print('Pressed Left Button: $isLeft');
    print('LEFT Breast Active: $leftBreastActive');
    print('RIGHT Breast Active: $rightBreastActive');

    if(isLeft == true){
      if(leftBreastActive == true){
        // THIS CONDITION IMPLIES USER CLICK ON STOP IN AN ACTIVE LEFT BREAST
        // RECORD THE TIME
        print('LEFT BREAST DURATION : ${elapsedDuration.inSeconds}');
        saveBreastMilkData(duration: elapsedDuration.inSeconds, isLeft: true, isPumping: false);
        // STOP THE COUNT
        stopCountdown();
        // RE-INITIALIZE THE COUNTER and Active breasts
        initializeCounter(lbActive: false, rbActive: false);
      }else if (rightBreastActive == true){
        // THIS CONDITION IMPLIES USER CLICK ON START IN AN INACTIVE LEFT BREAST
        print('RIGHT BREAST DURATION : ${elapsedDuration.inSeconds}');
        saveBreastMilkData(duration: elapsedDuration.inSeconds, isLeft: false, isPumping: false);
        stopCountdown();
        // RE-INITIALIZE THE COUNTER and Active breasts
        initializeCounter(lbActive: true, rbActive: false);
        startCountdown();
      }else{
        initializeCounter(lbActive: true, rbActive: false);
        startCountdown();
      }

    }else{

      if(rightBreastActive == true){
        // THIS CONDITION IMPLIES USER CLICK ON STOP IN AN ACTIVE LEFT BREAST
        // RECORD THE TIME
        print('RIGHT BREAST DURATION : ${elapsedDuration.inSeconds}');
        saveBreastMilkData(duration: elapsedDuration.inSeconds, isLeft: false, isPumping: false);
        // STOP THE COUNT
        stopCountdown();
        // RE-INITIALIZE THE COUNTER and Active breasts
        initializeCounter(lbActive: false, rbActive: false);
      }else if (leftBreastActive == true){
        // THIS CONDITION IMPLIES USER CLICK ON START IN AN INACTIVE LEFT BREAST
        print('LEFT BREAST DURATION : ${elapsedDuration.inSeconds}');
        saveBreastMilkData(duration: elapsedDuration.inSeconds, isLeft: true, isPumping: false);
        stopCountdown();
        // RE-INITIALIZE THE COUNTER and Active breasts
        initializeCounter(lbActive: false, rbActive: true);
        startCountdown();
      }else {
        initializeCounter(lbActive: false, rbActive: true);
        startCountdown();
      }
    }

  }

  void saveBreastMilkData({required int duration, bool? isLeft, int? quantity, required bool isPumping, bool isBottling = false}){
    //FireStoreConnect().saveBreastMilkData(duration: duration, isLeft: isLeft, quantity: quantity, isPumping: isPumping, isBottling : isBottling );
    ApiAccess().saveBreastFeedingData(duration: duration, isLeft: isLeft, quantity: quantity, isPumping: isPumping, isBottling : isBottling );
  }

  void initializeCounter({required bool lbActive, required bool rbActive, bool doneButton = false}){
    setState(() {
      count = 0;
      elapsedDuration = Duration(seconds: 0);
      rightBreastActive = rbActive;
      leftBreastActive = lbActive;
      isCounting = doneButton;
      minutes = 0;
      seconds = 0;
    });
  }

  void startCountdown() {
    if (!isCounting) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          count++;
          seconds++;
          elapsedDuration = Duration(seconds: count);
          if(seconds == 60){
            minutes++;
            seconds = 0;
          }
        });
      });
      setState(() {
        isCounting = true;
      });
    }else{
      stopCountdown();
    }
  }

  void stopCountdown() {
    if (isCounting) {
      setState(() {
        isCounting = false;
        elapsedDuration = Duration(seconds: count);
        _timer.cancel();
      });
    }
  }

  Future<void> _showDigitInputDialog(BuildContext context, {required int breastFeedingDuration}) async {
    String inputValue = '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter quantity (ml)'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // Only allow digits
              if (RegExp(r'^[0-9]+$').hasMatch(value)) {
                inputValue = value;
              }
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Use the inputValue as needed (e.g., save, process, etc.)
                print('Entered Digits: $inputValue');
                saveBreastMilkData(duration: breastFeedingDuration, quantity: int.parse(inputValue), isPumping: true);
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

}


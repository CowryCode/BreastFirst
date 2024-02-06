import 'dart:async';

import 'package:flutter/material.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return _countdowntimer();
  }

  Widget _countdowntimer(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Count: $count seconds',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                selectedBreast(isLeft: true);
                //startCountdown();
              },
              child: Text(
                  (leftBreastActive == false) ? 'Left' : 'Stop'
              ),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                selectedBreast(isLeft: false);
               // startCountdown();
              },
              child: Text(
                  (rightBreastActive == false)?  'Right' : 'Stop'
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        if (elapsedDuration.inSeconds > 0)
          Text(
            'Elapsed Duration: ${elapsedDuration.inSeconds} seconds',
            style: TextStyle(fontSize: 18),
          ),
      ],
    );
  }

  void selectedBreast({required bool isLeft}) {
    print('Pressed Left Button: $isLeft');
    print('LEFT Breast Active: $leftBreastActive');
    print('RIGHT Breast Active: $rightBreastActive');

    if(isLeft == true){
      if(leftBreastActive == true){
        print('****************************************');
        print('CONDITION 1');
        // THIS CONDITION IMPLIES USER CLICK ON STOP IN AN ACTIVE LEFT BREAST
        // RECORD THE TIME
        print('LEFT BREAST DURATION : ${elapsedDuration.inSeconds}');
        // STOP THE COUNT
        stopCountdown();
        // RE-INITIALIZE THE COUNTER and Active breasts
        setState(() {
          count = 0;
          elapsedDuration = Duration(seconds: 0);
          leftBreastActive = false;
          rightBreastActive = false;
          isCounting = false;
        });
      }else if (rightBreastActive == true){
        print('****************************************');
        print('CONDITION 2');
        // THIS CONDITION IMPLIES USER CLICK ON START IN AN INACTIVE LEFT BREAST
        print('RIGHT BREAST DURATION : ${elapsedDuration.inSeconds}');

        stopCountdown();
        // RE-INITIALIZE THE COUNTER and Active breasts
        setState(() {
          count = 0;
          elapsedDuration = Duration(seconds: 0);
          leftBreastActive = true;
          rightBreastActive = false;
          isCounting = false;
        });
        startCountdown();
      }else{
        setState(() {
          count = 0;
          elapsedDuration = Duration(seconds: 0);
          leftBreastActive = true;
          isCounting = false;
        });
        startCountdown();
      }

    }else{

      if(rightBreastActive == true){
        print('****************************************');
        print('CONDITION 3');
        // THIS CONDITION IMPLIES USER CLICK ON STOP IN AN ACTIVE LEFT BREAST
        // RECORD THE TIME
        print('RIGHT BREAST DURATION : ${elapsedDuration.inSeconds}');
        // STOP THE COUNT
        stopCountdown();
        // RE-INITIALIZE THE COUNTER and Active breasts
        setState(() {
          count = 0;
          elapsedDuration = Duration(seconds: 0);
          leftBreastActive = false;
          rightBreastActive = false;
          isCounting = false;
        });
      }else if (leftBreastActive == true){
        print('****************************************');
        print('CONDITION 4');
        // THIS CONDITION IMPLIES USER CLICK ON START IN AN INACTIVE LEFT BREAST
        print('LEFT BREAST DURATION : ${elapsedDuration.inSeconds}');

        stopCountdown();
        // RE-INITIALIZE THE COUNTER and Active breasts
        setState(() {
          count = 0;
          elapsedDuration = Duration(seconds: 0);
          leftBreastActive = false;
          rightBreastActive = true;
          isCounting = false;
        });
        startCountdown();
      }else {
        setState(() {
          count = 0;
          elapsedDuration = Duration(seconds: 0);
          rightBreastActive = true;
          isCounting = false;
        });
        startCountdown();
      }
    }

  }

  void startCountdown() {
    // if (!isCounting) {
    //   Timer.periodic(Duration(seconds: 1), (timer) {
    //     setState(() {
    //       count++;
    //       elapsedDuration = Duration(seconds: count);
    //     });
    //   });
    //   setState(() {
    //     isCounting = true;
    //   });
    // }
    if (!isCounting) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          count++;
          elapsedDuration = Duration(seconds: count);
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

  // void _startTimer() {
  //   Timer.periodic(Duration(seconds: 1), (timer) {
  //    // if (_countdown > 0 && _isCountingDown) {
  //     if (_countdown == 0 && _isCountingDown) {
  //       setState(() {
  //         _countdown++;
  //       });
  //     } else {
  //       timer.cancel();
  //       stopCountdown();
  //     }
  //   });
  // }

}


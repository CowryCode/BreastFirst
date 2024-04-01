import 'dart:ffi';

import 'package:breastfirst/api/model/leaderboard.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PerformanceTable extends StatefulWidget {
  const PerformanceTable({Key? key}) : super(key: key);

  @override
  _PerformanceTableState createState() => _PerformanceTableState();
}

class _PerformanceTableState extends State<PerformanceTable> {


  int dataType = 0;

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: <Widget>[
              ElevatedButton(
                child: Text("Brest Feeding"),
                onPressed: () {
                  setState(() {
                    dataType = 0;
                  });
                },
              ),
              ElevatedButton(
                child: Text("Bottling"),
                onPressed: () {
                  setState(() {
                    dataType = 1;
                  });
                },
              ),
              ElevatedButton(
                child: Text('Pumping'),
                onPressed: () {
                  setState(() {
                    dataType = 2;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          // A placeholder for the chart; consider using a package like "fl_chart" for real charts
          Container(
            height: 200,
            color: Colors.purple[100],
            //child: getData(dataType: dataType),
            //  child:
            //  (dataType == 0)? Center(child: Text("Brest Feeding")) :
            //  (dataType == 1)? Center(child: Text("Bottling")) : Center(child: Text("Pumping")),
            child:
            (dataType == 0 && leaderBoardNotifier.value.breastFeedingRanking == null) ? Text("") :
            (dataType == 1 && leaderBoardNotifier.value.bottlingRanking == null) ? Text("") :
            (leaderBoardNotifier.value.pumpingRanking == null) ? Text("") :
            (dataType == 0)? Center(child: getBreastFeeding(breastFeedingRanking: leaderBoardNotifier.value.breastFeedingRanking!)) :
            (dataType == 1)? Center(child: getBottling(bottlingRanking: leaderBoardNotifier.value.bottlingRanking!)) : 
            Center(child: getPumping(pumpingRanking: leaderBoardNotifier.value.pumpingRanking!)),
          ),
        ],
      ),
    );
  }

  Widget getBreastFeeding({required List<BreastFeedingRanking> breastFeedingRanking}){
    return Column(
      children: <Widget>[
        Flexible(
          child: ListView.builder(
             itemCount: breastFeedingRanking.length,
            //  itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return tableRow(rank: index + 1, targetValue: 100, scoredValue: breastFeedingRanking[index].bottlingAvgRank!);
                // return tableRow(day: index + 1, targetValue: progressTable.value[index].targetValue!, scoredValue: progressTable.value[index].scoredValue!);
              }),
        ),
      ],
    );
  }

  Widget getBottling({required List<BottlingRanking> bottlingRanking}){
    return Column(
      children: <Widget>[
        Flexible(
          child: ListView.builder(
              itemCount: bottlingRanking.length,
              //  itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return tableRow(rank: index + 1, targetValue: 100, scoredValue: bottlingRanking[index].bottlingAvgRank!);
                // return tableRow(day: index + 1, targetValue: progressTable.value[index].targetValue!, scoredValue: progressTable.value[index].scoredValue!);
              }),
        ),
      ],
    );
  }

  Widget getPumping({required List<PumpingRanking> pumpingRanking}){
    return Column(
      children: <Widget>[
        Flexible(
          child: ListView.builder(
              itemCount: pumpingRanking.length,
              //  itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return tableRow(rank: index + 1, targetValue: 100, scoredValue: pumpingRanking[index].pumpingAvgRank!);
                // return tableRow(day: index + 1, targetValue: progressTable.value[index].targetValue!, scoredValue: progressTable.value[index].scoredValue!);
              }),
        ),
      ],
    );
  }



  Widget tableRow({
    required int rank,
    required int targetValue,
    required int scoredValue,
  }) {

    return Card(
      elevation: 0.2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                offset: Offset(0, 4),
                blurRadius: 10)
          ],
        ),
        padding: const EdgeInsets.only(
            top: 12.0, bottom: 12.0, left: 12.0, right: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            Text(
              'Rank $rank',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontFamily: 'Poppins',
                fontSize: 12.0,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            // Text(
            //   '$targetValue',
            //   textAlign: TextAlign.left,
            //   style: const TextStyle(
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black45,
            //     fontFamily: 'Poppins',
            //     fontSize: 12.0,
            //   ),
            // ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.2,
            // ),
            Text(
              '$scoredValue',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontFamily: 'Poppins',
                fontSize: 12.0,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  _getStars(score: scoredValue, target: targetValue),
            ),
          ],
        ),
        //   ],
        // ),
      ),
    );
  }

  List<Widget> _getStars({required int score, required int target}){
    //int starcount = Utilities().getPercentage(value: score, total: target);
    if(score < 1){
      return [Icon(FontAwesomeIcons.solidStar, color: Colors.red, size: 12,),];
    } else{
      if(score > 0 && score <= 10){
        return[
          Icon(FontAwesomeIcons.solidStar, color: Colors.orange, size: 12,),
        ];
      }else if(score > 10 && score <= 20 ){
        return[
          Icon(FontAwesomeIcons.solidStar, color: Colors.orange, size: 12,),
          Icon(FontAwesomeIcons.solidStar, color: Colors.orange, size: 12,),
        ];
      }else if(score > 20 && score <= 25 ){
        return[
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
        ];
      }else if(score > 25 && score <= 45 ){
        return[
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
        ];
      }else if(score > 45 && score <= 70 ){
        return[
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
        ];
      } else if(score > 70){
        print('START COUNT VALUE IS : $score');
        return[
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
          Icon(FontAwesomeIcons.solidStar, color: Colors.green, size: 12,),
          Icon(FontAwesomeIcons.trophy, color: Colors.blueGrey, size: 12,),
        ];
      }else{
        return [Icon(FontAwesomeIcons.solidStar, color: Colors.red, size: 12,),];
      }
    }
  }

}

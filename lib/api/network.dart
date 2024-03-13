import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:breastfirst/api/model/leaderboard.dart';
import 'package:breastfirst/api/networkUtilities.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:http/http.dart' as http;

class ApiAccess {

  Future<LeaderBoard> getLeaderBoard() async {
    print('CALLED ::::: ');
    int userID = 1;
    String? token = motherDataNotifier.value.email;
    final response = await http.get(
      Uri.parse("$LEADERBOARD_URL/$userID"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Origin': '$MobileURL',
        'Authorization': 'Bearer $token'
      }
      // body: jsonEncode(
      //   <String, dynamic>{
      // "id" : messageID,
      // "isread" : true,
      // }),
    );

    print('CALLED ::::: $LEADERBOARD_URL/$userID');

    if (response.statusCode == 200) {
      LeaderBoard leaderBoard = LeaderBoard.fromJson(jsonDecode(response.body));
      print('ahvkjah vhajfvhkj');
      leaderBoardNotifier.updateLeaderBoard(leaderBoard: leaderBoard);
      print('Leader Board: ${leaderBoard.toJson()}');
      return leaderBoard;
    } else {
      throw Exception("Couldn't pull the leaderboard");
    }
  }

  Future<void> saveBreastFeedingData({required int duration, required bool? isLeft, int? quantity, required bool isPumping,  bool isBottling = false}) async {
    // String? token;
    // Future<String?> tk = Localstorage().getString(key_phone_number);
    // await tk.then((value) => {token = value!});

    String? token = motherDataNotifier.value.email;

    final response = await http.post(
      Uri.parse(SAVE_Breast_Milk_Data_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Origin': '$MobileURL',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{
            "breastfeedingduration" : duration,
            "breastSide" : (isLeft == true) ? "LeftSide" : "RightSide",
            "PumpedQuantity_ML" : quantity,
            "isbottling" : isBottling ,
            "ispumping" : isPumping,
            "isbreasting" : (isPumping == false && isBottling == false),
            "userID" : token,
          }),
    );

    // "breastfeedingduration" : 10,
    // "breastSide" : "LeftSide",
    // "PumpedQuantity_ML": 20,
    // "isbottling" : false,
    // "ispumping": false,
    // "isbreasting": true,
    // "userID": "admin2@gmail.com"

    if (response.statusCode == 200) {
      print('Saved successfully . . . ');
    } else {
      //
    }
  }

}


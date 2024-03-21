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
    if (response.statusCode == 200) {
      print('Saved successfully . . . ');
    } else {
      //
    }
  }

  Future<void> saveHeight({required String height}) async {
    String? token = motherDataNotifier.value.email;

    final response = await http.post(
      Uri.parse(SAVE_baby_height),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Origin': '$MobileURL',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{
            "height": height,
            "userID": token,
          }),
    );
    if (response.statusCode == 200) {
      print('${response.body}');
    } else {
      print('Submission failed . . . ');
    }
  }

  Future<void> saveWeight({required String weight}) async {
    String? token = motherDataNotifier.value.email;

    final response = await http.post(
      Uri.parse(SAVE_baby_weight),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Origin': '$MobileURL',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{
            "weight": weight,
            "userID": token,
          }),
    );
    if (response.statusCode == 200) {
      print('${response.body}');
    } else {
      print('Submission failed . . . ');
    }
  }

  Future<void> saveJournal({required String journal}) async {
    String? token = motherDataNotifier.value.email;
    final response = await http.post(
      Uri.parse(SAVE_journal),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Origin': '$MobileURL',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{
            "journal": journal,
            "userID": token,
          }),
    );
    if (response.statusCode == 200) {
      print('${response.body}');
    } else {
      print('Submission failed . . . ');
    }
  }

  Future<void> saveFeedBack({required String feedback}) async {
    String? token = motherDataNotifier.value.email;
    final response = await http.post(
      Uri.parse(SAVE_FeedBack),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Origin': '$MobileURL',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{
            "feedback": feedback,
            "userID": token,
          }),
    );
    if (response.statusCode == 200) {
      print('${response.body}');
    } else {
      print('Submission failed . . . ');
    }
  }

  Future<bool> uploadDeviceIdentifier({required String deviceID}) async {
    print('DEVICE ID : $deviceID');
    // String token = await Localstorage().getString(key_login_token)??"";
    //
    //
    // final response = await http.post(
    //   Uri.parse(Save_Device_Identtifier_URL),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //     'Accept': 'application/json',
    //     'Origin': '$MobileURL',
    //     'Authorization': 'Bearer $token'
    //   },
    //   body: jsonEncode(
    //       <String, String?>{"value": deviceID}),
    // );
    //
    // if (response.statusCode == 201) {
    //   return true;
    // }else{
    //   return false;
    // }
    return true;
  }

}


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

  // Future<LeaderBoard?> createprofile({required LeaderBoard profile}) async {
  //   String? token;
  //   Future<String?> tk = Localstorage().getString(key_phone_number);
  //   await tk.then((value) => {token = value!});
  //
  //   final response = await http.post(
  //     Uri.parse(CreateProfile_URL),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Accept': 'application/json',
  //       'Origin': '$MobileURL',
  //       'Authorization': 'Bearer $token'
  //     },
  //     body: jsonEncode(
  //         <String, dynamic>{
  //           "id" : profile.id,
  //           "name" : profile.name,
  //           "phonenumber" : profile.phonenumber,
  //           "isconsented" : profile.isconsented,
  //           "smilegrampoint" : profile.smilegrampoints,
  //           "deviceId" : profile.deviceId,
  //         }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     UserProfile profile = UserProfile.fromJson(jsonDecode(response.body));
  //     return profile;
  //   } else {
  //     return null;
  //   }
  // }

}


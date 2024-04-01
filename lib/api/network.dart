import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:breastfirst/api/FireStore.dart';
import 'package:breastfirst/api/model/AWSuserProfile.dart';
import 'package:breastfirst/api/model/diskstorage.dart';
import 'package:breastfirst/api/model/leaderboard.dart';
import 'package:breastfirst/api/model/motherdata.dart';
import 'package:breastfirst/api/networkUtilities.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:http/http.dart' as http;

class ApiAccess {

  Future<void> creatUserProfile({required String email, required String name}) async {
    // String? token;
    // Future<String?> tk = Localstorage().getString(key_phone_number);
    // await tk.then((value) => {token = value!});
    final response = await http.post(
      Uri.parse(CREATE_UserProfile),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Origin': '$MobileURL'
      },
      body: jsonEncode(
          <String, dynamic>{
            "userID" : email,
            "babyName": name
          }),
    );
    if (response.statusCode == 200) {
      print('Saved successfully . . . ');
    } else {
      //
    }
  }

  Future<LeaderBoard> getLeaderBoard({String? user}) async {
    String? userID = user ?? motherDataNotifier.value.email;
    String? token = motherDataNotifier.value.email;
    final response = await http.get(
      Uri.parse("$LEADERBOARD_URL/$userID"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Origin': '$MobileURL',
        'Authorization': 'Bearer $token'
      }
    );

    if (response.statusCode == 200) {
      LeaderBoard leaderBoard = LeaderBoard.fromJson(jsonDecode(response.body));
      leaderBoardNotifier.updateLeaderBoard(leaderBoard: leaderBoard);

      return leaderBoard;
    } else {
      throw Exception("Couldn't pull the leaderboard");
    }
  }

  Future<AWSuserProfile> getAwsUserPrfoile({String? userID}) async {
    String? localData = await Localstorage().getUserIDLocal();
    String? token = userID != null ? userID : localData;
    final response = await http.post(
        Uri.parse("$Get_AwsUserProfile"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Origin': '$MobileURL',
          'Authorization': 'Bearer $token'
        },
      body: jsonEncode(
          <String, dynamic>{
            "userID" : token,
          }),
    );

    if (response.statusCode == 200) {
      print('${response.body}');
      AWSuserProfile profile = AWSuserProfile.fromJson(jsonDecode(response.body));
      Motherdata mData = Motherdata();
      mData.init(email: profile.userID!, isPregnant: true, name: profile.babyName!);
      motherDataNotifier.updateMotherDataNotifier(motherdata: mData);
      getLeaderBoard();
      return profile;
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
    //SAVE TO FIRESTORE
    FireStoreConnect().saveJournal(userID: token!, journal: journal);

    // SAVE TO AWS
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

  Future<void> uploadDeviceIdentifier({required String deviceID}) async {
    String? token = motherDataNotifier.value.email;
    final response = await http.post(
      Uri.parse(SAVE_DEVICEID),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Origin': '$MobileURL',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{
            "userID": token,
            "deviceID": deviceID,
          }),
    );
    if (response.statusCode == 200) {
      print('${response.body}');
    } else {
      print('Submission failed . . . ');
    }
  }

  Future<void> logout() async {
    Localstorage().removeLoginDetails();
    ApiAccess().cleanup();
  }

  Future<void> cleanup() async{
    // motherDataNotifier.nullify();
    // babyDataNotifier.nullify();
    // leaderBoardNotifier.nullify();
    // measurementUnitNotifier.nullify();
  }
}


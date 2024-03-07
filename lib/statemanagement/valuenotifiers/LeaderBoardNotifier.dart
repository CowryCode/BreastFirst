
import 'package:breastfirst/api/model/leaderboard.dart';
import 'package:flutter/material.dart';

class LeaderBoardNotifier extends ValueNotifier<LeaderBoard> {
  LeaderBoardNotifier({required LeaderBoard value}) : super(value);

  void updateLeaderBoard({required LeaderBoard leaderBoard}) {
    value = leaderBoard;
    notifyListeners();
  }
}
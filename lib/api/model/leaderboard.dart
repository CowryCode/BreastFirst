class LeaderBoard {
  UserStatus? userStatus;
  List<BreastFeedingRanking>? breastFeedingRanking;
  List<BottlingRanking>? bottlingRanking;
  List<PumpingRanking>? pumpingRanking;

  LeaderBoard(
      {this.userStatus,
        this.breastFeedingRanking,
        this.bottlingRanking,
        this.pumpingRanking});

  LeaderBoard.fromJson(Map<String, dynamic> json) {
    userStatus = json['userStatus'] != null
        ? new UserStatus.fromJson(json['userStatus'])
        : null;
    if (json['breastFeedingRanking'] != null) {
      breastFeedingRanking = <BreastFeedingRanking>[];
      json['breastFeedingRanking'].forEach((v) {
        breastFeedingRanking!.add(new BreastFeedingRanking.fromJson(v));
      });
    }
    if (json['bottlingRanking'] != null) {
      bottlingRanking = <BottlingRanking>[];
      json['bottlingRanking'].forEach((v) {
        bottlingRanking!.add(new BottlingRanking.fromJson(v));
      });
    }
    if (json['pumpingRanking'] != null) {
      pumpingRanking = <PumpingRanking>[];
      json['pumpingRanking'].forEach((v) {
        pumpingRanking!.add(new PumpingRanking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userStatus != null) {
      data['userStatus'] = this.userStatus!.toJson();
    }
    if (this.breastFeedingRanking != null) {
      data['breastFeedingRanking'] =
          this.breastFeedingRanking!.map((v) => v.toJson()).toList();
    }
    if (this.bottlingRanking != null) {
      data['bottlingRanking'] =
          this.bottlingRanking!.map((v) => v.toJson()).toList();
    }
    if (this.pumpingRanking != null) {
      data['pumpingRanking'] =
          this.pumpingRanking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserStatus {
  int? todayBreastFeedingCount;
  int? todayPumpingCount;
  int? todayBottlingCount;
  List<FeedingData>? historicData;

  UserStatus(
      {this.todayBreastFeedingCount,
        this.todayPumpingCount,
        this.todayBottlingCount,
        this.historicData});

  UserStatus.fromJson(Map<String, dynamic> json) {
    todayBreastFeedingCount = json['todayBreastFeedingCount'];
    todayPumpingCount = json['todayPumpingCount'];
    todayBottlingCount = json['todayBottlingCount'];
    if (json['historicData'] != null) {
      historicData = <FeedingData>[];
      json['historicData'].forEach((v) {
        historicData!.add(new FeedingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['todayBreastFeedingCount'] = this.todayBreastFeedingCount;
    data['todayPumpingCount'] = this.todayPumpingCount;
    data['todayBottlingCount'] = this.todayBottlingCount;
    if (this.historicData != null) {
      data['historicData'] = this.historicData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeedingData {
  String? userID;
  String? date;
  int? breastFeedingCount;
  int? pumpingCount;
  int? bottlingCount;

  FeedingData(
      {
        this.userID,
        this.date,
        this.breastFeedingCount,
        this.pumpingCount,
        this.bottlingCount});

  FeedingData.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    date = json['date'];
    breastFeedingCount = json['breastFeedingCount'];
    pumpingCount = json['pumpingCount'];
    bottlingCount = json['bottlingCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = userID;
    data['date'] = date;
    data['breastFeedingCount'] = breastFeedingCount;
    data['pumpingCount'] = pumpingCount;
    data['bottlingCount'] = bottlingCount;
    return data;
  }
}

class BreastFeedingRanking {
  String? userID;
  int? breastAvgFeedingRank;
  int? bottlingAvgRank;
  int? pumpingAvgRank;

  BreastFeedingRanking(
      {this.userID,
        this.breastAvgFeedingRank,
        this.bottlingAvgRank,
        this.pumpingAvgRank});

  BreastFeedingRanking.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    breastAvgFeedingRank = json['breastAvgFeedingRank'];
    bottlingAvgRank = json['bottlingAvgRank'];
    pumpingAvgRank = json['pumpingAvgRank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['breastAvgFeedingRank'] = this.breastAvgFeedingRank;
    data['bottlingAvgRank'] = this.bottlingAvgRank;
    data['pumpingAvgRank'] = this.pumpingAvgRank;
    return data;
  }
}

class BottlingRanking {
  String? userID;
  int? breastAvgFeedingRank;
  int? bottlingAvgRank;
  int? pumpingAvgRank;

  BottlingRanking(
      {this.userID,
        this.breastAvgFeedingRank,
        this.bottlingAvgRank,
        this.pumpingAvgRank});

  BottlingRanking.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    breastAvgFeedingRank = json['breastAvgFeedingRank'];
    bottlingAvgRank = json['bottlingAvgRank'];
    pumpingAvgRank = json['pumpingAvgRank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['breastAvgFeedingRank'] = this.breastAvgFeedingRank;
    data['bottlingAvgRank'] = this.bottlingAvgRank;
    data['pumpingAvgRank'] = this.pumpingAvgRank;
    return data;
  }
}

class PumpingRanking {
  String? userID;
  int? breastAvgFeedingRank;
  int? bottlingAvgRank;
  int? pumpingAvgRank;

  PumpingRanking(
      {this.userID,
        this.breastAvgFeedingRank,
        this.bottlingAvgRank,
        this.pumpingAvgRank});

  PumpingRanking.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    breastAvgFeedingRank = json['breastAvgFeedingRank'];
    bottlingAvgRank = json['bottlingAvgRank'];
    pumpingAvgRank = json['pumpingAvgRank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['breastAvgFeedingRank'] = this.breastAvgFeedingRank;
    data['bottlingAvgRank'] = this.bottlingAvgRank;
    data['pumpingAvgRank'] = this.pumpingAvgRank;
    return data;
  }
}
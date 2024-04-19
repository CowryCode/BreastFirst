
class AWSuserProfile {
  int? id;
  String? userID;
  String? babyName;
  String? deviceID;
  LastFeeding? lastFeeding;

  AWSuserProfile(
      {this.id, this.userID, this.babyName, this.deviceID, this.lastFeeding});

  AWSuserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    babyName = json['babyName'];
    deviceID = json['deviceID'];
    lastFeeding = json['lastFeeding'] != null
        ? new LastFeeding.fromJson(json['lastFeeding'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['babyName'] = this.babyName;
    data['deviceID'] = this.deviceID;
    if (this.lastFeeding != null) {
      data['lastFeeding'] = this.lastFeeding!.toJson();
    }
    return data;
  }
}

class LastFeeding {
  Breastfeeding? breastfeeding;
  Breastfeeding? pumping;
  Breastfeeding? bottling;

  LastFeeding({this.breastfeeding, this.pumping, this.bottling});

  LastFeeding.fromJson(Map<String, dynamic> json) {
    breastfeeding = json['breastfeeding'] != null
        ? new Breastfeeding.fromJson(json['breastfeeding'])
        : null;
    pumping = json['pumping'] != null
        ? new Breastfeeding.fromJson(json['pumping'])
        : null;
    bottling = json['bottling'] != null
        ? new Breastfeeding.fromJson(json['bottling'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breastfeeding != null) {
      data['breastfeeding'] = this.breastfeeding!.toJson();
    }
    if (this.pumping != null) {
      data['pumping'] = this.pumping!.toJson();
    }
    if (this.bottling != null) {
      data['bottling'] = this.bottling!.toJson();
    }
    return data;
  }
}

class Breastfeeding {
  int? id;
  int? breastfeedingduration;
  String? breastSide;
  bool? isbottling;
  bool? ispumping;
  bool? isbreasting;
  String? userID;
  String? userName;
  int? pumpedQuantityML;

  Breastfeeding(
      {this.id,
        this.breastfeedingduration,
        this.breastSide,
        this.isbottling,
        this.ispumping,
        this.isbreasting,
        this.userID,
        this.userName,
        this.pumpedQuantityML});

  Breastfeeding.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    breastfeedingduration = json['breastfeedingduration'];
    breastSide = json['breastSide'];
    isbottling = json['isbottling'];
    ispumping = json['ispumping'];
    isbreasting = json['isbreasting'];
    userID = json['userID'];
    userName = json['userName'];
    pumpedQuantityML = json['pumpedQuantity_ML'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['breastfeedingduration'] = this.breastfeedingduration;
    data['breastSide'] = this.breastSide;
    data['isbottling'] = this.isbottling;
    data['ispumping'] = this.ispumping;
    data['isbreasting'] = this.isbreasting;
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['pumpedQuantity_ML'] = this.pumpedQuantityML;
    return data;
  }


  // int? id;
  // String? userID;
  // String? babyName;
  // String? deviceID;
  // String? listofSharedUsers;
  // LastFeeding? lastfeeding;
  //
  // AWSuserProfile(
  //     {this.id,
  //       this.userID,
  //       this.babyName,
  //       this.deviceID,
  //       this.listofSharedUsers,
  //       this.lastfeeding
  //     });
  //
  // AWSuserProfile.fromJson(Map<String, dynamic> json) {
  //   print('LAST FEEDING :::::: ${json['lastfeeding']}');
  //   id = json['id'];
  //   userID = json['userID'];
  //   babyName = json['babyName'];
  //   deviceID = json['deviceID'];
  //   listofSharedUsers = json['listofSharedUsers'];
  //   lastfeeding = json['lastfeeding'] != null
  //       ? new LastFeeding.fromJson(json['lastfeeding'])
  //       : null;
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['userID'] = this.userID;
  //   data['babyName'] = this.babyName;
  //   data['deviceID'] = this.deviceID;
  //   data['listofSharedUsers'] = this.listofSharedUsers;
  //   if (this.lastfeeding != null) {
  //     data['lastfeeding'] = this.lastfeeding!.toJson();
  //   }
  //   return data;
  // }
}
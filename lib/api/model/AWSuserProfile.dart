class AWSuserProfile {
  int? id;
  String? userID;
  String? babyName;
  String? deviceID;
  String? listofSharedUsers;

  AWSuserProfile(
      {this.id,
        this.userID,
        this.babyName,
        this.deviceID,
        this.listofSharedUsers});

  AWSuserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    babyName = json['babyName'];
    deviceID = json['deviceID'];
    listofSharedUsers = json['listofSharedUsers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['babyName'] = this.babyName;
    data['deviceID'] = this.deviceID;
    data['listofSharedUsers'] = this.listofSharedUsers;
    return data;
  }
}
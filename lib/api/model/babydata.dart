class BabyData{
  String? gender;
  String? babyname;
  String? motherIdentifier;
  String? birthDate;
  String? birthTime;
  String? babyHeight;
  String? babyWeight;

  void setGender({required String gender}){
    this.gender = gender;
  }
  void setBabyname({required String babyname}){
    this.babyname = babyname;
  }
  void setMotherIdentifier({required String motherIdentifier}){
    this.motherIdentifier = motherIdentifier;
  }
  void setBirthDate({required String birthDate}){
    this.birthDate = birthDate;
  }
  void setBirthTime({required String birthTime}){
    this.birthTime = birthTime;
  }
  void setBabyHeight({required String babyHeight}){
    this.babyHeight = babyHeight;
  }
  void setBabyWeight({required String babyWeight}){
    this.babyWeight = babyWeight;
  }
}

import 'package:breastfirst/api/model/AWSuserProfile.dart';

class Motherdata{
  String? email;
  String? name;
  bool? isPregnant;
  String? dueDate;
  LastFeeding? lastfeeding;

  Motherdata();

  void init({required String email, required bool isPregnant, required String name}){
    this.email = email;
    this.isPregnant = isPregnant;
    this.name = name;
  }

  void setEmail({required String email}){
    this.email = email;
  }

  void setLastFeedingData({required LastFeeding lastfeed}){
    this.lastfeeding = lastfeed;
  }
}
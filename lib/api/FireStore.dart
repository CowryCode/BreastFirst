
import 'dart:async';
import 'dart:io';

import 'package:breastfirst/api/model/babydata.dart';
import 'package:breastfirst/api/model/breastfeedingrecord.dart';
import 'package:breastfirst/api/model/motherdata.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';


class FireStoreConnect{

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference motherCollection = FirebaseFirestore.instance.collection('MotherCollection');
  CollectionReference babyCollection = FirebaseFirestore.instance.collection('BabyCollection');
  CollectionReference breastFeedingCollection = FirebaseFirestore.instance.collection('BreastFeedingData');
  CollectionReference journalCollection = FirebaseFirestore.instance.collection('JournalCollection');
  CollectionReference shareCollection = FirebaseFirestore.instance.collection('ShareCollection');

  String JournalID = "Journal";
  String pumpingCollection = 'Pumping';
  String bottlingcollection = 'Bottling';
  String breastCollection = 'BreastFeeding';

 Future<void>? saveMotherData({required Motherdata motherdata}) async{
    Map<String, dynamic> data = {
      'email': motherdata.email,
      'name': motherdata.name,
      'isPregnant': motherdata.isPregnant,
      'timestamp': DateTime.now()
    };

    DocumentReference motherData = motherCollection.doc("${motherdata.email}");
    await motherData.set(data);
    motherDataNotifier.updateMotherDataNotifier(motherdata: motherdata);
  }

  Future<void>? saveDueDate({required String dueDate}) async{
    Map<String, dynamic> data = {
      'dueDate': dueDate,
    };
    try{
      DocumentReference motherData = motherCollection.doc(motherDataNotifier.value.email);
      await motherData.update(data);
      }catch(e){
        print('Update failed with error : ${e.toString()}');
      }
  }

  Future<void>? saveBabyData({required BabyData babydata}) async{
    Map<String, dynamic> data = {
      'gender': babydata.gender,
      'babyname': babydata.babyname,
      'motherIdentifier': motherDataNotifier.value.email,
      'birthDate': babydata.birthDate,
      'birthTime': babydata.birthTime,
      'babyHeight': babydata.babyHeight,
      'babyWeight': babydata.babyWeight,
      'timestamp': DateTime.now()
    };

    DocumentReference babyData = babyCollection.doc("${motherDataNotifier.value.email}");
    await babyData.set(data);
    babyDataNotifier.updateBabyDataNotifier(babydata: babydata);
  }

  Future<void>? saveBreastMilkData1({required int duration, required bool? isLeft, int? quantity, required bool isPumping,  bool isBottling = false}) async{
    Map<String, dynamic> data = {
      'breastfeedingduration': duration,
      'breastSide': isPumping == true || isBottling == true ? '' : (isLeft == true) ? "LeftSide" : "RightSide",
      'PumpedQuantity_ML': quantity,
      'timestamp': DateTime.now()
    };

    String bfeedingCollecton = isPumping == true ? "$pumpingCollection" :  isBottling == true ? "$bottlingcollection" : "$breastCollection";

   // DocumentReference breastFeedingData = breastFeedingCollection.doc("${motherDataNotifier.value.email}").collection("x").add(data);
    breastFeedingCollection.doc("${motherDataNotifier.value.email}").collection(bfeedingCollecton).add(data);
  }

  Future<void> getbreastData(QuerySnapshot<Map<String, dynamic>> snapshot) async{
    List<BreastFeedingRecord> breastFeeding = [];
    List<BreastFeedingRecord> bottling = [];
    List<BreastFeedingRecord> pumping = [];

    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = snapshot.docs;

    for (QueryDocumentSnapshot<Map<String, dynamic>> document in documents) {

      List<BreastFeedingRecord> breastData = await FirebaseFirestore.instance
          .collection('BreastFeedingData')
          .doc(document.id)
          .collection('$breastCollection')
          .get()
          .then((data) {
        return data.docs.map((nestedDoc) => BreastFeedingRecord.fromFirestore(nestedDoc)).toList();
      });
      breastFeeding.addAll(breastData);

      List<BreastFeedingRecord> pump = await FirebaseFirestore.instance
          .collection('BreastFeedingData')
          .doc(document.id)
          .collection('$pumpingCollection')
          .get()
          .then((data) {
        return data.docs.map((nestedDoc) => BreastFeedingRecord.fromFirestore(nestedDoc)).toList();
      });
      pumping.addAll(pump);

      List<BreastFeedingRecord> bottle = await FirebaseFirestore.instance
          .collection('BreastFeedingData')
          .doc(document.id)
          .collection('$bottlingcollection')
          .get()
          .then((data) {
        return data.docs.map((nestedDoc) => BreastFeedingRecord.fromFirestore(nestedDoc)).toList();
      });
      bottling.addAll(bottle);

    }

    print('THE BREAST FEEDING SIZE : ${breastFeeding.length}');
    print('THE PUMPING SIZE : ${pumping.length}');
    print('THE BOTTLING SIZE : ${bottling.length}');

  }

  Future<void>? saveJournal({required String userID, required String journal}) async{
    Map<String, dynamic> data = {
      "journal": journal,
      "userID": userID,
      'timestamp': DateTime.now()
    };

    journalCollection.doc(userID).collection(JournalID).add(data);
  }

  Future<void>? shareProgress({required String user, required String name}) async{
    String? token = motherDataNotifier.value.email;
    Map<String, dynamic> data = {
      'sharedBy': token,
      'sharedTo': user,
      'sharerName': motherDataNotifier.value.name,
      'sharerToName': name,
      'timestamp': DateTime.now()
    };

    shareCollection.add(data);
  }

  Future<void> deleteSharing({required String  sharedBy, required String sharedTo}) async {
    shareCollection.where("sharedBy", isEqualTo: sharedBy)
    .where("sharedTo", isEqualTo: sharedTo).get().then((querySnapshot) =>{
    querySnapshot.docs.forEach((doc) async {
    await doc.reference.delete();
    }),
    });
  }
}

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



  // Future<void>? startCalendarMeeting({required CalendarModel calendarModel,  String? calltoken}) async{
  //   print('DOCUMENT_ID : Patient${calendarModel.patientID}_Provide${calendarModel.providerID}_${calendarModel.date}${calendarModel.hour}');
  //   print('THE TOKEN: $calltoken');
  //   Map<String, dynamic> data = {
  //     //'onCall': true,
  //     'onCall': (calltoken == null) ? false : true,
  //     'token' : calltoken,
  //   };
  //   try{
  //     DocumentReference appointment = activeAppointmentCollection
  //         .doc("Patient${calendarModel.patientID}_Provide${calendarModel.providerID}_${calendarModel.date}${calendarModel.hour}");
  //     await appointment.update(data);
  //   }catch(e){
  //     print('Update failed with error : ${e.toString()}');
  //   }
  // }

  // Future<void>? saveMedicalReport_Provider({required MedicalReport medicalreport}) async{
  //   try{
  //     Map<String, dynamic> data = {
  //       'dateCreated': medicalreport.dateCreated,
  //       'reportContent': medicalreport.reportContent,
  //       'providerID': medicalreport.providerID,
  //       'patientID' : medicalreport.patientID,
  //     };
  //     medicalReportsCollection.doc("Patient${medicalreport.patientID}_report").collection("MedicalReports").add(data);
  //     print('Saved report successfully');
  //   }catch (e){
  //     print('Report saving failed');
  //   }
  //
  // }


  // Future<void> deleteAppointment({required CalendarModel appointment}) async {
  //   String docId = "DocumentID";
  //
  //  // int hourinUtC = appointment.getHourinUTC();
  //   int hourinUtC = appointment.hour!;
  //
  //   activeAppointmentCollection
  //       .doc("Patient${appointment.patientID}_Provide${appointment.providerID}_${appointment.date}$hourinUtC")
  //       .delete()
  //       .then((value) => print("Appointment Successfully Deleted"))
  //       .catchError((error) => print("Failed to delete document: $error"));
  //
  //   doctorAppointmentCollection
  //       .doc("Provider_${appointment.providerID}")
  //       .collection(appointment.date!).doc('$hourinUtC')
  //       .delete()
  //       .then((value) => print("ProviderRecord Successfully Deleted"))
  //       .catchError((error) => print("Failed to delete document: $error"));
  // }

  // Future<void> uploadProfilePicture({ required File image, String? imageID, required bool userIsprovider, required String userID }) async {
  //   try{
  //     String imageIdenifier = (imageID == null)? DateTime.now().toIso8601String() : imageID;
  //     String userType = (userIsprovider) ? "Provider":"Patient";
  //     Reference storageReference = FirebaseStorage.instance.ref().child('users-profile-images/$imageIdenifier.png');
  //     UploadTask uploadTask = storageReference.putFile(image);
  //     await uploadTask.whenComplete(() async {
  //       String imageUrl = await storageReference.getDownloadURL();
  //
  //       // Define the data you want to save in the document
  //       Map<String, dynamic> userData = {
  //         'url': '$imageUrl',
  //         'dateUploaded':  DateTime.now(),
  //         'imageIdentifier': imageIdenifier
  //       };
  //       await profilePictureCollection.doc('${userType}').collection("ProfileImages").doc('${userType}_${userID}').set(userData);
  //
  //     });
  //   }catch(error){
  //     // Some error occured
  //   }
  // }

  // Future<void> uploadLicence({required File image, required String docName, required String dateaWarded, required int providerID}) async {
  //   try {
  //     print('Document : $docName');
  //     print('Date Awarded : $dateaWarded');
  //     print('Provider ID : $providerID');
  //
  //     String imageIdenifier = DateTime.now().toIso8601String();
  //     Reference storageReference = FirebaseStorage.instance.ref().child('provider-licences-images/$imageIdenifier.png');
  //    // Reference storageReference = FirebaseStorage.instance.ref().child('provider-licences-images/${DateTime.now().toIso8601String()}.png');
  //     UploadTask uploadTask = storageReference.putFile(image);
  //     await uploadTask.whenComplete(() async {
  //       String imageUrl = await storageReference.getDownloadURL();
  //
  //       Map<String, dynamic> userData = {
  //         'imageUrl': '$imageUrl',
  //         'document_Name':  docName,
  //         'Date_Awarded':  dateaWarded,
  //         'imageIdentifier': imageIdenifier
  //       };
  //       await providerLicencesCollection.doc('Provider_$providerID').collection("licenses").doc('$imageIdenifier').set(userData);
  //
  //
  //     });
  //
  //   } catch (e) {
  //     print('Error saving document: $e');
  //   }
  // }

  // Future<void> deleteLicence({required int  providerID, required String imgIdentifier}) async {
  //   providerLicencesCollection
  //       .doc('Provider_$providerID').collection("licenses").doc("$imgIdentifier")
  //       .delete()
  //       .then((value) => {
  //          FirebaseStorage.instance.ref().child('provider-licences-images/$imgIdentifier.png').delete(),
  //          print('Deleted successfully')
  //        })
  //       .catchError((error) => print("Failed to delete document: $error"));
  // }
}
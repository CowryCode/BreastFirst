import 'package:cloud_firestore/cloud_firestore.dart';

class BreastFeedingRecord {
  String? breastfeedingDuration;
  String? breastSide;
  int? pumpedQuantityML;
  DateTime? timestamp;

  BreastFeedingRecord({
    this.breastfeedingDuration,
    this.breastSide,
    this.pumpedQuantityML,
    this.timestamp,
  });

  factory BreastFeedingRecord.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BreastFeedingRecord(
      breastfeedingDuration: data['breastfeedingduration'] ?? '',
      breastSide: data['breastSide'] ?? '',
      pumpedQuantityML: data['PumpedQuantity_ML'] ?? 0,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}

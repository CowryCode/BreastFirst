import 'package:breastfirst/api/model/babydata.dart';
import 'package:flutter/material.dart';

class BabyDataNotifier extends ValueNotifier<BabyData> {
  BabyDataNotifier({required BabyData value}) : super(value);

  void updateBabyDataNotifier({required BabyData babydata}) {
    value = babydata;
    notifyListeners();
  }
}
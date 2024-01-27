import 'package:breastfirst/api/model/motherdata.dart';
import 'package:flutter/material.dart';

class MotherDataNotifier extends ValueNotifier<Motherdata> {
  MotherDataNotifier({required Motherdata value}) : super(value);

  void updateMotherDataNotifier({required Motherdata motherdata}) {
    value = motherdata;
    notifyListeners();
  }
}
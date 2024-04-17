import 'package:breastfirst/api/model/MeasurementUnit.dart';
import 'package:flutter/material.dart';

class MeasurementUnitNotifier extends ValueNotifier<MeasurementUnit> {
  MeasurementUnitNotifier({required MeasurementUnit value}) : super(value);

  void upDateHeight({required String heightunit}) {
    value.setHeighUnit(heightUnit: heightunit);
    notifyListeners();
  }

  void upDateWeight({required String weightunit}) {
    value.setWeighUnit(weightUnit: weightunit);
    print('GOT HERE 2');
    notifyListeners();
  }

  void nullify(){
    value = MeasurementUnit();
  }
}
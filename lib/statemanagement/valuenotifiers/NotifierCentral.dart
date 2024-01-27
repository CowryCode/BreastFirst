import 'package:breastfirst/api/model/babydata.dart';
import 'package:breastfirst/api/model/motherdata.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/BabyDataNotifier.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/MotherDataNotifier.dart';

final MotherDataNotifier motherDataNotifier = MotherDataNotifier(value: Motherdata());
final BabyDataNotifier babyDataNotifier = BabyDataNotifier(value: BabyData());


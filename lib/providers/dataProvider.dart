import 'package:flutter/cupertino.dart';
import 'package:takara_bill/models/bill.dart';
import 'package:takara_bill/providers/dataBank.dart';

class DataProvider with ChangeNotifier{
  final DataBank dataBank = DataBank();
   Stream<List<Bill>> get bills => dataBank.getBill();

}
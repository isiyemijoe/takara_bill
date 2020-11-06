import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:takara_bill/AppEngine.dart';

class Bill {
  var billDate;
  String noOfDays; //will not be included in firestore database
  dynamic billAmount;
  String billCode;
  String description;
  dynamic outstanding;
  dynamic quantity;
  dynamic unitPrice;
  String vendorName;
  var lastPayDate;
  dynamic amountPaid;
  List<Installment> installments;
  var lastTransactionDate;

  Bill(
      this.billDate,
      this.noOfDays,
      this.billAmount,
      this.billCode,
      this.description,
      this.outstanding,
      this.quantity,
      this.unitPrice,
      this.vendorName);

  Bill.fromSnapshot(Map<String, dynamic> snapshot)
      : billDate = parseDate(snapshot["billDate"]),
        billAmount = snapshot["billAmount"],
        billCode = snapshot["billCode"],
        description = snapshot["description"],
        outstanding = snapshot["outstanding"],
        quantity = snapshot["quantity"],
        unitPrice = snapshot["unitPrice"],
        installments = snapshot["installments"],
        vendorName = snapshot["vendorName"],
        lastTransactionDate = parseDate(snapshot["lastTransactionDate"]),
        lastPayDate = parseDate(snapshot["lastPayDate"]);
}

class Installment {
  DateTime payDate;
  String amount;

  Installment(this.payDate, this.amount);

  Installment.fromSnapshot(Map<String, dynamic> snapshot)
      : payDate = snapshot["payDate"],
        amount = snapshot["amount"];
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:takara_bill/StringAssets.dart';
import 'package:takara_bill/models/bill.dart';
import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBank {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  // ignore: close_sinks
   final StreamController<List<Bill>> _controller = StreamController<List<Bill>>.broadcast();

  Stream<List<Bill>> getBill() {
   /* List<Bill> billList = List();
     _db
        .collection("Debtors")
        .doc("joseph.isiyemi@cavidel.com")
        .collection('bills')
        .snapshots();*/

   return  _db
        .collection("Debtors")
        .doc("joseph.isiyemi@cavidel.com")
        .collection('bills')
        .orderBy("lastTransactionDate", descending: true)
        .snapshots()
        // ignore: missing_return
        .map((event) =>
      event.docs
          .map((doc) => Bill.fromSnapshot(doc.data()))
          .toList()
     );

   /* Stream<List<Bill>> st =   _db
        .collection("Debtors")
        .doc("joseph.isiyemi@cavidel.com")
        .collection('bills')
        .orderBy("lastTransactionDate", descending: true)
        .snapshots()
    .map((event) {
      print("update");
      event.docs
          .map((doc) => Bill.fromSnapshot(doc.data()))
          .toList();
    } );

    Stream<QuerySnapshot> stream2 = _db
        .collection("Debtors")
        .doc("joseph.isiyemi@cavidel.com")
        .collection('paidBills')
        .snapshots();

    StreamZip bothStreams = StreamZip([st, stream2]);
    bothStreams.listen((snaps) {
      QuerySnapshot snapshot1 = snaps[0];
      QuerySnapshot snapshot2 = snaps[1];
      print(snapshot1.docs.length);
      print(snapshot2.docs.length);
      if (billList != null) {
        billList.clear();
      }
      billList =
          snapshot1.docs.map((e) => Bill.fromSnapshot(e.data())).toList();
      billList.addAll(
          snapshot2.docs.map((e) => Bill.fromSnapshot(e.data())).toList());
      _controller.sink.add(billList);
      print(billList.length);

    });

    return _controller.stream;*/
  }

  totalBill(List<Bill> bills) {
    double amount = 0;
    for (Bill bill in bills) {
      if (bill.outstanding != 0) {
        amount += bill.outstanding;
      }
    }
  }
}

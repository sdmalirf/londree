import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:londreeapp/model/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TableController extends StateNotifier<List<TransactionTable>> {
  TableController() : super([]);

  final db = FirebaseFirestore.instance.collection('transaction');

  Future<void> getTrans(
      // {
      // required String uid
      // }
      ) async {
    var checkTrans = await db
        // .where('uid', isEqualTo: uid)
        .get();

    List<TransactionTable> trans = checkTrans.docs
        .map((e) => TransactionTable.fromFireStore(e.data()))
        .toList();
    state = trans;
  }

  Future<void> addTrans(
      {required BuildContext context,
      required TransactionTable transactionTable,
      required String uid}) async {
    final doc = db.doc();
    await doc.set(TransactionTable().toFirestore());
    await getTrans(
        // uid: uid
        );
  }
}

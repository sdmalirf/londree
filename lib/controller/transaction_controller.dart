import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:londreeapp/model/transactions.dart';

class TransactionsController extends StateNotifier<List<Transactions>> {
  TransactionsController() : super([]);

  final db = FirebaseFirestore.instance.collection('transactions');

  Future<void> getTransaction({String? oid}) async {
    var checkTransactions = await db.where('oid', isEqualTo: oid).get();
    print(checkTransactions);

    List<Transactions> transactions = checkTransactions.docs
        .map((e) => Transactions.fromJson(e.data()))
        .toList();
    state = transactions;
  }

  Future<void> addTransaction(
      {required BuildContext context,
      required Transactions transactions,
      String? oid}) async {
    final doc = db.doc();
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                backgroundColor: HexColor('4392A4'),
              ),
            ));
    Transactions temp = transactions.copyWith(tid: doc.id);
    await doc.set(temp.toJson());

    final auth = FirebaseAuth.instance;
    final dbLog = FirebaseFirestore.instance.collection('logHistory');
    final doclog = dbLog.doc();
    await doclog.set({
      'logId': doclog.id,
      'aktivitas': 'Menambah Transaksi',
      'email': auth.currentUser!.email,
      'tgl': DateTime.now(),
    });

    await getTransaction(oid: oid);
  }

  Future<void> updateTransaction(
      {required BuildContext context,
      required Transactions transactions,
      required String tid,
      String? oid}) async {
    final doc = db.doc(tid);
    Transactions temp = transactions.copyWith(tid: doc.id);
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                backgroundColor: HexColor('#4392A4'),
              ),
            ));
    await doc.update(temp.toJson());
    final auth = FirebaseAuth.instance;
    final dbLog = FirebaseFirestore.instance.collection('logHistory');
    final doclog = dbLog.doc();
    await doclog.set({
      'logId': doclog.id,
      'aktivitas': 'Mengubah Transaksi',
      'email': auth.currentUser!.email,
      'tgl': DateTime.now(),
    });

    // final dbLog = FirebaseFirestore.instance.collection('log_history');
    // final docID = dbLog.doc();
    // await docID.set({
    //   'log_id': docID.id,
    //   'aktivitas': 'Mengubah data siswa',
    //   'email': auth.currentUser!.email,
    //   'tgl': DateTime.now(),
    // });
    await getTransaction(oid: oid);
  }

  Future<void> deleteTransaction({
    required BuildContext context,
    required String tid,
  }) async {
    final doc = db.doc(tid);

    await doc.delete();
    final auth = FirebaseAuth.instance;
    final dbLog = FirebaseFirestore.instance.collection('logHistory');
    final doclog = dbLog.doc();
    await doclog.set({
      'logId': doclog.id,
      'aktivitas': 'Menghapus Transaksi',
      'email': auth.currentUser!.email,
      'tgl': DateTime.now(),
    });
    // final dbLog = FirebaseFirestore.instance.collection('log_history');
    // final docID = dbLog.doc();
    // await docID.set({
    //   'log_id': docID.id,
    //   'aktivitas': 'Menghapus data siswa',
    //   'email': auth.currentUser!.email,
    //   'tgl': DateTime.now(),
    // });

    await getTransaction();
  }
}

final transactionControllerProvider =
    StateNotifierProvider<TransactionsController, List<Transactions>>(
  (ref) => TransactionsController(),
);

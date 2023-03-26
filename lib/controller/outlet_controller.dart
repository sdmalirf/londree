import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:londreeapp/model/outlets.dart';

class OutletController extends StateNotifier<List<Outlets>> {
  OutletController() : super([]);

  final db = FirebaseFirestore.instance.collection('outlets');

  Future<void> getOutlets() async {
    var checkOutlets = await db.get();

    List<Outlets> outlets =
        checkOutlets.docs.map((e) => Outlets.fromJson(e.data())).toList();
    state = outlets;
  }

  Future<void> addOutlets(
      {required BuildContext context, required Outlets outlet}) async {
    final doc = db.doc();
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                backgroundColor: HexColor('4392A4'),
              ),
            ));
    Navigator.pop(context);
    Outlets temp = outlet.copyWith(oid: doc.id);
    await doc.set(temp.toJson());

    final auth = FirebaseAuth.instance;
    // final dbLog = FirebaseFirestore.instance.collection('log_history');
    // final docID = dbLog.doc();
    // await docID.set({
    //   'log_id': docID.id,
    //   'aktivitas': 'Menambah siswa',
    //   'email': auth.currentUser!.email,
    //   'tgl': DateTime.now(),
    // });

    await getOutlets();
  }

  Future<void> updateOutlet(
      {required BuildContext context,
      required Outlets outlets,
      required String oid}) async {
    final doc = db.doc(oid);
    Outlets temp = outlets.copyWith(oid: doc.id);
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                backgroundColor: HexColor('#4392A4'),
              ),
            ));
    await doc.update(temp.toJson());
    final auth = FirebaseAuth.instance;
    // final dbLog = FirebaseFirestore.instance.collection('log_history');
    // final docID = dbLog.doc();
    // await docID.set({
    //   'log_id': docID.id,
    //   'aktivitas': 'Mengubah data siswa',
    //   'email': auth.currentUser!.email,
    //   'tgl': DateTime.now(),
    // });
    await getOutlets();
  }

  Future<void> deleteOutlet(
      {required BuildContext context, required String oid}) async {
    final doc = db.doc(oid);
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                backgroundColor: HexColor('4392A4'),
              ),
            ));
    await doc.delete();
    final auth = FirebaseAuth.instance;
    // final dbLog = FirebaseFirestore.instance.collection('log_history');
    // final docID = dbLog.doc();
    // await docID.set({
    //   'log_id': docID.id,
    //   'aktivitas': 'Menghapus data siswa',
    //   'email': auth.currentUser!.email,
    //   'tgl': DateTime.now(),
    // });
    await getOutlets();
  }
}

final OutletControllerProvider =
    StateNotifierProvider<OutletController, List<Outlets>>(
  (ref) => OutletController(),
);

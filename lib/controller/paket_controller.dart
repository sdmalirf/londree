import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:londreeapp/model/pakets.dart';

class PaketController extends StateNotifier<List<Pakets>> {
  PaketController() : super([]);

  final db = FirebaseFirestore.instance.collection('pakets');

  Future<void> getPakets() async {
    var checkPakets = await db.get();

    List<Pakets> paket =
        checkPakets.docs.map((e) => Pakets.fromJson(e.data())).toList();
    state = paket;
  }

  Future<void> addPakets(
      {required BuildContext context, required Pakets paket}) async {
    final doc = db.doc();
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                backgroundColor: HexColor('4392A4'),
              ),
            ));
    Navigator.pop(context);
    Pakets temp = paket.copyWith(pid: doc.id);
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

    await getPakets();
  }

  Future<void> updatePaket(
      {required BuildContext context,
      required Pakets pakets,
      required String mid}) async {
    final doc = db.doc(mid);
    Pakets temp = pakets.copyWith(pid: doc.id);
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
    await getPakets();
  }

  Future<void> deletePaket(
      {required BuildContext context, required String pid}) async {
    final doc = db.doc(pid);
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
    await getPakets();
  }
}

final PaketControllerProvider =
    StateNotifierProvider<PaketController, List<Pakets>>(
  (ref) => PaketController(),
);

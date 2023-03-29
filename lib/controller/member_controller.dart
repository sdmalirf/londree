import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:londreeapp/model/members.dart';
import 'package:londreeapp/model/outlets.dart';

class MemberController extends StateNotifier<List<Members>> {
  MemberController() : super([]);

  final db = FirebaseFirestore.instance.collection('members');

  Future<void> getMembers() async {
    var checkOutlets = await db.get();

    List<Members> members =
        checkOutlets.docs.map((e) => Members.fromJson(e.data())).toList();
    state = members;
  }

  Future<void> addMember(
      {required BuildContext context, required Members member}) async {
    final doc = db.doc();
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                backgroundColor: HexColor('4392A4'),
              ),
            ));
    Navigator.pop(context);
    Members temp = member.copyWith(mid: doc.id);
    await doc.set(temp.toJson());

    final auth = FirebaseAuth.instance;
    final dbLog = FirebaseFirestore.instance.collection('logHistory');
    final doclog = dbLog.doc();
    await doclog.set({
      'logId': doclog.id,
      'aktivitas': 'Menambah Member',
      'email': auth.currentUser!.email,
      'tgl': DateTime.now(),
    });
    // final dbLog = FirebaseFirestore.instance.collection('log_history');
    // final docID = dbLog.doc();
    // await docID.set({
    //   'log_id': docID.id,
    //   'aktivitas': 'Menambah siswa',
    //   'email': auth.currentUser!.email,
    //   'tgl': DateTime.now(),
    // });

    await getMembers();
  }

  Future<void> updateMember(
      {required BuildContext context,
      required Members members,
      required String mid}) async {
    final doc = db.doc(mid);
    Members temp = members.copyWith(mid: doc.id);
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
      'aktivitas': 'Menambah Member',
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
    await getMembers();
  }

  Future<void> deleteMember(
      {required BuildContext context, required String mid}) async {
    final doc = db.doc(mid);
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                backgroundColor: HexColor('4392A4'),
              ),
            ));
    await doc.delete();
    final auth = FirebaseAuth.instance;
    final dbLog = FirebaseFirestore.instance.collection('logHistory');
    final doclog = dbLog.doc();
    await doclog.set({
      'logId': doclog.id,
      'aktivitas': 'Menambah Member',
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
    await getMembers();
  }
}

final MemberControllerProvider =
    StateNotifierProvider<MemberController, List<Members>>(
  (ref) => MemberController(),
);

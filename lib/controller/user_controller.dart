import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:londreeapp/model/members.dart';
import 'package:londreeapp/model/outlets.dart';
import 'package:londreeapp/model/users.dart';

class UsersController extends StateNotifier<List<Users>> {
  UsersController() : super([]);

  final db = FirebaseFirestore.instance.collection('users');

  Future<void> getUsers() async {
    var checkOutlets = await db.get();

    List<Users> users =
        checkOutlets.docs.map((e) => Users.fromJson(e.data())).toList();
    state = users;
  }

  Future<void> addUsers(
      {required BuildContext context,
      required Users users,
      required String email,
      required String password}) async {
    try {
      var userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        final doc = db.doc();
        showDialog(
            context: context,
            builder: (context) => Center(
                  child: CircularProgressIndicator(
                    backgroundColor: HexColor('4392A4'),
                  ),
                ));
        Navigator.pop(context);
        Users temp = users.copyWith(uid: doc.id);
        await doc.set(temp.toJson());
      }
      ;
    } catch (e) {}

    final auth = FirebaseAuth.instance;
    // final dbLog = FirebaseFirestore.instance.collection('log_history');
    // final docID = dbLog.doc();
    // await docID.set({
    //   'log_id': docID.id,
    //   'aktivitas': 'Menambah siswa',
    //   'email': auth.currentUser!.email,
    //   'tgl': DateTime.now(),
    // });

    await getUsers();
  }

  Future<void> updateUsers(
      {required BuildContext context,
      required Users users,
      required String uid}) async {
    final doc = db.doc(uid);
    Users temp = users.copyWith(uid: doc.id);
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
    await getUsers();
  }

  Future<void> deleteUsers(
      {required BuildContext context, required String uid}) async {
    final doc = db.doc(uid);
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
    await getUsers();
  }
}

final UsersControllerProvider =
    StateNotifierProvider<UsersController, List<Users>>(
  (ref) => UsersController(),
);

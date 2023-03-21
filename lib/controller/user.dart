import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/users.dart';

class UserController extends StateNotifier<List<Users>> {
  UserController() : super([]);

  Future<void> getDetailedUsersData({required String uid}) async {
    var checkData = await FirebaseFirestore.instance.collection('users').get();

    List<Users> user =
        checkData.docs.map((e) => Users.fromJson(e.data())).toList();
    state = user;
  }
}

final userControllerProvider =
    StateNotifierProvider<UserController, List<Users>>(
  (ref) => UserController(),
);

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:londreeapp/model/users.dart';
import 'package:londreeapp/view/Page/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:londreeapp/view/component/bottom_navbar.dart';
import 'package:londreeapp/view/started/started.dart';

class AuthController extends StateNotifier<Users> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Users _users = Users();

  AuthController() : super(Users());

  Future<void> signUp(
      BuildContext context, String email, String password) async {
    try {
      var userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'uid': userCredential.user!.uid,
          // 'name': Users().name,
          // 'addres': Users().addres,
          'email': userCredential.user!.email,
          'password': password,
          // 'phone': userCredential.user!.phoneNumber,
          // 'role': Users().roles,
        });
        await FirebaseFirestore.instance
            .collection('carts')
            .doc(userCredential.user!.uid)
            .set({
          "users": userCredential.user!.uid,
          "items": [],
        });

        final users = Users(
          uid: userCredential.user!.uid,
          // name: Users().name,
          // addres: Users().addres,
          email: userCredential.user!.email,
          password: password,
          // phone: userCredential.user!.phoneNumber,
          // roles: Users().roles,
        );
        state = users;

        // if (!mounted) return;
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => started(),
        //   ),
        // );
      }
    } catch (e) {
      // Handle sign-up error
    }
  }

  // Future<void> addUserToFirestore(String uid, String name, String email) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('users').doc(uid).set({
  //       'name': name,
  //       'email': email,
  //       // add other user data as needed
  //     });
  //   } catch (e) {
  //     // Handle error
  //   }
  // }

  // Future<void> signUp2(
  //     BuildContext context, String email, String password) async {
  //   try {
  //     var userCredential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     if (userCredential.user != null) {
  //       await addUserToFirestore(userCredential.user!.uid, 'John Doe', email);
  //       // Redirect user to the next page
  //     }
  //   } catch (e) {
  //     // Handle sign-up error
  //   }
  // }

  Future<void> signIn(BuildContext context, email, password) async {
    try {
      var userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        var checkUsers = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
        if (!checkUsers.exists) {
          // Handle sign-in error: user not found in database
        } else {
          final users = Users.fromJson(checkUsers.data()!);
          state = users;

          // if (!mounted) return;
          // // Navigator.pushReplacement(
          // //   context,
          // //   MaterialPageRoute(
          // //     builder: (context) => bottomNavbar(),
          // //   ),
          // // );
        }
      } else {
        // Handle sign-in error: user not authenticated
      }
    } catch (e) {
      // Handle sign-in error
    }
  }
}

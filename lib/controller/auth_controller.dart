import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:londreeapp/model/users.dart';
import 'package:londreeapp/view/Page/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:londreeapp/view/Page/navbar/admin/admin_navbar.dart';
import 'package:londreeapp/view/Page/navbar/kasir/kasir_navbar.dart';
import 'package:londreeapp/view/Page/navbar/owner/owner_navbar.dart';
import 'package:londreeapp/view/component/snackbar.dart';
import 'package:londreeapp/view/Page/auth/login.dart';
import 'package:londreeapp/view/Page/auth/started.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class AuthController extends StateNotifier<Users> {
  AuthController() : super(Users());

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: HexColor('#4392A4'),
              ),
            ));
    try {
      var credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        var checkUsers = await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .get();
        if (!checkUsers.exists) {
          return;
        } else {
          final users = Users.fromJson(checkUsers.data()!);
          state = users;
        }
      }
      if (!mounted) return;
      Snackbars().successSnackbars(
          context, 'Berhasil Masuk', 'Selamat Datang di Londree');
      route(context);

      // .popUntil((route) => route.isFirst);
      // route(context);
    } on FirebaseAuthException catch (e) {
      var error = e.message.toString();
      Snackbars().failedSnackbars(context, 'Gagal Masuk', error);
      Navigator.pop(context);
    }
  }

  Future<void> signOut(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: HexColor('#4392A4'),
              ),
            ));
    try {
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;
      Snackbars()
          .successSnackbars(context, 'Log Out Succeed', "You're Logged Out");
      pushNewScreen(context, screen: login(), withNavBar: false);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Snackbars()
          .failedSnackbars(context, 'Log Out Failed', e.message.toString());
    }
  }

  Future<void> registerPengguna(BuildContext context, String email,
      String password, String name, String role,
      {required String oid}) async {
    // FirebaseApp app = await Firebase.initializeApp(
    //     name: 'Secondary', options: Firebase.app().options);
    try {
      var userCredential = await FirebaseAuth.instance
          // .instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'oid': oid,
        'name': name,
        'role': role,
        // 'addres': addres,
        'email': email,
        'password': password,
        // 'phone': phone,
        // 'role': roles,
      });
      // final auth = FirebaseAuth.instance;
      // final dbLog = FirebaseFirestore.instance.collection('log_history');
      // final doc = dbLog.doc();
      // await doc.set({
      //   'log_id': doc.id,
      //   'aktivitas': 'Membuat akun',
      //   'email': auth.currentUser!.email,
      //   'tgl': DateTime.now(),
      // });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      // ignore: use_build_context_synchronously
      Snackbars()
          .successSnackbars(context, 'Berhasil', 'Berhasil Menambah Akun');
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Snackbars().failedSnackbars(context, 'Gagal', e.message.toString());
    }

    // await app.delete();

    // return Future.sync(() => FirebaseAuth.instanceFor(app: app));
  }

  void route(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    // ignore: unused_local_variable
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "Admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const adminNavbar(),
            ),
          );
        } else if (documentSnapshot.get('role') == "Kasir") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const kasirNavbar(),
            ),
          );
        } else if (documentSnapshot.get('role') == "Owner") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ownerNavbar(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => login(),
            ),
          );
        }
      } else {
        return;
      }
    });
  }

//   // Future<void> addUserToFirestore(String uid, String name, String email) async {
//   //   try {
//   //     await FirebaseFirestore.instance.collection('users').doc(uid).set({
//   //       'name': name,
//   //       'email': email,
//   //       // add other user data as needed
//   //     });
//   //   } catch (e) {
//   //     // Handle error
//   //   }
//   // }

//   // Future<void> signUp2(
//   //     BuildContext context, String email, String password) async {
//   //   try {
//   //     var userCredential =
//   //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//   //       email: email,
//   //       password: password,
//   //     );
//   //     if (userCredential.user != null) {
//   //       await addUserToFirestore(userCredential.user!.uid, 'John Doe', email);
//   //       // Redirect user to the next page
//   //     }
//   //   } catch (e) {
//   //     // Handle sign-up error
//   //   }
//   // }

//   Future<void> signIn(BuildContext context, email, password) async {
//     try {
//       var userCredential =
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       if (userCredential.user != null) {
//         var checkUsers = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(userCredential.user!.uid)
//             .get();
//         if (!checkUsers.exists) {
//           // Handle sign-in error: user not found in database
//         } else {
//           final users = Users.fromJson(checkUsers.data()!);
//           state = users;

//           // if (!mounted) return;
//           // // Navigator.pushReplacement(
//           // //   context,
//           // //   MaterialPageRoute(
//           // //     builder: (context) => adminNavbar(),
//           // //   ),
//           // // );
//         }
//       } else {
//         // Handle sign-in error: user not authenticated
//       }
//     } catch (e) {
//       // Handle sign-in error
//     }
//   }
}

final authControllerProvider = StateNotifierProvider<AuthController, Users>(
  (ref) => AuthController(),
);

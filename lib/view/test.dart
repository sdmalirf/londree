import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class testHome extends StatelessWidget {
  final String name;
  final String email;

  const testHome({Key? key, required this.name, required this.email})
      : super(key: key);

  Future<void> _addUserToFirestore(String uid) async {
    try {
      await FirebaseFirestore.instance.collection('user').doc(uid).set({
        'name': name,
        'email': email,
        // add other user data as needed
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, $name!'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                var user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  await _addUserToFirestore(user.uid);
                }
              },
              child: Text('Add user to Firestore'),
            ),
          ],
        ),
      ),
    );
  }
}

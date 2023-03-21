import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/view/Page/ActionPage/add.dart';
import 'package:londreeapp/view/Page/home.dart';
import 'package:londreeapp/view/started/login.dart';
import 'package:londreeapp/view/started/started.dart';
import 'package:londreeapp/view/test.dart';

class splachScreen extends StatefulWidget {
  const splachScreen({super.key});

  @override
  State<splachScreen> createState() => _splachScreenState();
}

class _splachScreenState extends State<splachScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => started()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Image.asset("assets/images/Londree-Logo.png")));
  }
}

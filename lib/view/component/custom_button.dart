import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/view/started/login.dart';

class customButton extends StatelessWidget {
  final String title;
  final color;
  final textcolor;
  String? link;
  Function()? press;

  customButton(
      {super.key,
      required this.title,
      required this.color,
      required this.textcolor,
      link,
      this.press});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: color,
      onPressed: press,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(child: SvgPicture.asset(icon!)),
            Center(
              child: Text(
                title,
                style: TextStyle(
                    color: textcolor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}

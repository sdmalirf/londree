import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class heroContainer extends StatelessWidget {
  const heroContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/images/started-image1.svg"),
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 10),
          child: Text(
            "Memudahkan Pencatatan",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
            width: 220,
            child: Text(
              "Kamu bisa mencatat data laundry mu dengan mudah dan cepat",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ))
      ],
    );
  }
}

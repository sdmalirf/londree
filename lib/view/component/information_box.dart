import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class informationBox extends StatefulWidget {
  final double pt;
  final double pb;
  final double pl;
  final double pr;
  final double sizeBox;
  final double heightBox;
  final String label;
  final String picture;
  final String desc;
  final String desc2;

  const informationBox(
      {super.key,
      required this.pt,
      required this.pb,
      required this.pl,
      required this.pr,
      required this.sizeBox,
      required this.heightBox,
      required this.label,
      required this.picture,
      required this.desc,
      required this.desc2});

  @override
  State<informationBox> createState() => _informationBoxState();
}

class _informationBoxState extends State<informationBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(
          top: widget.pt, bottom: widget.pb, left: widget.pl, right: widget.pr),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * widget.sizeBox,
      height: MediaQuery.of(context).size.height * widget.heightBox,
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border.all(width: 3, color: Color.fromARGB(255, 228, 228, 228)),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 129, 129, 129)),
              ),
              SvgPicture.asset(widget.picture)
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Row(
            children: [
              Text(
                widget.desc.toString(),
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 5)),
              Text(
                widget.desc2.toString(),
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    ));
  }
}

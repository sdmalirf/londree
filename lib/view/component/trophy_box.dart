import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class trophyBox extends StatefulWidget {
  const trophyBox({super.key});

  @override
  State<trophyBox> createState() => _trophyBoxState();
}

class _trophyBoxState extends State<trophyBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Row(
            children: [SvgPicture.asset("images/assets/medal-1st.svg")],
          ),
          Column(
            children: [],
          )
        ],
      ),
    );
  }
}

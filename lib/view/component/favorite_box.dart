import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class favoriteBox extends StatefulWidget {
  const favoriteBox({super.key});

  @override
  State<favoriteBox> createState() => _favoriteBoxState();
}

class _favoriteBoxState extends State<favoriteBox> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 35),
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) => SizedBox(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 4, color: Color.fromARGB(255, 201, 201, 201)),
              color: Color.fromARGB(255, 212, 223, 252),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(children: [
                SvgPicture.asset("assets/images/medal-1st.svg"),
                Padding(padding: EdgeInsets.only(left: 6)),
                Text(
                  "Londree Naryo",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ]),
              Text(
                "Skor:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Text(
                "1920",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}

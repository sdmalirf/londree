import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class futureBox extends StatefulWidget {
  const futureBox({super.key});

  @override
  State<futureBox> createState() => _futureBoxState();
}

class _futureBoxState extends State<futureBox> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          top: 0,
          child: Container(
            width: 400,
            height: 80,
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 250, 250, 250)),
          )),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 253, 254, 255),
            ),
            padding:
                EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/images/store-icon.svg")),
                    Text("Cabang")
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon:
                            SvgPicture.asset("assets/images/people-icon.svg")),
                    Text("Pelanggan")
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/images/box-icon.svg")),
                    Text("Paket")
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset("assets/images/bill-icon.svg")),
                    Text("Transaksi")
                  ],
                )
              ],
            )),
      ),
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:londreeapp/view/component/information_box.dart';

class informationContainer extends StatefulWidget {
  const informationContainer({super.key});

  @override
  State<informationContainer> createState() => _informationContainerState();
}

class _informationContainerState extends State<informationContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          child: Container(
        width: 400,
        height: 190,
        color: Color.fromARGB(31, 201, 201, 201),
      )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                informationBox(
                    sizeBox: 0.46,
                    heightBox: 0.12,
                    pt: 10,
                    pb: 10,
                    pl: 20,
                    pr: 20,
                    label: "Transaksi",
                    picture: "assets/images/bill-icon.svg",
                    desc: "Rp.",
                    desc2: "7.439.323"),
                informationBox(
                    sizeBox: 0.46,
                    heightBox: 0.16,
                    pt: 10,
                    pb: 10,
                    pl: 20,
                    pr: 20,
                    label: "Cabang",
                    picture: "assets/images/store-icon.svg",
                    desc: "",
                    desc2: "50"),
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 0)),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                informationBox(
                    sizeBox: 0.35,
                    heightBox: 0.15,
                    pt: 10,
                    pb: 10,
                    pl: 10,
                    pr: 10,
                    label: "Pelanggan",
                    picture: "assets/images/people-icon.svg",
                    desc: "",
                    desc2: "189"),
                informationBox(
                    sizeBox: 0.35,
                    heightBox: 0.13,
                    pt: 10,
                    pb: 10,
                    pl: 20,
                    pr: 20,
                    label: "Paket",
                    picture: "assets/images/box-icon.svg",
                    desc: "",
                    desc2: "20"),
              ],
            )
          ],
        ),
      ),
    ]);
  }
}

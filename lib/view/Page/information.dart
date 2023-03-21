import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/view/component/chip_list.dart';
import 'package:londreeapp/view/component/container_information.dart';
import 'package:londreeapp/view/component/information_box.dart';
import 'package:londreeapp/view/component/table.dart';

class informationPage extends StatefulWidget {
  const informationPage({super.key});

  @override
  State<informationPage> createState() => _informationPageState();
}

class _informationPageState extends State<informationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Image.asset(
            "assets/images/Londree-Logo.png",
            width: 100,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset("assets/images/notifications-icon.svg")),
          ],
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      "assets/images/search-icon.svg",
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  hintText: "Mau cari info apa?",
                ),
              ),
            ),
            Center(
              child: Container(
                child: informationContainer(),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                color: Color.fromARGB(31, 194, 194, 194),
                child: chipList()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Stack(
                children: [
                  //tableData()
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ChoiceChip(label: Text("Transaksi"), selected: selected)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

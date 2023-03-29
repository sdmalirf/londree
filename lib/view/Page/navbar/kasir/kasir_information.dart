import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/controller/outlet_controller.dart';
import 'package:londreeapp/view/Page/pengguna/ActionMember/addPengguna.dart';
import 'package:londreeapp/view/component/chip_list.dart';
import 'package:londreeapp/view/component/container_information.dart';
import 'package:londreeapp/view/component/information_box.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class kasirInformation extends ConsumerStatefulWidget {
  const kasirInformation({super.key});

  @override
  ConsumerState<kasirInformation> createState() => _kasirInformationState();
}

class _kasirInformationState extends ConsumerState<kasirInformation> {
  @override
  Widget build(BuildContext context) {
    final cabang = ref.watch(OutletControllerProvider);

    return Scaffold(
        // floatingActionButton: FloatingActionButton.extended(
        //     foregroundColor: Colors.blue,
        //     backgroundColor: Color.fromARGB(255, 255, 255, 255),
        //     label: Text(
        //       "Pengguna",
        //       style:
        //           TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        //     ),
        //     icon: SvgPicture.asset("assets/images/people-icon.svg"),
        //     onPressed: () {
        //       pushNewScreen(context,
        //           screen: addPenggunaPage(), withNavBar: false);
        //     }),
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
                child: Stack(children: [
                  Positioned(
                      child: Container(
                    width: 400,
                    height: 190,
                    color: Color.fromARGB(31, 201, 201, 201),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            informationBox(
                                colors: Colors.blue,
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
                                colors: Color.fromARGB(255, 228, 228, 228),
                                sizeBox: 0.46,
                                heightBox: 0.16,
                                pt: 10,
                                pb: 10,
                                pl: 20,
                                pr: 20,
                                label: "Cabang",
                                picture: "assets/images/store-icon.svg",
                                desc: "",
                                desc2: cabang.length.toString()),
                          ],
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 0)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            informationBox(
                                colors: Color.fromARGB(255, 228, 228, 228),
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
                                colors: Colors.blue,
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
                ]),
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

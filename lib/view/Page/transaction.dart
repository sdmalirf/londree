import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/controller/table_controller.dart';
import 'package:londreeapp/controller/user.dart';
import 'package:londreeapp/view/Page/ActionPage/add.dart';
import 'package:londreeapp/view/Page/ActionPage/edit.dart';
import 'package:londreeapp/view/component/chip_list.dart';
import 'package:londreeapp/view/component/dropdown_menu.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:londreeapp/view/component/paged_table.dart';
import 'package:londreeapp/view/component/table.dart';
import 'package:londreeapp/view/component/text_input.dart';
import 'package:londreeapp/view/started/login.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class transactionPage extends StatefulWidget {
  const transactionPage({
    super.key,
  });

  @override
  State<transactionPage> createState() => _transactionPageState();
}

class _transactionPageState extends State<transactionPage> {
  final TableController _tableController = TableController();
  TextEditingController nama = TextEditingController();
  TextEditingController berat = TextEditingController();
  TextEditingController total = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Widget float1() {
      return Container(
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            if (tableData.selectedRow = true) {
              pushNewScreen(context,
                  screen: EditPage(
                    data: tableData.data,
                  ),
                  withNavBar: false);
            }
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => login(),
            //     ));

            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => EditPage(),
            //     ));
          },
          heroTag: "add",
          tooltip: 'add',
          child: SvgPicture.asset(
            "assets/images/add-new-icon.svg",
            width: 30,
          ),
        ),
      );
    }

    Widget float2() {
      return Container(
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: null,
          heroTag: "edit",
          tooltip: 'edit',
          child: SvgPicture.asset(
            "assets/images/edit-icon.svg",
            width: 25,
          ),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: AnimatedFloatingActionButton(
        //Fab list
        fabButtons: <Widget>[float1(), float2()],
        colorStartAnimation: Colors.blue,
        colorEndAnimation: Colors.blue,
        animatedIconData: AnimatedIcons.menu_close, //To principal button
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tanggal",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 30,
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 200, child: TextInputCustom()),
                      IconButton(
                          iconSize: 40,
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/images/date-icon.svg",
                            width: 40,
                          ))
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Text(
                    "Status Pembayaran",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Container(
                    width: 230,
                    height: 30,
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: Container(
                          padding: EdgeInsets.all(9),
                          child: SvgPicture.asset(
                              "assets/images/left-arrow-icon.svg"),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                "assets/images/bill-icon.svg",
                width: 100,
              ),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Row(
            children: [
              Container(
                height: 32,
                width: 250,
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Container(
                      padding: EdgeInsets.all(9),
                      child: SvgPicture.asset("assets/images/search-icon.svg"),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
              Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      onPressed: () {},
                      child: Container(
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/filter-icon.svg"),
                            Padding(padding: EdgeInsets.all(2)),
                            Text(
                              "Filter",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      )))
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          tableData(),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  width: 150,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        alignment: Alignment.center,
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      onPressed: () {
                        print(_tableController.getTrans(
                            // uid: 'uid'
                            ));
                        // _tableController.addPlan();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/donwload-icon.svg"),
                            Padding(padding: EdgeInsets.all(2)),
                            Text(
                              "Unduh data",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ))),
            ],
          )
        ],
      ),
    );
  }
}

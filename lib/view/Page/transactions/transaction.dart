import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/controller/auth_controller.dart';
import 'package:londreeapp/controller/transaction_controller.dart';
import 'package:londreeapp/model/transactions.dart';
import 'package:londreeapp/view/Page/transactions/ActionPage/add.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:londreeapp/view/Page/transactions/ActionPage/edit.dart';
import 'package:londreeapp/view/component/paged_table.dart';
import 'package:londreeapp/view/component/snackbar.dart';
import 'package:londreeapp/view/component/table.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'package:excel/excel.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class transactionPage extends ConsumerStatefulWidget {
  Transactions? data;
  transactionPage({super.key, this.data});

  @override
  ConsumerState<transactionPage> createState() => _transactionPageState();
}

class _transactionPageState extends ConsumerState<transactionPage> {
  TextEditingController nama = TextEditingController();
  TextEditingController berat = TextEditingController();
  TextEditingController total = TextEditingController();
  bool selectedRow = false;
  int? selectedRowIndex;
  int? datapick;

  bool isloading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   getAllTransaksi();
  //   loadData();
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getAllTransaksi();
    loadData();
  }

  List<Transactions> transaksiResult = [];

  Future<void> getAllTransaksi() async {
    final users = ref.watch(authControllerProvider);
    await ref.read(transactionControllerProvider.notifier).getTransaction();
  }

  Future loadData() async {
    setState(() {
      isloading = true;
    });

    await Future.delayed(
      const Duration(seconds: 1),
      () {
        if (mounted) {
          setState(() {
            isloading = false;
          });
        }
      },
    );
  }

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    Future exportOfficerToExcel() async {
      PermissionStatus status = await Permission.storage.request();
      if (status != PermissionStatus.granted) return;

      Directory? directory = await getExternalStorageDirectory();
      String fileName = "DataTransaksi.xlsx";
      String filePath =
          "${directory!.parent.parent.parent.parent.path}/Download/$fileName";

      try {
        QuerySnapshot querySnapshot = await db.collection('transactions').get();
        var workbook = Excel.createExcel();
        var sheet = workbook['Sheet1'];
        // Add headers to worksheet
        sheet.appendRow([
          'ID',
          'nama',
          'berat',
          'total',
        ]);
        // Add data to worksheet
        for (var document in querySnapshot.docs) {
          dynamic documentData = document.data();
          var row = [
            documentData!['tid'].toString(),
            documentData!['nama'].toString(),
            documentData!['berat'].toString(),
            documentData!['total'].toString(),
          ];
          sheet.appendRow(row);
        }
        // Save the file
        File file = File(filePath);
        file.writeAsBytesSync(workbook.save()!);
        // awesome dialog file saved successfully
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Berhasil mendownload file!',
          desc: 'File tersimpan di folder Download di perangkat anda.',
          buttonsBorderRadius: BorderRadius.circular(6),
          showCloseIcon: false,
          btnCancelText: 'Buka File',
          btnCancelOnPress: () async {
            final result = await OpenFile.open(filePath);
            if (result.type == ResultType.noAppToOpen ||
                result.type == ResultType.fileNotFound ||
                result.type == ResultType.permissionDenied) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.bottomSlide,
                title: 'Gagal membuka file!',
                desc: result.message,
                btnOkOnPress: () {},
                btnOkText: 'Tutup',
                buttonsBorderRadius: BorderRadius.circular(6),
              ).show();
            }
          },
          btnOkText: 'Kembali Ke Home',
          btnOkOnPress: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/menu-panel', (route) => false);
          },
        ).show();
      } catch (e) {
        log(e.toString());
      }
    }

    Widget float1() {
      return Container(
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            pushNewScreen(context, screen: addPage(), withNavBar: false);
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
          onPressed: () {
            if (selectedRow = true) {
              pushNewScreen(context,
                  screen: editPage(
                    data: widget.data,
                  ),
                  withNavBar: false);
            }
          },
          heroTag: "edit",
          tooltip: 'edit',
          child: SvgPicture.asset(
            "assets/images/edit-icon.svg",
            width: 25,
          ),
        ),
      );
    }

    Widget float3() {
      return Container(
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () async {
            try {
              await ref
                  .read(transactionControllerProvider.notifier)
                  .deleteTransaction(
                      context: context, tid: widget.data!.tid.toString());
              setState(() {});
              if (!mounted) {
                return;
              }
              Snackbars().successSnackbars(
                  context, 'Berhasil', 'Berhasil Menghapus Data');
            } on FirebaseException catch (e) {
              Snackbars()
                  .failedSnackbars(context, 'gagal', e.message.toString());
            }
          },
          heroTag: "delete",
          tooltip: 'delete',
          child: SvgPicture.asset(
            "assets/images/delete-icon.svg",
            width: 35,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah"),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        //Fab list
        fabButtons: <Widget>[float1(), float2(), float3()],
        colorStartAnimation: Colors.blue,
        colorEndAnimation: Colors.blue,
        animatedIconData: AnimatedIcons.menu_close, //To principal button
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tanggal",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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
                        child:
                            SvgPicture.asset("assets/images/search-icon.svg"),
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
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
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
            Expanded(
                child: StreamBuilder<List<Transactions>>(
              stream: ref.watch(transactionControllerProvider.notifier).stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  transaksiResult = snapshot.data!;
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 3,
                            color: Color.fromARGB(255, 212, 212, 212)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        DataTable(
                          showCheckboxColumn: false,
                          columnSpacing: 50.0,
                          dataRowHeight: 30,
                          headingRowHeight: 35,
                          columns: [
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Nama',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Berat',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Total',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Tanggal',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                          ],
                          rows: [],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                                showCheckboxColumn: false,
                                columnSpacing: 45.0,
                                dataRowHeight: 30,
                                dataTextStyle: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.black),
                                headingRowHeight: 0,
                                columns: [
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ],
                                rows: [
                                  ...transaksiResult
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    final rowIndex = entry.key;
                                    final data = entry.value;

                                    return DataRow(
                                      selected: selectedRowIndex == rowIndex,
                                      onSelectChanged: (value) {
                                        setState(() {
                                          final users =
                                              ref.watch(authControllerProvider);
                                          widget.data =
                                              transaksiResult[rowIndex];
                                          print(data.nama);
                                          print(users.uid);
                                          print(data.berat);
                                          selectedRow = value!;
                                          selectedRowIndex = rowIndex;
                                        });
                                      },
                                      cells: <DataCell>[
                                        DataCell(
                                          SizedBox(
                                              width: 50,
                                              child:
                                                  Text(data.nama.toString())),
                                        ),
                                        DataCell(
                                          SizedBox(
                                              width: 40,
                                              child:
                                                  Text(data.berat.toString())),
                                        ),
                                        DataCell(
                                          SizedBox(
                                              width: 30,
                                              child:
                                                  Text(data.total.toString())),
                                        ),
                                        DataCell(
                                          SizedBox(
                                              width: 50,
                                              child: Text(
                                                "nama",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )),
                                        ),
                                      ],
                                    );
                                  }),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: 150,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        onPressed: () {
                          exportOfficerToExcel();
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  "assets/images/donwload-icon.svg"),
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
      ),
    );
  }
}

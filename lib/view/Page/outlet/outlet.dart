import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/controller/auth_controller.dart';
import 'package:londreeapp/controller/outlet_controller.dart';
import 'package:londreeapp/controller/transaction_controller.dart';
import 'package:londreeapp/model/outlets.dart';
import 'package:londreeapp/model/transactions.dart';
import 'package:londreeapp/view/Page/outlet/ActionOutlet/addOutlet.dart';
import 'package:londreeapp/view/Page/outlet/ActionOutlet/detailOutlet.dart';
import 'package:londreeapp/view/Page/outlet/ActionOutlet/editOutlet.dart';
import 'package:londreeapp/view/Page/transactions/ActionPage/add.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:londreeapp/view/Page/transactions/ActionPage/edit.dart';
import 'package:londreeapp/view/component/paged_table.dart';
import 'package:londreeapp/view/component/snackbar.dart';
import 'package:londreeapp/view/component/table.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class outletPage extends ConsumerStatefulWidget {
  Outlets? data;
  outletPage({super.key, this.data});

  @override
  ConsumerState<outletPage> createState() => _outletPage();
}

class _outletPage extends ConsumerState<outletPage> {
  TextEditingController search = TextEditingController();
  bool selectedRow = false;
  int? selectedRowIndex;
  int? datapick;

  bool isloading = true;

  int? _sortColumnIndex;
  bool _sortAscending = true;

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      selectedRowIndex = -1;
    });
  }
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
    getAllOutlets();
    loadData();
  }

  List<Outlets> outletResult = [];

  Future<void> getAllOutlets() async {
    final users = ref.watch(authControllerProvider);
    await ref.read(OutletControllerProvider.notifier).getOutlets();
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
    var outlet = ref.watch(OutletControllerProvider);

    void updateList(String value) {
      try {
        if (value != '') {
          outletResult.clear();

          var temp = outlet
              .where((element) =>
                      element.nama!.toLowerCase().contains(value.toLowerCase())
                  // ||
                  // element.nis!.toLowerCase().contains(value.toLowerCase()))
                  )
              .toList();
          temp.map((e) => outletResult.add(e)).toList();
        } else {
          outletResult.clear();
        }
      } catch (e) {
        print(e);
      }
    }

    Widget float1() {
      return Container(
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            pushNewScreen(context, screen: addOutletPage(), withNavBar: false);
          },
          heroTag: "tambah",
          tooltip: 'tambah',
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
                  screen: editOutlet(
                    data: widget.data,
                  ),
                  withNavBar: false);
            }
          },
          heroTag: "ubah",
          tooltip: 'ubah',
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
              await ref.read(OutletControllerProvider.notifier).deleteOutlet(
                  context: context, oid: widget.data!.oid.toString());
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
          heroTag: "hapus",
          tooltip: 'hapus',
          child: SvgPicture.asset(
            "assets/images/delete-icon.svg",
            width: 35,
          ),
        ),
      );
    }

    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          return true;
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("Cabang"),
            ),
            floatingActionButton: AnimatedFloatingActionButton(
              //Fab list
              fabButtons: <Widget>[float1(), float2(), float3()],
              colorStartAnimation: Colors.blue,
              colorEndAnimation: Colors.blue,
              animatedIconData: AnimatedIcons.menu_close, //To principal button
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jumlah Cabang",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                          Row(
                            children: [
                              Text(
                                outlet.length.toString(),
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4)),
                              Text(
                                "Cabang",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black45),
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: SvgPicture.asset(
                          "assets/images/store-icon.svg",
                          width: 70,
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  Row(
                    children: [
                      Container(
                        height: 32,
                        width: 230,
                        child: TextField(
                          controller: search,
                          onChanged: (value) {
                            updateList(value);
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            suffixIcon: search.text.isNotEmpty
                                ? IconButton(
                                    splashRadius: 20,
                                    onPressed: () {
                                      search.text = '';
                                      FocusScope.of(context).unfocus();
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                    ))
                                : null,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                      Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              onPressed: () {
                                _sortAscending = true;
                                selectedRowIndex = -1;
                                search.text = '';
                                updateList('');
                                setState(() {});
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/redo.svg",
                                      width: 16,
                                    ),
                                    Padding(padding: EdgeInsets.all(1)),
                                    Text(
                                      "Bersihkan",
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                              )))
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  SizedBox(
                      width: 360,
                      height: 360,
                      child: StreamBuilder<List<Outlets>>(
                        stream:
                            ref.watch(OutletControllerProvider.notifier).stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            search.text.isNotEmpty
                                ? outletResult
                                : outlet = snapshot.data!;
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3,
                                      color:
                                          Color.fromARGB(255, 212, 212, 212)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  DataTable(
                                    sortColumnIndex: _sortColumnIndex,
                                    sortAscending: _sortAscending,
                                    showCheckboxColumn: false,
                                    columnSpacing: 60.0,
                                    dataRowHeight: 30,
                                    headingRowHeight: 35,
                                    columns: [
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Nama',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        onSort: (columnIndex, ascending) =>
                                            _onSort(columnIndex, ascending),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Alamat',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        onSort: (columnIndex, ascending) =>
                                            _onSort(columnIndex, ascending),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Kontak',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        onSort: (columnIndex, ascending) =>
                                            _onSort(columnIndex, ascending),
                                      ),
                                    ],
                                    rows: [],
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: DataTable(
                                          sortColumnIndex: _sortColumnIndex,
                                          sortAscending: _sortAscending,
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
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Text(
                                                  '',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Text(
                                                  '',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                            ),
                                          ],
                                          rows: [
                                            ...((search.text.isNotEmpty
                                                    ? outletResult
                                                    : outlet)
                                                  ..sort((a, b) {
                                                    if (_sortColumnIndex ==
                                                        null) {
                                                      return 0;
                                                    }
                                                    final columnIndex =
                                                        _sortColumnIndex!;
                                                    final ascending =
                                                        _sortAscending ? 1 : -1;
                                                    switch (columnIndex) {
                                                      case 0: // Nama
                                                        return ascending *
                                                            a.nama!.compareTo(
                                                                b.nama!);
                                                      case 1: // Berat
                                                        return ascending *
                                                            a.alamat!.compareTo(
                                                                b.alamat!);
                                                      case 2: // Total
                                                        return ascending *
                                                            a.kontak!.compareTo(
                                                                b.kontak!);
                                                      // case 3: // Keterangan
                                                      //   return ascending *
                                                      //       a.keterangan!
                                                      //           .compareTo(b.keterangan!);
                                                      default:
                                                        return 0;
                                                    }
                                                  }))
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              final rowIndex = entry.key;
                                              final data = entry.value;

                                              return DataRow(
                                                onLongPress: () {
                                                  if (selectedRowIndex ==
                                                      rowIndex) {
                                                    pushNewScreen(context,
                                                        screen: detailOutlet(
                                                            data: widget.data));
                                                  } else
                                                    (e) {};
                                                  setState(() {
                                                    selectedRowIndex ==
                                                        rowIndex;
                                                  });
                                                },
                                                selected: selectedRowIndex ==
                                                    rowIndex,
                                                onSelectChanged: (value) {
                                                  setState(() {
                                                    final outlet = ref.watch(
                                                        OutletControllerProvider);
                                                    widget.data =
                                                        (search.text.isNotEmpty
                                                            ? outletResult
                                                            : outlet)[rowIndex];

                                                    selectedRow = value!;
                                                    selectedRowIndex = rowIndex;
                                                  });
                                                },
                                                cells: <DataCell>[
                                                  DataCell(
                                                    SizedBox(
                                                        width: 60,
                                                        child: Text(data.nama
                                                            .toString())),
                                                  ),
                                                  DataCell(
                                                    SizedBox(
                                                        width: 80,
                                                        child: Text(data.alamat
                                                            .toString())),
                                                  ),
                                                  DataCell(
                                                    SizedBox(
                                                        width: 70,
                                                        child: Text(data.kontak
                                                            .toString())),
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
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              onPressed: () {
                                print(outletResult);
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
          ),
        ));
  }
}







// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:londreeapp/controller/auth_controller.dart';
// import 'package:londreeapp/controller/transaction_controller.dart';
// import 'package:londreeapp/model/transactions.dart';
// import 'package:londreeapp/view/Page/transactions/ActionPage/add.dart';
// import 'package:animated_floating_buttons/animated_floating_buttons.dart';
// import 'package:londreeapp/view/Page/transactions/ActionPage/edit.dart';
// import 'package:londreeapp/view/component/paged_table.dart';
// import 'package:londreeapp/view/component/snackbar.dart';
// import 'package:londreeapp/view/component/table.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

// class outletPage extends ConsumerStatefulWidget {
//   Transactions? data;
//   outletPage({super.key});

//   @override
//   ConsumerState<outletPage> createState() => _outletPageState();
// }

// class _outletPageState extends ConsumerState<outletPage> {
//   TextEditingController nama = TextEditingController();
//   TextEditingController berat = TextEditingController();
//   TextEditingController total = TextEditingController();
//   bool selectedRow = false;
//   int? selectedRowIndex;
//   int? datapick;

//   bool isloading = true;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   getAllTransaksi();
//   //   loadData();
//   // }

//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//     getAllTransaksi();
//     loadData();
//   }

//   List<Transactions> outletResult = [];

//   Future<void> getAllTransaksi() async {
//     final users = ref.watch(authControllerProvider);
//     await ref
//         .read(OutletControllerProvider.notifier)
//         .getTransaction(uid: users.uid!);
//   }

//   Future loadData() async {
//     setState(() {
//       isloading = true;
//     });

//     await Future.delayed(
//       const Duration(seconds: 1),
//       () {
//         if (mounted) {
//           setState(() {
//             isloading = false;
//           });
//         }
//       },
//     );
//   }

//   ScrollController _scrollController = ScrollController();

//   @override
//   Widget build(BuildContext context) {
//     Widget float1() {
//       return Container(
//         child: FloatingActionButton(
//           backgroundColor: Colors.white,
//           onPressed: () {
//             pushNewScreen(context, screen: addPage(), withNavBar: false);
//           },
//           heroTag: "add",
//           tooltip: 'add',
//           child: SvgPicture.asset(
//             "assets/images/add-new-icon.svg",
//             width: 30,
//           ),
//         ),
//       );
//     }

//     Widget float2() {
//       return Container(
//         child: FloatingActionButton(
//           backgroundColor: Colors.white,
//           onPressed: () {
//             if (selectedRow = true) {
//               pushNewScreen(context,
//                   screen: editPage(
//                     data: widget.data,
//                   ),
//                   withNavBar: false);
//             }
//           },
//           heroTag: "edit",
//           tooltip: 'edit',
//           child: SvgPicture.asset(
//             "assets/images/edit-icon.svg",
//             width: 25,
//           ),
//         ),
//       );
//     }

//     Widget float3() {
//       return Container(
//         child: FloatingActionButton(
//           backgroundColor: Colors.white,
//           onPressed: () async {
//             try {
//               await ref
//                   .read(OutletControllerProvider.notifier)
//                   .deleteTransaction(
//                       context: context, tid: widget.data!.tid.toString());
//               setState(() {});
//               if (!mounted) {
//                 return;
//               }
//               Snackbars().successSnackbars(
//                   context, 'Berhasil', 'Berhasil Menghapus Data');
//             } on FirebaseException catch (e) {
//               Snackbars()
//                   .failedSnackbars(context, 'gagal', e.message.toString());
//             }
//           },
//           heroTag: "delete",
//           tooltip: 'delete',
//           child: SvgPicture.asset(
//             "assets/images/delete-icon.svg",
//             width: 35,
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(),
//         body: ListView(
//             padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Pelanggan",
//                         style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black54),
//                       ),
//                       Padding(padding: EdgeInsets.symmetric(vertical: 5)),
//                       Row(
//                         children: [
//                           Text(
//                             "230",
//                             style: TextStyle(
//                                 fontSize: 40, fontWeight: FontWeight.w600),
//                           ),
//                           Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
//                           Text(
//                             "Orang",
//                             style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black45),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                   SvgPicture.asset(
//                     "assets/images/store-icon.svg",
//                     width: 70,
//                   )
//                 ],
//               ),
//               Padding(padding: EdgeInsets.symmetric(vertical: 20)),
//               Row(children: [
//                 Container(
//                   height: 32,
//                   width: 230,
//                   child: TextField(
//                     decoration: InputDecoration(
//                       suffixIcon: Container(
//                         padding: EdgeInsets.all(9),
//                         child:
//                             SvgPicture.asset("assets/images/search-icon.svg"),
//                       ),
//                       contentPadding:
//                           EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(padding: EdgeInsets.symmetric(horizontal: 7)),
//                 Expanded(
//                     child: ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStatePropertyAll(Colors.white),
//                           shape: MaterialStatePropertyAll(
//                               RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10))),
//                         ),
//                         onPressed: () {},
//                         child: Container(
//                           child: Row(
//                             children: [
//                               SvgPicture.asset("assets/images/filter-icon.svg"),
//                               Padding(padding: EdgeInsets.all(2)),
//                               Text(
//                                 "Filter",
//                                 style: TextStyle(color: Colors.black),
//                               )
//                             ],
//                           ),
//                         ))),
//                 Padding(padding: EdgeInsets.symmetric(vertical: 20)),
//                 Expanded(
//                     child: StreamBuilder<List<Transactions>>(
//                         stream: ref
//                             .watch(OutletControllerProvider.notifier)
//                             .stream,
//                         builder: (context, snapshot) {
//                           if (snapshot.hasData) {
//                             outletResult = snapshot.data!;
//                             return Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                         width: 3,
//                                         color:
//                                             Color.fromARGB(255, 212, 212, 212)),
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Column(
//                                   children: [
//                                     DataTable(
//                                       showCheckboxColumn: false,
//                                       columnSpacing: 50.0,
//                                       dataRowHeight: 30,
//                                       headingRowHeight: 35,
//                                       columns: [
//                                         DataColumn(
//                                           label: Expanded(
//                                             child: Text(
//                                               'Nama',
//                                               style: TextStyle(
//                                                   fontStyle: FontStyle.italic),
//                                             ),
//                                           ),
//                                         ),
//                                         DataColumn(
//                                           label: Expanded(
//                                             child: Text(
//                                               'Berat',
//                                               style: TextStyle(
//                                                   fontStyle: FontStyle.italic),
//                                             ),
//                                           ),
//                                         ),
//                                         DataColumn(
//                                           label: Expanded(
//                                             child: Text(
//                                               'Total',
//                                               style: TextStyle(
//                                                   fontStyle: FontStyle.italic),
//                                             ),
//                                           ),
//                                         ),
//                                         DataColumn(
//                                           label: Expanded(
//                                             child: Text(
//                                               'Tanggal',
//                                               style: TextStyle(
//                                                   fontStyle: FontStyle.italic),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                       rows: [],
//                                     ),
//                                     Expanded(
//                                       child: SingleChildScrollView(
//                                         scrollDirection: Axis.vertical,
//                                         child: DataTable(
//                                             showCheckboxColumn: false,
//                                             columnSpacing: 45.0,
//                                             dataRowHeight: 30,
//                                             dataTextStyle: TextStyle(
//                                                 overflow: TextOverflow.ellipsis,
//                                                 color: Colors.black),
//                                             headingRowHeight: 0,
//                                             columns: [
//                                               DataColumn(
//                                                 label: Expanded(
//                                                   child: Text(
//                                                     '',
//                                                     style: TextStyle(
//                                                         fontStyle:
//                                                             FontStyle.italic),
//                                                   ),
//                                                 ),
//                                               ),
//                                               DataColumn(
//                                                 label: Expanded(
//                                                   child: Text(
//                                                     '',
//                                                     style: TextStyle(
//                                                         fontStyle:
//                                                             FontStyle.italic),
//                                                   ),
//                                                 ),
//                                               ),
//                                               DataColumn(
//                                                 label: Expanded(
//                                                   child: Text(
//                                                     '',
//                                                     style: TextStyle(
//                                                         fontStyle:
//                                                             FontStyle.italic),
//                                                   ),
//                                                 ),
//                                               ),
//                                               DataColumn(
//                                                 label: Expanded(
//                                                   child: Text(
//                                                     '',
//                                                     style: TextStyle(
//                                                         fontStyle:
//                                                             FontStyle.italic),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                             rows: [
//                                               ...outletResult
//                                                   .asMap()
//                                                   .entries
//                                                   .map((entry) {
//                                                 final rowIndex = entry.key;
//                                                 final data = entry.value;

//                                                 return DataRow(
//                                                   selected: selectedRowIndex ==
//                                                       rowIndex,
//                                                   onSelectChanged: (value) {
//                                                     setState(() {
//                                                       final users = ref.watch(
//                                                           authControllerProvider);
//                                                       widget.data =
//                                                           outletResult[
//                                                               rowIndex];
//                                                       print(data.nama);
//                                                       print(users.uid);
//                                                       print(data.berat);
//                                                       selectedRow = value!;
//                                                       selectedRowIndex =
//                                                           rowIndex;
//                                                     });
//                                                   },
//                                                   cells: <DataCell>[
//                                                     DataCell(
//                                                       SizedBox(
//                                                           width: 50,
//                                                           child: Text(data.nama
//                                                               .toString())),
//                                                     ),
//                                                     DataCell(
//                                                       SizedBox(
//                                                           width: 40,
//                                                           child: Text(data.berat
//                                                               .toString())),
//                                                     ),
//                                                     DataCell(
//                                                       SizedBox(
//                                                           width: 30,
//                                                           child: Text(data.total
//                                                               .toString())),
//                                                     ),
//                                                     DataCell(
//                                                       SizedBox(
//                                                           width: 50,
//                                                           child: Text(
//                                                             "nama",
//                                                             style: TextStyle(
//                                                                 color: Colors
//                                                                     .black),
//                                                           )),
//                                                     ),
//                                                   ],
//                                                 );
//                                               }),
//                                             ]),
//                                       ),
//                                     ),
//                                   ],
//                                 ));
//                           } else {
//                             return Center(child: CircularProgressIndicator());
//                           }
//                         }))
//               ])
//             ]));
//   }
// }

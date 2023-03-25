import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/controller/transaction_controller.dart';
import 'package:londreeapp/model/transactions.dart';
import 'package:londreeapp/view/component/bottom_navbar.dart';
import 'package:londreeapp/view/component/favorite_box.dart';
import 'package:londreeapp/view/component/future_box.dart';
import 'package:londreeapp/view/component/paged_table.dart';
import 'package:londreeapp/view/component/table.dart';

class home extends ConsumerStatefulWidget {
  const home({super.key});

  @override
  ConsumerState<home> createState() => _homeState();
}

class _homeState extends ConsumerState<home> {
  bool selectedRow = false;
  int? selectedRowIndex;
  int? datapick;

  bool isloading = true;

  @override
  void initState() {
    super.initState();
    getAllTransaksi();
  }

  // @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getAllTransaksi();
    loadData();
  }

  List<Transactions> transaksiResult = [];

  Future<void> getAllTransaksi() async {
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

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(6, (index) => const favoriteBox());
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
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/images/search-icon.svg")),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Seluruh Pendaftaran",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black26),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: [
                  Text(
                    "Rp",
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(padding: EdgeInsets.only(right: 5)),
                  Text(
                    "4.890.500",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              Text(
                "Pesanan Belum Diambil / Belum Selesai",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black26),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: [
                  Text(
                    "5",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  Padding(padding: EdgeInsets.only(right: 5)),
                  Text(
                    "Org",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "/",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w300,
                        color: Colors.black26),
                  ),
                  Text(
                    "5",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  Padding(padding: EdgeInsets.only(right: 5)),
                  Text(
                    "Org",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  // RotatedBox(
                  //   quarterTurns: 20,
                  //   child: Expanded(child: Divider()),
                  // )
                ],
              ),
            ]),
          ),
          futureBox(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/images/history-icon.svg"),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text(
                            "Pesanan Terakhir",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => home(),
                              ));
                        },
                        child: Text("Semua pesanan"))
                  ],
                ),
                DataTransaksi()

                // Expanded(
                //     child: StreamBuilder<List<Transactions>>(
                //   stream:
                //       ref.watch(transactionControllerProvider.notifier).stream,
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       transaksiResult = snapshot.data!;
                //       return DataTable(
                //           showCheckboxColumn: false,
                //           columnSpacing: 45.0,
                //           dataRowHeight: 30,
                //           dataTextStyle: TextStyle(
                //               overflow: TextOverflow.ellipsis,
                //               color: Colors.black),
                //           headingRowHeight: 35,
                //           decoration: BoxDecoration(
                //               border: Border.all(
                //                   width: 3,
                //                   color: Color.fromARGB(255, 212, 212, 212)),
                //               borderRadius: BorderRadius.circular(10)),
                //           columns: [
                //             DataColumn(
                //               label: Expanded(
                //                 child: Text(
                //                   'Nama',
                //                   style: TextStyle(fontStyle: FontStyle.italic),
                //                 ),
                //               ),
                //             ),
                //             DataColumn(
                //               label: Expanded(
                //                 child: Text(
                //                   'Berat',
                //                   style: TextStyle(fontStyle: FontStyle.italic),
                //                 ),
                //               ),
                //             ),
                //             DataColumn(
                //               label: Expanded(
                //                 child: Text(
                //                   'Total',
                //                   style: TextStyle(fontStyle: FontStyle.italic),
                //                 ),
                //               ),
                //             ),
                //             DataColumn(
                //               label: Expanded(
                //                 child: Text(
                //                   'Tanggal',
                //                   style: TextStyle(fontStyle: FontStyle.italic),
                //                 ),
                //               ),
                //             ),
                //           ],
                //           rows: [
                //             ...transaksiResult.asMap().entries.map((entry) {
                //               final rowIndex = entry.key;
                //               final data = entry.value;

                //               return DataRow(
                //                 selected: selectedRowIndex == rowIndex,
                //                 onSelectChanged: (value) {
                //                   setState(() {
                //                     // widget.data = transaksiResult[rowIndex];
                //                     // print(data.nama);
                //                     // print(data.berat);
                //                     selectedRow = value!;
                //                     selectedRowIndex = rowIndex;
                //                   });
                //                 },
                //                 cells: <DataCell>[
                //                   DataCell(
                //                     SizedBox(
                //                         width: 50,
                //                         child: Text(data.nama.toString())),
                //                   ),
                //                   DataCell(
                //                     SizedBox(
                //                         width: 40,
                //                         child: Text(data.berat.toString())),
                //                   ),
                //                   DataCell(
                //                     SizedBox(
                //                         width: 30,
                //                         child: Text(data.total.toString())),
                //                   ),
                //                   DataCell(
                //                     SizedBox(
                //                         width: 50,
                //                         child: Text(
                //                           "nama",
                //                           style: TextStyle(color: Colors.black),
                //                         )),
                //                   ),
                //                 ],
                //               );
                //             }),
                //           ]

                //           // DataRow(
                //           //   selected: false,
                //           //   cells: <DataCell>[
                //           //     DataCell(
                //           //       SizedBox(
                //           //           width: 40,
                //           //           child: Text(
                //           //             "Sadam Ali Rafsanjani",
                //           //             style: TextStyle(overflow: TextOverflow.ellipsis),
                //           //           )),
                //           //     ),
                //           //   ],
                //           // ),
                //           );

                //       ;
                //     } else {
                //       return Center(child: CircularProgressIndicator());
                //     }
                //   },
                // )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 20,
            ),
            color: Color.fromARGB(255, 250, 250, 250),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/images/trophy-icon.svg"),
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text(
                          "Outlet Terfavorit",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => home(),
                            ));
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Text("Semua outlet")))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 5)),
                  SizedBox(
                    height: 120,
                    child: PageView.builder(
                        itemCount: 3,
                        itemBuilder: (_, index) {
                          return pages[index % pages.length];
                        }),
                  )
                ],
              )
            ]),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Text(
                  "By",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 134, 134, 134)),
                ),
                Text(
                  "Ujikom 2022",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                      fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
      //   body: Stack(children: [
      //     Positioned(
      //         top: 270,
      //         child: Container(
      //           width: 400,
      //           height: 80,
      //           decoration:
      //               BoxDecoration(color: Color.fromARGB(255, 250, 250, 250)),
      //         )),
      //     ListView(
      //         padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      //         children: [
      //           Text(
      //             "Seluruh Pendaftaran",
      //             style: TextStyle(
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.w500,
      //                 color: Colors.black26),
      //           ),
      //           Padding(padding: EdgeInsets.only(top: 10)),
      //           Row(
      //             children: [
      //               Text(
      //                 "Rp",
      //                 style: TextStyle(fontSize: 16),
      //               ),
      //               Padding(padding: EdgeInsets.only(right: 5)),
      //               Text(
      //                 "4.890.500",
      //                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      //               ),
      //             ],
      //           ),
      //           Padding(padding: EdgeInsets.symmetric(vertical: 15)),
      //           Text(
      //             "Pesanan Belum Diambil / Belum Selesai",
      //             style: TextStyle(
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.w500,
      //                 color: Colors.black26),
      //           ),
      //           Padding(padding: EdgeInsets.only(top: 10)),
      //           Row(children: [
      //             Text(
      //               "5",
      //               style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
      //             ),
      //             Padding(padding: EdgeInsets.only(right: 5)),
      //             Text(
      //               "Org",
      //               style: TextStyle(
      //                 fontSize: 16,
      //               ),
      //             ),
      //             Text(
      //               "/",
      //               style: TextStyle(
      //                   fontSize: 50,
      //                   fontWeight: FontWeight.w300,
      //                   color: Colors.black26),
      //             ),
      //             Text(
      //               "5",
      //               style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
      //             ),
      //             Padding(padding: EdgeInsets.only(right: 5)),
      //             Text(
      //               "Org",
      //               style: TextStyle(
      //                 fontSize: 16,
      //               ),
      //             ),
      //             // RotatedBox(
      //             //   quarterTurns: 20,
      //             //   child: Expanded(child: Divider()),
      //             // )
      //           ]),
      //           Container(
      //               margin: EdgeInsets.only(top: 30),
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(10),
      //                 color: Color.fromARGB(255, 253, 254, 255),
      //               ),
      //               padding: EdgeInsetsDirectional.symmetric(
      //                   horizontal: 8, vertical: 8),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 children: [
      //                   Column(
      //                     children: [
      //                       IconButton(
      //                           onPressed: () {},
      //                           icon: SvgPicture.asset(
      //                               "assets/images/store-icon.svg")),
      //                       Text("Cabang")
      //                     ],
      //                   ),
      //                   Column(
      //                     children: [
      //                       IconButton(
      //                           onPressed: () {},
      //                           icon: SvgPicture.asset(
      //                               "assets/images/people-icon.svg")),
      //                       Text("Pelanggan")
      //                     ],
      //                   ),
      //                   Column(
      //                     children: [
      //                       IconButton(
      //                           onPressed: () {},
      //                           icon: SvgPicture.asset(
      //                               "assets/images/box-icon.svg")),
      //                       Text("Paket")
      //                     ],
      //                   ),
      //                   Column(
      //                     children: [
      //                       IconButton(
      //                           onPressed: () {},
      //                           icon: SvgPicture.asset(
      //                               "assets/images/bill-icon.svg")),
      //                       Text("Transaksi")
      //                     ],
      //                   )
      //                 ],
      //               )),
      //           Padding(padding: EdgeInsets.only(top: 50)),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Row(
      //                 children: [
      //                   SvgPicture.asset("assets/images/history-icon.svg"),
      //                   Container(
      //                     margin: EdgeInsets.only(left: 8),
      //                     child: Text(
      //                       "Pesanan Terakhir",
      //                       style: TextStyle(
      //                           fontSize: 15, fontWeight: FontWeight.w500),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               TextButton(
      //                   onPressed: () {
      //                     Navigator.pushReplacement(
      //                         context,
      //                         MaterialPageRoute(
      //                           builder: (context) => home(),
      //                         ));
      //                   },
      //                   child: Text("Semua pesanan"))
      //             ],
      //           ),
      //         ]),
      //     Stack(
      //       children: [
      //         Positioned(
      //           top: 200,
      //           child: Container(
      //             color: Color.fromARGB(255, 250, 250, 250),
      //             width: 400,
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Row(
      //                   children: [
      //                     SvgPicture.asset("assets/images/trophy-icon.svg"),
      //                     Container(
      //                       margin: EdgeInsets.only(left: 8),
      //                       child: Text(
      //                         "Outfit Terfavorit",
      //                         style: TextStyle(
      //                             fontSize: 15, fontWeight: FontWeight.w500),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 TextButton(
      //                     onPressed: () {
      //                       Navigator.pushReplacement(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => home(),
      //                           ));
      //                     },
      //                     child: Text("Semua pesanan")),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     )
      //   ]),
    );
  }
}

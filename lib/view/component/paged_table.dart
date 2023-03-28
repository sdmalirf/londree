import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:londreeapp/controller/auth_controller.dart';
import 'package:londreeapp/controller/transaction_controller.dart';
import 'package:londreeapp/model/transactions.dart';
import 'package:paged_datatable/paged_datatable.dart';

class DataTransaksi extends ConsumerStatefulWidget {
  const DataTransaksi({super.key});

  @override
  ConsumerState<DataTransaksi> createState() => _DataTransaksiState();
}

class _DataTransaksiState extends ConsumerState<DataTransaksi> {
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    final users = ref.read(authControllerProvider);
    getAllTransaksi(users.uid!);
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   final users = ref.read(authControllerProvider);
  //   getAllTransaksi(users.uid!);
  //   loadData();
  // }

  List<Transactions> transaksiResult = [];

  Future<void> getAllTransaksi(String uid) async {
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

  // Future loadData() async {
  //   setState(() {
  //     isloading = true;
  //   });

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);

    return StreamBuilder<List<Transactions>>(
      stream: ref.watch(transactionControllerProvider.notifier).stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          transaksiResult = snapshot.data!;
          return DataTable(
              columnSpacing: 45.0,
              dataRowHeight: 30,
              dataTextStyle: TextStyle(
                  overflow: TextOverflow.ellipsis, color: Colors.black),
              headingRowHeight: 35,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 3, color: Color.fromARGB(255, 212, 212, 212)),
                  borderRadius: BorderRadius.circular(10)),
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
              rows: [
                ...transaksiResult
                    .take(5)
                    .where((element) =>
                        element.tid == 'x5yLO0N6s5TVO9tjmJe0dUASyiH2')
                    .map((data) {
                  return DataRow(
                    selected: false,
                    cells: <DataCell>[
                      DataCell(
                        SizedBox(width: 50, child: Text(data.nama.toString())),
                      ),
                      DataCell(
                        SizedBox(width: 40, child: Text(data.berat.toString())),
                      ),
                      DataCell(
                        SizedBox(width: 30, child: Text(data.total.toString())),
                      ),
                      DataCell(
                        SizedBox(
                            width: 50,
                            child: Text(
                              "nama",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                    ],
                  );
                }),
              ]

              // DataRow(
              //   selected: false,
              //   cells: <DataCell>[
              //     DataCell(
              //       SizedBox(
              //           width: 40,
              //           child: Text(
              //             "Sadam Ali Rafsanjani",
              //             style: TextStyle(overflow: TextOverflow.ellipsis),
              //           )),
              //     ),
              //   ],
              // ),
              );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

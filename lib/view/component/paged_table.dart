import 'package:flutter/material.dart';
import 'package:paged_datatable/paged_datatable.dart';

class tableData2 extends StatefulWidget {
  const tableData2({super.key});

  @override
  State<tableData2> createState() => _tableDataState();
}

class _tableDataState extends State<tableData2> {
  final List<Map<String, dynamic>> myList = [
    {
      "nama": "Yahya Alfon Sinaga",
      "berat": "15 Kg",
      "total": "78.000",
      "tanggal": "12 Nov"
    },
    {
      "nama": "Sadam Ali Rafsanjani",
      "berat": "12 Kg",
      "total": "87.000",
      "tanggal": "12 Nov"
    },
    {
      "nama": "Muhammad Emirsyah",
      "berat": "7 Kg",
      "total": "28.000",
      "tanggal": "13 Nov"
    },
    {
      "nama": "Muhammad Emirsyah",
      "berat": "7 Kg",
      "total": "28.000",
      "tanggal": "13 Nov"
    },
    {
      "nama": "Muhammad Emirsyah",
      "berat": "7 Kg",
      "total": "28.000",
      "tanggal": "13 Nov"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 45.0,
      dataRowHeight: 30,
      dataTextStyle:
          TextStyle(overflow: TextOverflow.ellipsis, color: Colors.black),
      headingRowHeight: 35,
      decoration: BoxDecoration(
          border:
              Border.all(width: 3, color: Color.fromARGB(255, 212, 212, 212)),
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
        ...myList.map((data) {
          return DataRow(
            selected: false,
            cells: <DataCell>[
              DataCell(
                SizedBox(
                    width: 50,
                    child: Text(
                      "${data['nama']}",
                    )),
              ),
              DataCell(
                SizedBox(
                    width: 40,
                    child: Text(
                      "${data['berat']}",
                    )),
              ),
              DataCell(
                SizedBox(
                    width: 30,
                    child: Text(
                      "${data['total']}",
                    )),
              ),
              DataCell(
                SizedBox(
                    width: 50,
                    child: Text(
                      "${data['tanggal']}",
                    )),
              ),
            ],
          );
        })
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
      ],
    );
  }
}

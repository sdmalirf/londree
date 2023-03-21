import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:londreeapp/view/Page/ActionPage/add.dart';
import 'package:londreeapp/view/Page/ActionPage/edit.dart';
import 'package:paged_datatable/paged_datatable.dart';

class tableData extends StatefulWidget {
  static bool? selectedRow;
  static Map<String, dynamic>? data;
  tableData({super.key, selected});

  @override
  State<tableData> createState() => _tableDataState();
}

class _tableDataState extends State<tableData> {
  bool selectedRow = false;
  int? selectedRowIndex;
  int? datapick;
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
    return Column(
      children: [
        DataTable(
          showCheckboxColumn: false,
          columnSpacing: 45.0,
          dataRowHeight: 30,
          dataTextStyle:
              TextStyle(overflow: TextOverflow.ellipsis, color: Colors.black),
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
            ...myList.asMap().entries.map((entry) {
              final rowIndex = entry.key;
              final data = entry.value;

              return DataRow(
                selected: selectedRowIndex == rowIndex,
                onSelectChanged: (value) {
                  setState(() {
                    tableData.data = myList[rowIndex];
                    print(tableData.data);
                    // if (selectedRowIndex != -1) {
                    //   Map<String, dynamic> selectedThisData =
                    //       myList[selectedRowIndex!];
                    //   tableData.data = selectedThisData;
                    // }

                    // if (selectedRowIndex != -1) {
                    //   Map<String, dynamic> selectedData =
                    //       myList[selectedRowIndex!];
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (_) => EditPage(data: selectedData),
                    //   ));
                    // }
                    // if (value == true) {
                    //   Map<String, dynamic> selectedThisData = myList[datapick!];
                    //   tableData.data = selectedThisData;
                    // }
                    selectedRow = value!;
                    selectedRowIndex = rowIndex;
                  });
                },
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
        ),
        // if (selectedDataRowIndex != -1)
        //   ElevatedButton(
        //     onPressed: () {
        //       Map<String, dynamic> selectedData = myList[selectedDataRowIndex];
        //       Navigator.of(context).push(MaterialPageRoute(
        //         builder: (_) => EditPage(data: selectedData),
        //       ));
        //     },
        //     child: null,
        //   )
      ],
    );
  }
}

// import 'dart:isolate';

// import 'package:flutter/material.dart';
// import 'package:londreeapp/view/Page/ActionPage/add.dart';
// import 'package:londreeapp/view/Page/ActionPage/edit.dart';
// import 'package:paged_datatable/paged_datatable.dart';

// class tableData extends StatefulWidget {
//   static bool? selectedRow;
//   static int? selectedData;
//   static Map<String, dynamic>? data;

//   const tableData({
//     super.key,
//   });

//   @override
//   State<tableData> createState() => _tableDataState();
// }

// class _tableDataState extends State<tableData> {
//   bool selectedRow = false;
//   int? selectedRowIndex;

//   final List<Map<String, dynamic>> myList = [
//     {
//       "nama": "Yahya Alfon Sinaga",
//       "berat": "15 Kg",
//       "total": "78.000",
//       "tanggal": "12 Nov"
//     },
//     {
//       "nama": "Sadam Ali Rafsanjani",
//       "berat": "12 Kg",
//       "total": "87.000",
//       "tanggal": "12 Nov"
//     },
//     {
//       "nama": "Muhammad Emirsyah",
//       "berat": "7 Kg",
//       "total": "28.000",
//       "tanggal": "13 Nov"
//     },
//     {
//       "nama": "Muhammad Emirsyah",
//       "berat": "7 Kg",
//       "total": "28.000",
//       "tanggal": "13 Nov"
//     },
//     {
//       "nama": "Muhammad Emirsyah",
//       "berat": "7 Kg",
//       "total": "28.000",
//       "tanggal": "13 Nov"
//     }
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         DataTable(
//           showCheckboxColumn: false,
//           columnSpacing: 45.0,
//           dataRowHeight: 30,
//           dataTextStyle:
//               TextStyle(overflow: TextOverflow.ellipsis, color: Colors.black),
//           headingRowHeight: 35,
//           decoration: BoxDecoration(
//               border: Border.all(
//                   width: 3, color: Color.fromARGB(255, 212, 212, 212)),
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
//             ...myList.asMap().entries.map((entry) {
//               final rowIndex = entry.key;
//               final data = entry.value;

//               return DataRow(
//                 selected: selectedRowIndex == rowIndex,
//                 onSelectChanged: (value) {
//                   setState(() {
//                     Map<String, dynamic> selectedThisData =
//                         myList[selectedRowIndex!];
//                     tableData.data = selectedThisData;
//                     selectedRow = value!;
//                     selectedRowIndex = rowIndex;
//                   });
//                 },
//                 cells: <DataCell>[
//                   DataCell(
//                     SizedBox(
//                         width: 50,
//                         child: Text(
//                           "${data['nama']}",
//                         )),
//                   ),
//                   DataCell(
//                     SizedBox(
//                         width: 40,
//                         child: Text(
//                           "${data['berat']}",
//                         )),
//                   ),
//                   DataCell(
//                     SizedBox(
//                         width: 30,
//                         child: Text(
//                           "${data['total']}",
//                         )),
//                   ),
//                   DataCell(
//                     SizedBox(
//                         width: 50,
//                         child: Text(
//                           "${data['tanggal']}",
//                         )),
//                   ),
//                 ],
//               );
//             })
//             // DataRow(
//             //   selected: false,
//             //   cells: <DataCell>[
//             //     DataCell(
//             //       SizedBox(
//             //           width: 40,
//             //           child: Text(
//             //             "Sadam Ali Rafsanjani",
//             //             style: TextStyle(overflow: TextOverflow.ellipsis),
//             //           )),
//             //     ),
//             //   ],
//             // ),
//           ],
//         ),
//         // if (selectedDataRowIndex != -1)
//         //   ElevatedButton(
//         //     onPressed: () {
//         //       Map<String, dynamic> selectedData = myList[selectedDataRowIndex];
//         //       Navigator.of(context).push(MaterialPageRoute(
//         //         builder: (_) => EditPage(data: selectedData),
//         //       ));
//         //     },
//         //     child: null,
//         //   )
//       ],
//     );
//   }
// }


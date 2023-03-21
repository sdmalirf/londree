import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/controller/table_controller.dart';
import 'package:londreeapp/view/component/custom_button.dart';
import 'package:londreeapp/view/component/text_input.dart';

class addPage extends StatefulWidget {
  const addPage({super.key});

  @override
  State<addPage> createState() => _addPageState();
}

class _addPageState extends State<addPage> {
  final TableController _tableController = TableController();
  final _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _auth = FirebaseFirestore.instance;

  String _nama = '';
  String _berat = '';
  String _total = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tambah"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            Center(
              child: SvgPicture.asset(
                "assets/images/people-icon.svg",
                width: 100,
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextInputCustom(
                      title: "Nama Pelanggan",
                      onSave: (value) {
                        _nama = value!;
                      },
                    ),
                    TextInputCustom(
                      title: "berat",
                      onSave: (value) {
                        _berat = value!;
                      },
                    ),
                    TextInputCustom(
                      title: "total",
                      onSave: (value) {
                        _total = value!;
                      },
                    ),
                    TextInputCustom(
                      title: "Nomor Telepon",
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                    Row(
                      children: [
                        Expanded(
                          child: customButton(
                              title: "Batalkan",
                              color: Colors.white,
                              textcolor: Colors.black,
                              link: ""),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                        Expanded(
                          child: customButton(
                            title: "Ubah",
                            color: Colors.blue,
                            textcolor: Colors.white,
                            press: () {
                              // _tableController.addTrans();
                            },
                            // press: () async {
                            //   try {
                            //     await _tableController.uploadingData(
                            //         "idTrans", "nama", "berat", "total");
                            //     // kode selanjutnya setelah berhasil mengunggah data
                            //   } catch (e) {
                            //     print('Error uploading data: $e');
                            //     // kode untuk menangani error
                            //   }
                            // },
                          ),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ));
  }
}

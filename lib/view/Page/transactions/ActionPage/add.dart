import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/controller/auth_controller.dart';
import 'package:londreeapp/controller/transaction_controller.dart';
import 'package:londreeapp/model/transactions.dart';
import 'package:londreeapp/view/component/bottom_navbar.dart';
import 'package:londreeapp/view/component/custom_button.dart';
import 'package:londreeapp/view/component/snackbar.dart';
import 'package:londreeapp/view/component/custom_input.dart';

class addPage extends ConsumerStatefulWidget {
  const addPage({super.key});

  @override
  ConsumerState<addPage> createState() => _addPageState();
}

class _addPageState extends ConsumerState<addPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nama = TextEditingController();
  final TextEditingController _berat = TextEditingController();
  final TextEditingController _total = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nama.dispose();
    _berat.dispose();
    _total.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.read(authControllerProvider);
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
                    Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 12),
                              child: Text(
                                'nama',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextFormField(
                              controller: _nama,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  border: OutlineInputBorder(),
                                  hintText: 'nama'),
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 12),
                              child: Text(
                                'berat',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextFormField(
                              controller: _berat,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  border: OutlineInputBorder(),
                                  hintText: 'berat'),
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 12),
                              child: Text(
                                'total',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextFormField(
                              controller: _total,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  border: OutlineInputBorder(),
                                  hintText: 'total'),
                            )
                          ],
                        )),
                    // TextInputCustom(
                    //   title: "Nama Pelanggan",
                    //   controller: _nama,
                    // ),
                    // TextInputCustom(
                    //   title: "berat",
                    //   controller: _berat,
                    // ),
                    // TextInputCustom(
                    //   title: "total",
                    //   controller: _total,
                    // ),
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
                          title: "Tambah",
                          color: Colors.blue,
                          textcolor: Colors.white,
                          press: () async {
                            try {
                              Transactions transaction = Transactions(
                                  nama: _nama.text,
                                  berat: _berat.text,
                                  total: _total.text,
                                  uid: users.uid);
                              await ref
                                  .read(transactionControllerProvider.notifier)
                                  .addTransaction(
                                      context: context,
                                      transactions: transaction,
                                      uid: users.uid!);
                              setState(() {});
                              if (!mounted) return;
                              Snackbars().successSnackbars(context, 'Berhasil',
                                  'Berhasil Menambah Siswa');
                              Navigator.pop(context);
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => bottomNavbar()));
                            } on FirebaseException catch (e) {
                              Snackbars().failedSnackbars(
                                  context, 'Gagal', e.message.toString());
                            }
                          },
                        ))
                      ],
                    )
                  ],
                ))
          ],
        ));
  }
}

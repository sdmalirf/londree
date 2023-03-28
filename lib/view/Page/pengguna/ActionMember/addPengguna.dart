import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:londreeapp/controller/auth_controller.dart';
import 'package:londreeapp/controller/member_controller.dart';
import 'package:londreeapp/controller/outlet_controller.dart';
import 'package:londreeapp/controller/user_controller.dart';
import 'package:londreeapp/model/members.dart';
import 'package:londreeapp/model/outlets.dart';
import 'package:londreeapp/model/users.dart';
import 'package:londreeapp/view/component/custom_button.dart';
import 'package:londreeapp/view/component/snackbar.dart';

class addPenggunaPage extends ConsumerStatefulWidget {
  const addPenggunaPage({super.key});

  @override
  ConsumerState<addPenggunaPage> createState() => _memberState();
}

class _memberState extends ConsumerState<addPenggunaPage> {
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _nama = '';
  String _password = '';

  final List<String> role = [
    'Owner',
    'Kasir',
  ];
  String? _selectedRole;
  String? _selectedOutlet;

  List<Outlets> outletResult = [];

  Future<void> getAllData() async {
    final users = ref.watch(authControllerProvider);
    await ref.read(OutletControllerProvider.notifier).getOutlets();
  }

  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getAllData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
                    Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 12),
                              child: Text(
                                'Nama Pengguna',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextFormField(
                              validator: (value) {
                                _nama = value!;
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  border: OutlineInputBorder(),
                                  hintText: 'nama pengguna'),
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
                                'Email',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextFormField(
                              validator: (value) {
                                _username = value!;
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  border: OutlineInputBorder(),
                                  hintText: 'email pengguna'),
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
                                'Password',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextFormField(
                              validator: (value) {
                                _password = value!;
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  border: OutlineInputBorder(),
                                  hintText: 'password pengguna'),
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
                                'Pilih Outlet',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              child: StreamBuilder<List<Outlets>>(
                                  stream: ref
                                      .watch(OutletControllerProvider.notifier)
                                      .stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      outletResult = snapshot.data!;

                                      return DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField2(
                                          decoration:
                                              const InputDecoration.collapsed(
                                                  hintText: ''),
                                          validator: (val) {
                                            if (val == null || val == '') {
                                              return 'Pilih Jenis Paket';
                                            }
                                            return null;
                                          },
                                          isExpanded: true,
                                          buttonDecoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 211, 211, 211),
                                                  width: 2)),
                                          buttonHeight: 50,
                                          buttonPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0, vertical: 5),
                                          items: outletResult
                                              .asMap()
                                              .entries
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item.value.oid,
                                                    child: Text(
                                                      item.value.nama
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Color.fromARGB(
                                                              255, 46, 46, 46)),
                                                    ),
                                                  ))
                                              .toList(),
                                          value: _selectedOutlet,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedOutlet = value!;
                                            });
                                          },
                                          dropdownMaxHeight: 150,
                                          dropdownDecoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 240, 240, 240),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5))),
                                          iconEnabledColor:
                                              Color.fromARGB(255, 0, 0, 0),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400),
                                          dropdownElevation: 1,
                                          scrollbarThickness: 5,
                                          scrollbarAlwaysShow: true,
                                          scrollbarRadius:
                                              const Radius.circular(40),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 12),
                                      child: Text(
                                        'Pilih Role',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField2(
                                        decoration:
                                            const InputDecoration.collapsed(
                                                hintText: ''),
                                        validator: (val) {
                                          if (val == null || val == '') {
                                            return 'Pilih Role';
                                          }
                                          return null;
                                        },
                                        isExpanded: true,
                                        buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 211, 211, 211),
                                                width: 2)),
                                        buttonHeight: 50,
                                        buttonPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 5),
                                        items: role
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Color.fromARGB(
                                                            255, 46, 46, 46)),
                                                  ),
                                                ))
                                            .toList(),
                                        value: _selectedRole,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedRole = value!;
                                          });
                                        },
                                        dropdownMaxHeight: 150,
                                        dropdownDecoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 240, 240, 240),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5))),
                                        iconEnabledColor:
                                            Color.fromARGB(255, 0, 0, 0),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400),
                                        dropdownElevation: 1,
                                        scrollbarThickness: 5,
                                        scrollbarAlwaysShow: true,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                      ),
                                    ),
                                  ],
                                )),
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
                              press: () {
                                Navigator.pop(context);
                              },
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
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      await ref
                                          .read(authControllerProvider.notifier)
                                          .registerPengguna(
                                              context,
                                              _username,
                                              _password,
                                              _nama,
                                              _selectedOutlet.toString(),
                                              oid: _selectedOutlet.toString());
                                      setState(() {});
                                      if (!mounted) return;
                                      Snackbars().successSnackbars(
                                          context,
                                          'Berhasil',
                                          'Berhasil Menambah Siswa');
                                      Navigator.pop(context);
                                      // Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => bottomNavbar()));
                                    } on FirebaseException catch (e) {
                                      Snackbars().failedSnackbars(context,
                                          'Gagal', e.message.toString());
                                    }
                                  }
                                }))
                      ],
                    )
                  ],
                ))
          ],
        ));
  }
}

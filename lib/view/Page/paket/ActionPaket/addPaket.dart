import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:londreeapp/controller/member_controller.dart';
import 'package:londreeapp/controller/outlet_controller.dart';
import 'package:londreeapp/controller/paket_controller.dart';
import 'package:londreeapp/model/members.dart';
import 'package:londreeapp/model/outlets.dart';
import 'package:londreeapp/model/pakets.dart';
import 'package:londreeapp/view/component/custom_button.dart';
import 'package:londreeapp/view/component/snackbar.dart';

class addPaket extends ConsumerStatefulWidget {
  Pakets? data;
  addPaket({super.key});

  @override
  ConsumerState<addPaket> createState() => _paketState();
}

class _paketState extends ConsumerState<addPaket> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nama = TextEditingController();
  final TextEditingController _harga = TextEditingController();

  List<Outlets> outletResult = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nama.dispose();
    _harga.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final List<String> items = [
    'Kiloan',
    'Selimut',
    'Bed Cover',
    'Kaos',
    'Lainnya',
  ];
  String? _selectedOutlet;
  String? _selectedJenis;

  final CollectionReference _outletRef =
      FirebaseFirestore.instance.collection('outlets');

  @override
  Widget build(BuildContext context) {
    final outlets = ref.read(OutletControllerProvider);

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
                                  hintText: 'nama outlet'),
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
                                'Jenis Paket',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            // StreamBuilder<QuerySnapshot>(
                            //     stream: _outletRef.snapshots(),
                            //     builder: (context, snapshot) {
                            //       List<String> outletList = [];
                            //       for (var doc in snapshot.data!.docs) {
                            //         String outlet = doc['nama'];
                            //         if (!outletList.contains(outlet)) {
                            //           outletList.add(outlet);
                            //         }
                            //       }

                            //       return DropdownButtonHideUnderline(
                            //         child: DropdownButtonFormField2(
                            //           decoration:
                            //               const InputDecoration.collapsed(
                            //                   hintText: ''),
                            //           validator: (val) {
                            //             if (val == null || val == '') {
                            //               return 'Pilih Jenis Paket';
                            //             }
                            //             return null;
                            //           },
                            //           isExpanded: true,
                            //           buttonDecoration: BoxDecoration(
                            //               borderRadius: const BorderRadius.all(
                            //                   Radius.circular(5)),
                            //               border: Border.all(
                            //                   color: Color.fromARGB(
                            //                       255, 211, 211, 211),
                            //                   width: 2)),
                            //           buttonHeight: 50,
                            //           buttonPadding: const EdgeInsets.symmetric(
                            //               horizontal: 0, vertical: 5),
                            //           items: outletList
                            //               .map((item) =>
                            //                   DropdownMenuItem<String>(
                            //                     value: item,
                            //                     child: Text(
                            //                       item.toString(),
                            //                       style: const TextStyle(
                            //                           fontSize: 16,
                            //                           color: Color.fromARGB(
                            //                               255, 46, 46, 46)),
                            //                     ),
                            //                   ))
                            //               .toList(),
                            //           value: _selectedOutlet,
                            //           onChanged: (value) {
                            //             setState(() {
                            //               _selectedOutlet = value!.toString();
                            //             });
                            //           },
                            //           dropdownMaxHeight: 150,
                            //           dropdownDecoration: BoxDecoration(
                            //               color: Color.fromARGB(
                            //                   255, 240, 240, 240),
                            //               borderRadius: const BorderRadius.all(
                            //                   Radius.circular(5))),
                            //           iconEnabledColor:
                            //               Color.fromARGB(255, 0, 0, 0),
                            //           style: const TextStyle(
                            //               color: Colors.black,
                            //               fontFamily: 'Poppins',
                            //               fontWeight: FontWeight.w400),
                            //           dropdownElevation: 1,
                            //           scrollbarThickness: 5,
                            //           scrollbarAlwaysShow: true,
                            //           scrollbarRadius:
                            //               const Radius.circular(40),
                            //         ),
                            //       );
                            //     }),
                            DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2(
                                decoration: const InputDecoration.collapsed(
                                    hintText: ''),
                                validator: (val) {
                                  if (val == null || val == '') {
                                    return 'Pilih Jenis Paket';
                                  }
                                  return null;
                                },
                                isExpanded: true,
                                buttonDecoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 211, 211, 211),
                                        width: 2)),
                                buttonHeight: 50,
                                buttonPadding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 5),
                                items: items
                                    .map((item) => DropdownMenuItem<String>(
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
                                value: _selectedJenis,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedJenis = value!;
                                  });
                                },
                                dropdownMaxHeight: 150,
                                dropdownDecoration: BoxDecoration(
                                    color: Color.fromARGB(255, 240, 240, 240),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                iconEnabledColor: Color.fromARGB(255, 0, 0, 0),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400),
                                dropdownElevation: 1,
                                scrollbarThickness: 5,
                                scrollbarAlwaysShow: true,
                                scrollbarRadius: const Radius.circular(40),
                              ),
                            ),
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
                                'Harga Paket',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextFormField(
                              controller: _harga,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  border: OutlineInputBorder(),
                                  hintText: 'harga paket'),
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
                            final outlet =
                                ref.watch(OutletControllerProvider.notifier);
                            try {
                              Pakets pakets = Pakets(
                                  nama: _nama.text,
                                  harga: int.tryParse(_harga.text),
                                  jenis: _selectedJenis);
                              await ref
                                  .read(PaketControllerProvider.notifier)
                                  .addPakets(
                                    context: context,
                                    paket: pakets,
                                  );
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

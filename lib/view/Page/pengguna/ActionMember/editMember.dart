import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:londreeapp/controller/member_controller.dart';
import 'package:londreeapp/controller/outlet_controller.dart';
import 'package:londreeapp/controller/transaction_controller.dart';
import 'package:londreeapp/model/members.dart';
import 'package:londreeapp/model/outlets.dart';
import 'package:londreeapp/model/transactions.dart';
import 'package:londreeapp/view/page/home/bottom_navbar.dart';
import 'package:londreeapp/view/component/custom_button.dart';
import 'package:londreeapp/view/component/snackbar.dart';
import 'package:londreeapp/view/component/custom_input.dart';

class editMember extends ConsumerStatefulWidget {
  final Members? data;

  editMember({super.key, this.data});

  @override
  ConsumerState<editMember> createState() => _editMemberState();
}

class _editMemberState extends ConsumerState<editMember> {
  int count = 0;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nama;
  late TextEditingController _alamat;
  String? _selectedvalue;

  late TextEditingController _kontak;

  @override
  void initState() {
    _selectedvalue = widget.data!.jeniskelamin;
    super.initState();
    _nama = TextEditingController(text: widget.data!.nama);
    _alamat = TextEditingController(text: widget.data!.alamat);
    _kontak = TextEditingController(text: widget.data!.kontak);
  }

  @override
  void dispose() {
    _nama.dispose();
    _alamat.dispose();
    _kontak.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final List<String> items = [
    'Lakilaki',
    'Perempuan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit"),
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
                                'Alamat',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextFormField(
                              controller: _alamat,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  border: OutlineInputBorder(),
                                  hintText: 'alamat'),
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
                                'Jenis Kelamin',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2(
                                decoration: const InputDecoration.collapsed(
                                    hintText: ''),
                                validator: (val) {
                                  if (val == null || val == '') {
                                    return 'Pilih Jenis Kelamin';
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
                                value: _selectedvalue,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedvalue = newValue.toString();
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
                                'kontak',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            TextFormField(
                              controller: _kontak,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  border: OutlineInputBorder(),
                                  hintText: 'kontak'),
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
                            try {
                              Members members = Members(
                                  nama: _nama.text,
                                  alamat: _alamat.text,
                                  kontak: _kontak.text,
                                  jeniskelamin: _selectedvalue);
                              await ref
                                  .read(MemberControllerProvider.notifier)
                                  .updateMember(
                                      context: context,
                                      members: members,
                                      mid: widget.data!.mid.toString());
                              setState(() {});
                              if (!mounted) return;
                              Snackbars().successSnackbars(context, 'Berhasil',
                                  'Berhasil Menambah Siswa');
                              Navigator.of(context)
                                  .popUntil((_) => count++ >= 2);

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




// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:londreeapp/view/Page/information.dart';
// import 'package:londreeapp/view/page/home/bottom_navbar.dart';
// import 'package:londreeapp/view/component/custom_button.dart';

// class editInput extends StatelessWidget {
//   final String? hint;
//   final String? value;
//   TextEditingController? controller;

//   editInput({super.key, this.hint, this.value, this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       style: TextStyle(color: Colors.black),
//       decoration: InputDecoration(
//           suffixIcon: Container(
//               padding: EdgeInsets.all(10),
//               child: SvgPicture.asset(
//                 "assets/images/pencil-icon.svg",
//               )),
//           contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(15)),
//           ),
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.black)),
//     );
//   }
// }

// class editMember extends StatefulWidget {
//   final Map<String, dynamic>? data;

//   editMember({Key? key, this.data}) : super(key: key);

//   @override
//   State<editMember> createState() => _editMemberState();
// }

// class _editMemberState extends State<editMember> {
//   late TextEditingController namaController;

//   late TextEditingController alamatController;

//   late TextEditingController jenisKelaminController;

//   late TextEditingController nomorTeleponController;

//   @override
//   void initState() {
//     super.initState();

//     // inisialisasi controller dengan data yang diberikan
//     namaController = TextEditingController(text: widget.data!['nama']);
//     alamatController = TextEditingController(text: widget.data!['alamat']);
//     jenisKelaminController =
//         TextEditingController(text: widget.data!['jenisKelamin']);
//     nomorTeleponController =
//         TextEditingController(text: widget.data!['nomorTelepon']);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("edit"),
//       ),
//       body: ListView(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//         children: [
//           Form(
//               child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Expanded(child: editInput(controller: namaController)),
//                   Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
//                   SvgPicture.asset(
//                     "assets/images/people-icon.svg",
//                     width: 60,
//                   )
//                 ],
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 12, top: 50),
//                 child: Text(
//                   "Alamat",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//               ),
//               editInput(
//                 controller: alamatController,
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 12, top: 30),
//                 child: Text(
//                   "Jenis Kelamin",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//               ),
//               editInput(),
//               Container(
//                 margin: EdgeInsets.only(bottom: 12, top: 30),
//                 child: Text(
//                   "Nomor Telepon",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//               ),
//               editInput(),
//               Padding(padding: EdgeInsets.symmetric(vertical: 20)),
//               Row(
//                 children: [
//                   Expanded(
//                     child: customButton(
//                         title: "Batalkan",
//                         color: Colors.white,
//                         textcolor: Colors.black,
//                         link: ""),
//                   ),
//                   Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
//                   Expanded(
//                     child: customButton(
//                         title: "Ubah",
//                         color: Colors.blue,
//                         textcolor: Colors.white,
//                         link: ""),
//                   )
//                 ],
//               )
//             ],
//           )),
//           ElevatedButton(
//               onPressed: () {
//                 print(widget.data);
//               },
//               child: Text("test")),
//           Text("${widget.data!['nama']}"),
//         ],
//       ),
//     );
//   }
// }
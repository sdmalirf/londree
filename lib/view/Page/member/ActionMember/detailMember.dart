import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/controller/outlet_controller.dart';
import 'package:londreeapp/controller/transaction_controller.dart';
import 'package:londreeapp/model/members.dart';
import 'package:londreeapp/model/transactions.dart';
import 'package:londreeapp/view/component/bottom_navbar.dart';
import 'package:londreeapp/view/component/custom_button.dart';
import 'package:londreeapp/view/component/snackbar.dart';
import 'package:londreeapp/view/component/custom_input.dart';

class detailMember extends ConsumerStatefulWidget {
  final Members? data;

  detailMember({super.key, this.data});

  @override
  ConsumerState<detailMember> createState() => _detailMemberState();
}

class _detailMemberState extends ConsumerState<detailMember> {
  int count = 0;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nama;
  late TextEditingController _alamat;
  late TextEditingController _jeniskelamin;
  late TextEditingController _kontak;

  @override
  void initState() {
    super.initState();
    _nama = TextEditingController(text: widget.data!.nama);
    _alamat = TextEditingController(text: widget.data!.alamat);
    _jeniskelamin = TextEditingController(text: widget.data!.jeniskelamin);
    _kontak = TextEditingController(text: widget.data!.kontak);
  }

  @override
  void dispose() {
    _nama.dispose();
    _alamat.dispose();
    _kontak.dispose();
    _jeniskelamin.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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
                                'alamat',
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
                            TextFormField(
                              controller: _jeniskelamin,
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
                    Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                    Row(
                      children: [
                        Expanded(
                          child: customButton(
                              press: () {
                                Navigator.pop(context);
                              },
                              title: "Kembali",
                              color: Colors.white,
                              textcolor: Colors.black,
                              link: ""),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
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
// import 'package:londreeapp/view/component/bottom_navbar.dart';
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

// class detailMember extends StatefulWidget {
//   final Map<String, dynamic>? data;

//   detailMember({Key? key, this.data}) : super(key: key);

//   @override
//   State<detailMember> createState() => _detailMemberState();
// }

// class _detailMemberState extends State<detailMember> {
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

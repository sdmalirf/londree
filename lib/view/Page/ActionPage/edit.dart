import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/view/Page/information.dart';
import 'package:londreeapp/view/component/bottom_navbar.dart';
import 'package:londreeapp/view/component/custom_button.dart';

class editInput extends StatelessWidget {
  final String? hint;
  final String? value;
  TextEditingController? controller;

  editInput({super.key, this.hint, this.value, this.controller});

  Map<String, dynamic>? data;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          suffixIcon: Container(
              padding: EdgeInsets.all(10),
              child: SvgPicture.asset(
                "assets/images/pencil-icon.svg",
              )),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.black)),
    );
  }
}

class EditPage extends StatefulWidget {
  final Map<String, dynamic>? data;

  EditPage({Key? key, this.data}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController namaController;

  late TextEditingController alamatController;

  late TextEditingController jenisKelaminController;

  late TextEditingController nomorTeleponController;

  @override
  void initState() {
    super.initState();

    // inisialisasi controller dengan data yang diberikan
    namaController = TextEditingController(text: widget.data!['nama']);
    alamatController = TextEditingController(text: widget.data!['alamat']);
    jenisKelaminController =
        TextEditingController(text: widget.data!['jenisKelamin']);
    nomorTeleponController =
        TextEditingController(text: widget.data!['nomorTelepon']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edit"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: editInput(controller: namaController)),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                  SvgPicture.asset(
                    "assets/images/people-icon.svg",
                    width: 60,
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 12, top: 50),
                child: Text(
                  "Alamat",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              editInput(
                controller: alamatController,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 12, top: 30),
                child: Text(
                  "Jenis Kelamin",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              editInput(),
              Container(
                margin: EdgeInsets.only(bottom: 12, top: 30),
                child: Text(
                  "Nomor Telepon",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              editInput(),
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
                        link: ""),
                  )
                ],
              )
            ],
          )),
          ElevatedButton(
              onPressed: () {
                print(widget.data);
              },
              child: Text("test")),
          Text("${widget.data!['nama']}"),
        ],
      ),
    );
  }
}

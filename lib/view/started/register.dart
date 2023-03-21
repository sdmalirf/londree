import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/controller/auth.dart';
import 'package:londreeapp/view/Page/home.dart';
import 'package:londreeapp/view/component/custom_button.dart';
import 'package:londreeapp/view/component/text_input.dart';
import 'package:londreeapp/view/started/started.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  AuthController _auth = AuthController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _auth.signUp(context, _email, _password);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => started(),
          )); // call the signUp() method
    } else {
      print("gagal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Daftar",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/images/left-arrow-icon.svg")),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Image.asset("assets/images/login-image.png"),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextInputCustom(
                    onSave: (value) {
                      _email = value!;
                    },
                    hint: "Masukan Email Aktif",
                    title: "Email",
                    obscure: false,
                  ),
                  TextInputCustom(
                    hint: "Masukan Alamat Rumahmu",
                    title: "Alamat",
                    obscure: false,
                  ),
                  TextInputCustom(
                    hint: "Masukan Nomor Aktif",
                    title: "Nomor Telepon",
                    obscure: false,
                  ),
                  TextInputCustom(
                    hint: "Masukan Sandi",
                    title: "Kata Sandi",
                    obscure: true,
                    onSave: (value) {
                      _password = value!;
                    },
                  ),
                  TextInputCustom(
                    onSave: (value) {
                      _confirmPassword = value!;
                    },
                    hint: "Konfirmasi Sandi",
                    title: "Konfirmasi Kata Sandi",
                    obscure: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: customButton(
                      press: _submit,
                      title: "Daftar",
                      color: Colors.blue,
                      textcolor: Colors.white,
                    ),
                  )
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sudah punya akun?",
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => home()));
                  },
                  child: Text(
                    "Masuk",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  )),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 40))
        ],
      ),
    );
  }
}

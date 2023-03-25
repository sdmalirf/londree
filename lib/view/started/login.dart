import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/view/Page/home.dart';
import 'package:londreeapp/view/component/bottom_navbar.dart';
import 'package:londreeapp/view/component/custom_button.dart';
import 'package:londreeapp/view/component/text_input.dart';
import 'package:londreeapp/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class login extends ConsumerStatefulWidget {
  login({super.key});

  @override
  ConsumerState<login> createState() => _loginState();
}

class _loginState extends ConsumerState<login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool passenable = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Masuk",
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
                  Container(
                    child: TextInputCustom(
                      controller: _email,
                      hint: "sadamalirafsanjani@gmail.com",
                      title: "Masukan Email",
                      obscure: false,
                    ),
                  ),
                  Container(
                      child: TextInputCustom(
                    controller: _password,
                    hint: "Password",
                    title: "Masukan Sandi",
                    obscure: passenable,
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: TextButton(
                          onPressed: () {},
                          child: Text("Lupa Kata Sandi?"),
                          style: ButtonStyle(alignment: Alignment.centerLeft),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: customButton(
                      title: "Masuk",
                      color: Colors.blue,
                      textcolor: Colors.white,
                      press: () async {
                        if (_formKey.currentState!.validate()) {
                          await ref
                              .read(authControllerProvider.notifier)
                              .signIn(context, _email.text, _password.text);

                          _password.clear();
                          setState(() {});
                          if (!mounted) return;
                        }
                      },
                    ),
                  )
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Belum punya akun?",
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Daftar",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

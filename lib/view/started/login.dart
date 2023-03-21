import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/view/Page/home.dart';
import 'package:londreeapp/view/component/bottom_navbar.dart';
import 'package:londreeapp/view/component/custom_button.dart';
import 'package:londreeapp/view/component/text_input.dart';
import 'package:londreeapp/controller/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatefulWidget {
  login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthController _auth = AuthController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        _formKey.currentState!.save();
        _auth.signIn(context, _emailController, _passwordController);
        // call the signUp()
        // UserCredential userCredential = await _authController.signIn(
        //     _emailController.text, _passwordController.text);
        // print('Signed in as: ${userCredential.user!.email}');
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => bottomNavbar(),
        //     ));
        // } on FirebaseAuthException catch (e) {
        //   if (e.code == 'user-not-found') {
        //     print('No user found for that email.');
        //   } else if (e.code == 'wrong-password') {
        //     print('Wrong password provided for that user.');
        //   }
        //   ScaffoldMessenger.of(context)
        //       .showSnackBar(SnackBar(content: Text('Login failed: $e')));
        // } catch (e) {
        //   ScaffoldMessenger.of(context)
        //       .showSnackBar(SnackBar(content: Text('Login failed: $e')));
      } finally {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => bottomNavbar(),
              ));
        });
      }
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
                      controller: _emailController,
                      hint: "sadamalirafsanjani@gmail.com",
                      title: "Masukan Email",
                      obscure: false,
                    ),
                  ),
                  Container(
                      child: TextInputCustom(
                    controller: _passwordController,
                    hint: "Password",
                    title: "Masukan Sandi",
                    obscure: true,
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
                      press: _submitForm,
                      // press: () async {
                      //   await _authController.signIn(context);
                      // },

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => home(),
                      //     ));
                      // if (FirebaseAuth.instance.currentUser != null) {
                      //   print(login());
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => home(),
                      //       ));
                      // } else {
                      //   print("object");
                      // }
                      // ;
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

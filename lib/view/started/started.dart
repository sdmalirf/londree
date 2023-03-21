import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/controller/table_controller.dart';
import 'package:londreeapp/view/component/custom_button.dart';
import 'package:londreeapp/view/component/hero_container.dart';
import 'package:londreeapp/view/started/login.dart';
import 'package:londreeapp/view/started/register.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class started extends StatefulWidget {
  const started({super.key});

  @override
  State<started> createState() => _startedState();
}

class _startedState extends State<started> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  @override
  Widget build(BuildContext context) {
    final pages = List.generate(6, (index) => const heroContainer());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Container(
            padding: const EdgeInsets.only(top: 100),
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 290,
                    child: PageView.builder(
                      controller: controller,
                      itemBuilder: (_, index) {
                        return pages[index % pages.length];
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 12),
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: pages.length,
                    effect: const ExpandingDotsEffect(
                        dotHeight: 10, dotWidth: 10, expansionFactor: 3),
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 50)),
          ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
                backgroundColor: MaterialStatePropertyAll(Colors.white),
                elevation: MaterialStatePropertyAll(0),
                side: MaterialStatePropertyAll(BorderSide(
                  width: 2,
                  color: Colors.black12,
                ))),
            onPressed: () {
              final transtable = FirebaseFirestore.instance
                  .collection('transaction')
                  .get()
                  .then((QuerySnapshot querySnapshot) {
                querySnapshot.docs.forEach((doc) {
                  print(doc['nama']);
                });
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/google-logo.svg"),
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                  ),
                  const Text(
                    "Lanjutkan Dengan Google",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 30)),
              Expanded(
                  child: Divider(
                thickness: 2,
              )),
              Container(
                margin: EdgeInsets.only(right: 15),
              ),
              Text(
                "Atau",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black38),
              ),
              Container(
                margin: EdgeInsets.only(right: 15),
              ),
              Expanded(
                  child: Divider(
                thickness: 2,
              )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: customButton(
                  title: "Masuk",
                  color: Colors.white,
                  textcolor: Colors.black,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => login(),
                        ));
                  },
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              Expanded(
                child: customButton(
                  title: "Daftar",
                  color: Colors.blue,
                  textcolor: Colors.white,
                  press: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => register(),
                        ));
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/view/component/custom_button.dart';
import 'package:londreeapp/view/component/text_input.dart';

class customButtonProfile extends StatelessWidget {
  final String title;
  final color;
  final textcolor;
  final link;
  final String? icon;

  customButtonProfile(
      {super.key,
      required this.title,
      required this.color,
      required this.textcolor,
      required this.link,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawMaterialButton(
        fillColor: color,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => link,
              ));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: SvgPicture.asset(icon!)),
              Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                      color: textcolor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sadam Ali Rafsanjani",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 23,
                        color: Colors.black54),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  Text(
                    "Admin",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black38),
                  )
                ],
              ),
              SvgPicture.asset(
                "assets/images/people-icon.svg",
                width: 70,
              )
            ],
          ),
          TextInputCustom(title: "Username"),
          TextInputCustom(title: "Email"),
          TextInputCustom(title: "Alamat"),
          TextInputCustom(title: "Nomor Telepon"),
          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Row(
            children: [
              customButtonProfile(
                title: "Ubah Data",
                color: Colors.white,
                textcolor: Colors.black,
                link: "",
                icon: "assets/images/form-icon.svg",
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
              customButtonProfile(
                title: "Ubah Password",
                color: Colors.white,
                textcolor: Colors.black,
                link: "",
                icon: "assets/images/password-icon.svg",
              )
            ],
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
                "Londree",
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
            children: [
              customButtonProfile(
                title: "Keluar",
                color: Colors.red,
                textcolor: Colors.white,
                link: "",
                icon: "assets/images/logout-icon.svg",
              ),
            ],
          )
        ],
      ),
    );
  }
}

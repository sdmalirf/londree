import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:londreeapp/view/Page/home.dart';
import 'package:londreeapp/view/Page/information.dart';
import 'package:londreeapp/view/Page/navbar/admin/admin_home.dart';
import 'package:londreeapp/view/Page/navbar/admin/admin_information.dart';
import 'package:londreeapp/view/Page/navbar/admin/transaction.dart';
import 'package:londreeapp/view/Page/profile.dart';
import 'package:londreeapp/view/Page/transactions/transaction.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class adminNavbar extends StatefulWidget {
  const adminNavbar({super.key});

  @override
  State<adminNavbar> createState() => _adminNavbarState();
}

class _adminNavbarState extends State<adminNavbar> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      adminHome(),
      adminInformation(),
      adminTransactionPage(),
      profilePage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/images/home-icon.svg"),
        title: ("Home"),
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/images/add-icon.svg"),
        title: ("Informasi"),
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/images/history-icon-bar.svg"),
        title: ("Transaksi"),
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/images/people-icon-bar.svg"),
        title: ("Profil"),
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: Colors.white,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreen(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style1,
    );
  }
}

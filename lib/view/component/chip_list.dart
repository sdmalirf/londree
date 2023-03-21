import 'package:flutter/material.dart';
import 'package:chip_list/chip_list.dart';

class chipList extends StatefulWidget {
  const chipList({super.key});

  @override
  State<chipList> createState() => _chipListState();
}

class _chipListState extends State<chipList> {
  @override
  Widget build(BuildContext context) {
    final List<String> _dogeNames = [
      'Transaksi',
      'Pelanggan',
      'Cabang',
      'Paket'
    ];

    int _currentIndex = 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Basic usage

        ChipList(
          padding: EdgeInsets.symmetric(horizontal: 5),
          widgetSpacing: 3,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          listOfChipNames: _dogeNames,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          borderRadiiList: [8],
          activeBgColorList: [Colors.white],
          inactiveBorderColorList: [Color.fromARGB(255, 164, 164, 164)],
          activeBorderColorList: [Theme.of(context).primaryColor],
          inactiveBgColorList: [Colors.white],
          activeTextColorList: [Theme.of(context).primaryColor],
          inactiveTextColorList: [Colors.black],
          listOfChipIndicesCurrentlySeclected: [0],
        ),
      ],
    );
  }
}

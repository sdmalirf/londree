import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:londreeapp/controller/auth_controller.dart';
import 'package:londreeapp/controller/log_history.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:londreeapp/model/logHistory.dart';
import 'package:londreeapp/view/component/snackbar.dart';

class logPage extends ConsumerStatefulWidget {
  const logPage({super.key});

  @override
  ConsumerState<logPage> createState() => _logPageState();
}

class _logPageState extends ConsumerState<logPage> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getAllLog();
  }

  int? selectedIndex;

  Future<void> getAllLog() async {
    final users = ref.watch(authControllerProvider);
    await ref
        .read(logHistoryControllerProvider.notifier)
        .getLog(email: users.email);
  }

  @override
  Widget build(BuildContext context) {
    final logResult = ref.watch(logHistoryControllerProvider);
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            foregroundColor: Colors.blue,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            label: Text(
              "Hapus",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
            icon: SvgPicture.asset("assets/images/delete-icon.svg"),
            onPressed: () {
              // () async {
              //   try {
              //     await ref
              //         .read(logHistoryControllerProvider.notifier)
              //         .deleteLog(context: context);
              //     setState(() {});
              //     if (!mounted) {
              //       return;
              //     }
              //     Snackbars().successSnackbars(
              //         context, 'Berhasil', 'Berhasil Menghapus Data');
              //   } on FirebaseException catch (e) {
              //     Snackbars()
              //         .failedSnackbars(context, 'gagal', e.message.toString());
              //   }
              // };
            }),
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: ListView.builder(
              itemCount: logResult.length,
              itemBuilder: ((context, index) {
                return MaterialButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Card(
                      color: Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20.0,
                                width: 320,
                              ),
                              Text(
                                logResult[index].email.toString(),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                logResult[index].aktivitas.toString(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Text(
                                logResult[index].tgl.toString(),
                                style: TextStyle(
                                    color: selectedIndex == index
                                        ? Colors.blue
                                        : null,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 16.0),
                            ],
                          ))),
                );
              })),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:londreeapp/view/Page/auth/splash.dart';
import 'package:firebase_core/firebase_core.dart';

// Import the generated file
import 'firebase_options.dart';

void main() async {
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //   builder: (context, snapshot) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: splachScreen());
    //   },
    // );
  }
}

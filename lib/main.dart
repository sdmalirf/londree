import 'package:flutter/material.dart';
import 'package:londreeapp/view/started/splash.dart';
import 'package:firebase_core/firebase_core.dart';
// Import the generated file
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(App());
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

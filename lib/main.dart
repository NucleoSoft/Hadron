import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hadron_ide/screens/home.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    var initialSize = Size(900, 650);
    appWindow.size = initialSize;
    appWindow.minSize = initialSize;
    appWindow.title = 'Hadron';
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
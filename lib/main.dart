import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final String _title = "Scaffold +";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        fontFamily: 'ClashDisplay',
      ),
      home: const WelcomeScreen(),
    );
  }
}


// Github page https://github.com/hafidikhsan/app-regresi-linear-flutter
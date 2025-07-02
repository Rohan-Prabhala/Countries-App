import 'package:flutter/material.dart';
import 'package:mvmm_test/ui/home/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      title: 'MVVM Test App',
      home: HomeScreen(),
    );
  }
}

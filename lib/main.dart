// main.dart
import 'package:flutter/material.dart';
import 'package:railway/presentation/ui/onBoarding/onboard_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Railway App',
      home: OnBoarding(),
    );
  }
}

import 'package:flutter/material.dart';
import '01_input_page.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BMIInputPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

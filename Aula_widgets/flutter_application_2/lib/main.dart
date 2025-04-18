// Flutter and Dart

import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  //runApp(const MyApp());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Exploring Widgets")),
        body: myWidget(),
      ),
    );
  }
}

//Widget myWidget() {
//return Center(
//
//  child: Text("Hello world! - Olá mundo!", style: TextStyle(fontSize: 30)),
//);
//return Padding(padding: EdgeInsets.all(16.0), child: Text("Olá, Flutter!"));
//}

//Widget myWidget() {
//  return ElevatedButton(
//    onPressed: () {
//      // Ação quando o botão for pressionado
//    },
//    style: ElevatedButton.styleFrom(
//      backgroundColor: Colors.blue, // Substitui "color"
//      elevation: 4.0, // Substitui "altitude"
//      splashFactory: InkSplash.splashFactory, // Alternativa ao splashColor
//    ),
//    child: const Text('Button'),
//  );
//}

Widget myWidget() {
  return TextField(
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Escreva algo aqui',
    ),
  );
}

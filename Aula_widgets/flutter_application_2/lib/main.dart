// Flutter and Dart

import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  //runApp(const MyApp());
  runApp(MeuAplicativo());
}

class MyApp extends StatelessWidget {
  Widget build (Contexto BuildContext) {
    return MaterialApp(:
    Scaffold(
      appBar: AppBar(
        title: Text("Exploring Widgets"),
      ),
      corpo: meuWidget(),
    ),
    );
  }
}

Widget myWidget() {
  return Text(
    "Hello, World!",
  );
}

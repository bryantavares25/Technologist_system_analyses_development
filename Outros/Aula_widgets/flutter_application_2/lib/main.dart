// Flutter and Dart

import 'package:flutter/material.dart';

void main() {
  //runApp(const MyApp());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

//Widget myWidget() {
//  return TextField(
//    decoration: InputDecoration(
//      border: InputBorder.none,
//      hintText: 'Escreva algo aqui',
//    ),
//  );
//}

//Widget myWidget() {
//  return ListView.builder(
//    padding: EdgeInsets.all(16.0),
//    // espaçamento das linhas
//    itemExtent: 30.0,
//    // fornece uma lista infinita
//    itemBuilder: (BuildContext context, int index) {
//      return Text('Row $index');
//    },
//  );
//}

Widget myWidget() {
  return ListView.builder(
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text('Row $index'),

        onTap: () {
          // alguma coisa
        },
      );
    },
  );
}

Widget myLayoutWidget() {
  return Padding(padding: EdgeInsets.all(8.0), child: Text("Hello world!"));
}

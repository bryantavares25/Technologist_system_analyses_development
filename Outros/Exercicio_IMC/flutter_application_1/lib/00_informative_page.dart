import 'package:flutter/material.dart';

class IMCgrupos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return: Scaffold(
      appBar: AppBar(title: Text("Categorias do Índice de Massa Corporal")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            categoryText(" Menor de 18,5", "Subpeso."),
            categoryText("Entre 18,5 e 25", "Adequado."),
            categoryText("Entre 25 e 30", "Sobrepeso"),
            categoryText("Maior de 30", "Obesidade"),
          ],
        ),
      ),
    ),
  };
}

Widget categoryText(String range, String description) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 20, color: Colors.black),
          children: [
            TextSpan(text: "$range\n", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: description),)
          ],
        ),
      ),
    );
  }
}
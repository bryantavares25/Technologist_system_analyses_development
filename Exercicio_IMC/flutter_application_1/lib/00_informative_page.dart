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
        )
      )
    )
  }
}

class 
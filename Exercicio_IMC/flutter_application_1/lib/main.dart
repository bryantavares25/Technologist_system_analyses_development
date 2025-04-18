import 'package:flutter/material.dart';

void main() => runApp(IMCApp());

class IMCApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo de IMC',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: IMCCalculator(),
    );
  }
}

// CLASSE | WIDGET | StatefulWidget
class IMCCalculator extends StatefulWidget {
  @override
  _IMCCalculatorState createState() => _IMCCalculatorState();
}

// CLASSE | WIDGET | State<IMCCalculator
class _IMCCalculatorState extends State<IMCCalculator> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  String resultado = '';

  void calcularIMC() {
    double? peso = double.tryParse(pesoController.text);
    double? altura = double.tryParse(alturaController.text);

    if (peso == null || altura == null || altura == 0) {
      setState(() {
        resultado = 'Por favor, insira valores válidos.';
      });
      return;
    }

    double imc = peso / (altura * altura);

    setState(() {
      resultado = 'Seu IMC é: ${imc.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculadora de IMC')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: pesoController,
              decoration: InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: alturaController,
              decoration: InputDecoration(labelText: 'Altura (m)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: calcularIMC, child: Text('Calcular')),
            SizedBox(height: 20),
            Text(
              resultado,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

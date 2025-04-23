import 'package:flutter/material.dart';
import 'bmi_input_page.dart';
import 'bmi_info_page.dart';

class BMIResultPage extends StatelessWidget {
  final String gender;
  final double weight;
  final double height;
  final double bmi;
  final String status;

  BMIResultPage({
    required this.gender,
    required this.weight,
    required this.height,
    required this.bmi,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your body"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BMIInfoPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your BMI", style: TextStyle(fontSize: 22)),
            Text(
              "$bmi",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text(status, style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Calculate BMI again"),
            ),
          ],
        ),
      ),
    );
  }
}

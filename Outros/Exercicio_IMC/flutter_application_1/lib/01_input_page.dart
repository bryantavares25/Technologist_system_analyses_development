import 'package:flutter/material.dart';
import '03_output_page.dart';
import '02_calculator_page.dart';

class IMCInputPage extends StatefulWidget {
  @override
  _IMCInputPage createState() => _IMCInputPageState();
}

class __IMCInputPageState extends State<IMCInputPage> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  String selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                genderButton("Male"),
                SizedBox(width: 20),
                genderButton("Female"),
              ],
            ),
            SizedBox(height: 20),
            inputField("Your weight (kg)", weightController),
            inputField("Your height (cm)", heightController),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Calculate your BMI"),
              onPressed: () {
                final weight = double.tryParse(weightController.text);
                final height = double.tryParse(heightController.text);

                if (weight != null && height != null && height > 0) {
                  final result = calculateBMI(weight, height);
                  final status = interpretBMI(result);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => BMIResultPage(
                            gender: selectedGender,
                            weight: weight,
                            height: height,
                            bmi: result,
                            status: status,
                          ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter valid numbers")),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget genderButton(String gender) {
    final isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () => setState(() => selectedGender = gender),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
            child: Text(
              gender == "Male" ? "👨" : "👩",
              style: TextStyle(fontSize: 40),
            ),
          ),
          Text(gender),
        ],
      ),
    );
  }

  Widget inputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

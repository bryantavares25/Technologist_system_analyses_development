import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  String? _selectedGender;
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double? _bmiResult;

  void _calculateBMI() {
    final double? weight = double.tryParse(_weightController.text);
    final double? heightCm = double.tryParse(_heightController.text);
    if (weight != null && heightCm != null && heightCm > 0) {
      final double heightM = heightCm / 100;
      setState(() {
        _bmiResult = weight / (heightM * heightM);
      });
    } else {
      setState(() {
        _bmiResult = null;
      });
    }
  }
  String _selectedGender = 'Male';
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  final FocusNode _weightFocusNode = FocusNode();
  final FocusNode _heightFocusNode = FocusNode();

  double? _bmiResult;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _weightFocusNode.dispose();
    _heightFocusNode.dispose();
    super.dispose();
  }
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Navega para a tela de categorias
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const BMICategoriesScreen()));
            },
          ),
        ],
      ),
      body: Column(
        // Um Column para empilhar o conteúdo principal e o teclado
        children: [
          Expanded(
            // Ocupa o espaço restante acima do teclado
            child: SingleChildScrollView(
              // Permite que a parte superior role se o conteúdo for grande
              padding: const EdgeInsets.all(20.0),
              child: Column(
                // Coluna para organizar os elementos verticais
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Your body',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    // Linha para a seleção de gênero (Male/Female)
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Widget para seleção de gênero (Exemplo)
                      _buildGenderSelection(
                        'Male',
                        'https://placehold.co/80x80/cccccc/000000?text=Male',
                      _buildInputCard(
                        'Your weight (kg)',
                        TextEditingController(),
                        _weightFocusNode,
                      ),
                  Row(
                    // Linha para a seleção de gênero (Male/Female)
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Widget para seleção de gênero (Exemplo)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedGender = 'Male';
                          });
                        },
                        child: _buildGenderSelection(
                          'Male',
                          'https://placehold.co/80x80/cccccc/000000?text=Male',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedGender = 'Female';
                          });
                        },
                        child: _buildGenderSelection(
                          'Female',
                          'https://placehold.co/80x80/cccccc/000000?text=Female',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInputCard(
                        'Your weight (kg)',
                        _weightController,
                        _weightFocusNode,
                      ),
                      _buildInputCard(
                        'Your height (cm)',
                        _heightController,
                        _heightFocusNode,
                      ),
                    ],
                  ),
            ),
          ),
          // Teclado numérico customizado fixo na parte inferior
          Container(
                      // Botão "Calculate your BMI"
                      onPressed: () {
                        _calculateAndShowBMI(context);
                      },
                      child: const Text('Calculate your BMI'),
                topRight: Radius.circular(20),
              ),
            ),
            child: _buildNumberPad(), // Este seria o seu widget para o teclado
          ),
        ],
      ),
    );
  }

  // --- Funções de construção de widgets (exemplo, para ilustrar a estrutura) ---
  Widget _buildGenderSelection(String gender, String imagePath) {
    // Implementação simplificada do widget de seleção de gênero
    return Column(
      children: [
        CircleAvatar(radius: 40, backgroundImage: NetworkImage(imagePath)),
        Text(gender),
      ],
    );
  }

  Widget _buildInputCard(
    String label,
  // --- Funções de construção de widgets (exemplo, para ilustrar a estrutura) ---

  void _calculateAndShowBMI(BuildContext context) {
    final double? weight = double.tryParse(_weightController.text);
    final double? heightCm = double.tryParse(_heightController.text);

    if (weight == null || heightCm == null || heightCm == 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please enter valid numbers for weight and height.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final double heightM = heightCm / 100;
    final double bmi = weight / (heightM * heightM);

    String category;
    if (bmi < 18.5) {
      category = 'Underweight';
    } else if (bmi < 25) {
      category = 'Normal weight';
    } else if (bmi < 30) {
      category = 'Overweight';
    } else {
      category = 'Obesity';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your BMI Result'),
        content: Text('BMI: ${bmi.toStringAsFixed(1)}\nCategory: $category'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelection(String gender, String imagePath) {
    // Implementação simplificada do widget de seleção de gênero
    return Column(
      children: [
        CircleAvatar(radius: 40, backgroundImage: NetworkImage(imagePath)),
        Text(
          gender,
          style: TextStyle(
            fontWeight: _selectedGender == gender ? FontWeight.bold : FontWeight.normal,
            color: _selectedGender == gender ? Colors.blue : Colors.black,
          ),
        ),
      ],
    );
  }
            focusNode: focusNode,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNumberPad() {
    // Estrutura simplificada do teclado numérico
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: ElevatedButton(onPressed: () {}, child: Text('1'))),
          ],
        ),
        // ... mais linhas de botões
      ],
    );
  }
}

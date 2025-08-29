import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  // ... (Variáveis de estado e métodos de lógica, como _selectedGender, _weightController, _calculateBMI, etc.) ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            /* Ação de voltar */
          },
        ),
        title: const Text('BMI Calculator'),
        centerTitle: true,
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
                      ),
                      _buildGenderSelection(
                        'Female',
                        'https://placehold.co/80x80/cccccc/000000?text=Female',
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    // Linha para os campos de entrada (Peso/Altura)
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Widget para campo de entrada (Exemplo)
                      _buildInputCard(
                        'Your weight (kg)',
                        TextEditingController(),
                        FocusNode(),
                      ),
                      _buildInputCard(
                        'Your height (cm)',
                        TextEditingController(),
                        FocusNode(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      // Botão "Calculate your BMI"
                      onPressed: () {
                        /* Lógica para calcular o IMC */
                      },
                      child: const Text('Calculate your BMI'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Teclado numérico customizado fixo na parte inferior
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
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
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    // Implementação simplificada do widget de campo de entrada
    return Expanded(
      child: Column(
        children: [
          Text(label),
          TextField(
            controller: controller,
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

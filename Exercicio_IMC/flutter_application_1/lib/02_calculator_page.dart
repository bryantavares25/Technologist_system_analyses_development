// Cálculo de IMC

double IMCcalc(double mass, double height) {
  return double.parse((mass / (height * height)).toStringAsFixed(1));
}

String IMCresult(double imc) {
  if (imc < 18.5) return "Sobpeso";
  if (imc < 25) return "Normal";
  if (imc < 30) return "Sobrepeso";
  return "Obesidade";
}

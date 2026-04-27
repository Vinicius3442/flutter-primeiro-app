import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraRealistaApp());
}

class CalculadoraRealistaApp extends StatelessWidget {
  const CalculadoraRealistaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Realista',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Cores da "carcaça" da calculadora
        scaffoldBackgroundColor: const Color(0xFF1A1D21), // Preto/Cinza escuro
      ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  // Lógica simples da calculadora
  String visorText = "0";
  double? num1;
  double? num2;
  String operacao = "";
  bool novoNumero = true;

  // Função para lidar com cliques nos botões
  void cliqueBotao(String text) {
    setState(() {
      if (text == "AC") {
        visorText = "0";
        num1 = null;
        num2 = null;
        operacao = "";
        novoNumero = true;
      } else if (text == "+/-") {
        if (visorText != "0" && visorText != "Erro") {
          double val = double.parse(visorText.replaceAll(',', '.'));
          visorText = (val * -1).toString().replaceAll('.', ',');
        }
      } else if (text == "%") {
        if (visorText != "Erro") {
          double val = double.parse(visorText.replaceAll(',', '.'));
          visorText = (val / 100).toString().replaceAll('.', ',');
        }
      } else if (text == "+" || text == "-" || text == "×" || text == "÷") {
        // Salva o primeiro número e a operação
        if (visorText != "Erro") {
          num1 = double.parse(visorText.replaceAll(',', '.'));
          operacao = text;
          novoNumero = true;
        }
      } else if (text == "=") {
        if (operacao != "" && num1 != null && visorText != "Erro") {
          num2 = double.parse(visorText.replaceAll(',', '.'));
          double? resultado;

          if (operacao == "+") {
            resultado = num1! + num2!;
          } else if (operacao == "-") {
            resultado = num1! - num2!;
          } else if (operacao == "×") {
            resultado = num1! * num2!;
          } else if (operacao == "÷") {
            if (num2 == 0) {
              visorText = "Erro";
            } else {
              resultado = num1! / num2!;
            }
          }

          if (resultado != null) {
            // Formata o resultado (remove .0 e limita casas)
            String resStr = resultado.toStringAsFixed(resultado == resultado.roundToDouble() ? 0 : 8);
            if (resStr.contains('.')) {
              while (resStr.endsWith('0')) {
                resStr = resStr.substring(0, resStr.length - 1);
              }
              if (resStr.endsWith('.')) {
                resStr = resStr.substring(0, resStr.length - 1);
              }
            }
            
            // Limita tamanho para não estourar o visor realista
            if (resStr.length > 12) {
              visorText = resultado.toStringAsExponential(5);
            } else {
              visorText = resStr.replaceAll('.', ',');
            }
          }
          num1 = null;
          operacao = "";
          novoNumero = true;
        }
      } else {
        // Tratamento de números e vírgula
        if (novoNumero || visorText == "0" || visorText == "Erro") {
          if (text == ",") {
            visorText = "0,";
          } else {
            visorText = text;
          }
          novoNumero = false;
        } else {
          // Limite realista de dígitos no visor
          if (visorText.replaceAll(',', '').length < 12) {
            if (text == ",") {
              if (!visorText.contains(',')) {
                visorText += ",";
              }
            } else {
              visorText += text;
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Cores específicas para realismo
    const colorCarcaca = Color(0xFF1E2125);
    const colorVisorBorda = Color(0xFF32363D);
    const colorVisorBackground = Color(0xFFA5C1A7); // Verde LCD
    const colorVisorText = Color(0xFF2A2A2A); // Preto/Verde escuro do LCD
    const colorButtonOperator = Color(0xFF5D70E9); // Azul para operadores
    const colorButtonNumber = Color(0xFFE5E7EB); // Cinza claro para números

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // 1. Visor Realista
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: colorVisorBorda,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black38, width: 2),
                ),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: colorVisorBackground,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(2, 2),
                          blurRadius: 2),
                      BoxShadow(
                          color: Colors.white24,
                          offset: Offset(-1, -1),
                          blurRadius: 1),
                    ],
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      visorText,
                      style: const TextStyle(
                        fontFamily: 'Courier', // Fonte mono para lembrar LCD
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: colorVisorText,
                        letterSpacing: -2,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 2. Teclado de Botões
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.1,
                  children: [
                    // Linha 1
                    buildButton("AC", color: Colors.redAccent),
                    buildButton("+/-", color: colorVisorBorda),
                    buildButton("%", color: colorVisorBorda),
                    buildButton("÷", color: colorButtonOperator),
                    // Linha 2
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("×", color: colorButtonOperator),
                    // Linha 3
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("-", color: colorButtonOperator),
                    // Linha 4
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("+", color: colorButtonOperator),
                    // Linha 5
                    buildButton("0", color: colorButtonNumber),
                    buildButton(",", color: colorButtonNumber),
                    buildButton("=", color: colorButtonOperator, spans2Cols: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget utilitário para criar botões consistentes
  Widget buildButton(String text,
      {Color color = const Color(0xFFE5E7EB), bool spans2Cols = false}) {
    bool isOperator =
        text == "+" || text == "-" || text == "×" || text == "÷" || text == "=";
    Color textColor = isOperator || color == Colors.redAccent
        ? Colors.white
        : const Color(0xFF1E2125);
    Color backgroundColor = color;

    return GestureDetector(
      onTap: () => cliqueBotao(text),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(3, 3),
              blurRadius: 3,
            ),
            BoxShadow(
              color: Colors.white38,
              offset: Offset(-1, -1),
              blurRadius: 1,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: isOperator ? 36 : 30,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
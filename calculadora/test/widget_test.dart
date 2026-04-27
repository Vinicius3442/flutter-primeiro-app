import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora/main.dart'; // TROQUE 'seu_projeto_nome' pelo nome do seu projeto

void main() {
  testWidgets('Teste de clique na calculadora realista', (WidgetTester tester) async {
    // Carrega o app com o nome da classe nova
    await tester.pumpWidget(const CalculadoraRealistaApp());

    // Verifica se o visor começa com "0"
    expect(find.text('0'), findsOneWidget);

    // Clica no botão "7"
    // Como usamos GestureDetector, procuramos pelo texto do botão
    await tester.tap(find.text('7'));
    await tester.pump(); // Atualiza o frame

    // Verifica se o "7" apareceu no visor
    // (O findsNWidgets(2) é porque o "7" aparece no botão E no visor)
    expect(find.text('7'), findsNWidgets(2));
    
    // Clica no AC para limpar
    await tester.tap(find.text('AC'));
    await tester.pump();

    // Volta a ser 0
    expect(find.text('0'), findsOneWidget);
  });
}
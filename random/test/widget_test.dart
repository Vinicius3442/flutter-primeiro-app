import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random/main.dart';

void main() {
  testWidgets('Teste do Sorteador', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verifica se começa com 0
    expect(find.text('0'), findsOneWidget);

    // Clica no botão
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verifica se o texto "0" sumiu (já que sorteou um número de 1 a 100)
    expect(find.text('0'), findsNothing);
  });
}
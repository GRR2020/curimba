
import 'package:curimba/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Home Widget', () {
    testWidgets('should correctly render components', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Home(),
      ));

      expect(find.text('CADASTRAR CARTÃO'), findsOneWidget);
      expect(find.text('LISTAR CARTÕES'), findsOneWidget);
      expect(find.text('CARTÕES RECOMENDADOS'), findsOneWidget);
      expect(find.text('SAIR'), findsOneWidget);
    });
  });
}
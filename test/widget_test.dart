import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:irth/main.dart';

void main() {
  testWidgets('App boots on the Roots tab', (WidgetTester tester) async {
    await tester.pumpWidget(const IrthApp());

    expect(find.text('Roots'), findsWidgets);
    expect(find.text('Record'), findsOneWidget);
  });

  testWidgets('Bottom nav switches to Bonds and Branches', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const IrthApp());

    await tester.tap(find.text('Bonds'));
    await tester.pumpAndSettle();
    expect(find.text('Bonds'), findsWidgets);

    await tester.tap(find.text('Branches'));
    await tester.pumpAndSettle();
    expect(find.text('Branches'), findsWidgets);
  });

  testWidgets('recording a story populates the tree and the play round', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const IrthApp());

    await tester.tap(find.byIcon(Icons.mic_rounded));
    await tester.pump();
    expect(find.byIcon(Icons.stop_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.stop_rounded));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text('The house in Al Ain'), findsWidgets);
    expect(find.textContaining('Saif'), findsWidgets);

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tree'));
    await tester.pumpAndSettle();
    expect(find.text('Jeddo Rashid'), findsOneWidget);
    expect(find.text('Saif'), findsOneWidget);

    await tester.tap(find.text('Play'));
    await tester.pumpAndSettle();
    expect(
      find.text('Who built the majlis room in the Al Ain house?'),
      findsOneWidget,
    );
  });
}

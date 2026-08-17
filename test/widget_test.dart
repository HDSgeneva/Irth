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
}

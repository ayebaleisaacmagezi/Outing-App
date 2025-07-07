// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lib/main.dart';

void main() {
  testWidgets('App starts and displays home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // We can test with the OutingApp widget directly.
    await tester.pumpWidget(const OutingApp());

    // Verify that our app's main container (Scaffold) is present.
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
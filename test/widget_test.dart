// test/widget_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:outing_app/main.dart'; // Use your actual project name from pubspec.yaml

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // This is a basic test to ensure the app can be built without crashing.
    // Build our app and trigger a frame.
    await tester.pumpWidget(const OutingApp());

    // You can add simple verification here if you want,
    // but for now, just building it is enough to clear the errors.
    // For example, verify that the initial screen shows up.
    expect(find.text('Welcome Back'), findsOneWidget);
  });
}
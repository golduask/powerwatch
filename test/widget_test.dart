import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:powerwatch/main.dart';

void main() {
  testWidgets('PowerWatch app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PowerWatchApp());

    // Verify that the login page is displayed initially
    expect(find.text('PowerWatch'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Don\'t have an account? Sign Up'), findsOneWidget);
  });
}


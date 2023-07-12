// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:emag_scanner/main.dart';
import 'package:emag_scanner/pages/settings_page.dart';

void main() {
  testWidgets('Main app / home screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ScanApp());

    // Verify the UI
    // Finds the Settings action button to tap on.
    final Finder settingsBtn = find.byIcon(Icons.settings);
    expect(settingsBtn, findsOneWidget);

    // Emulate a tap on the settings button.
    await tester.tap(settingsBtn);
    await tester.pumpAndSettle();
    // Verify that a push event happened
    // Verify SettingsPage is now shown
    expect(find.byType(SettingsPage), findsOneWidget);

    // // 'Scan for access'
    // final Finder accessBtn = find.text('Scan for access');
    // expect(accessBtn, findsOneWidget);
    // // 'Scan for registration'
    // final Finder registrationBtn = find.text('Scan for registration');
    // expect(registrationBtn, findsOneWidget);
  });
}

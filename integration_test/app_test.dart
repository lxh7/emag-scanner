// ignore_for_file: avoid_print

import 'dart:io';

import 'package:emag_scanner/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:emag_scanner/main.dart' as app;


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('navigation test', () {
    testWidgets('main page', (tester) async {
      print(Directory.current.path);
      app.main();
      await tester.pumpAndSettle();

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
  });
}

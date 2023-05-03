import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'app_settings.dart';
import 'app_state.dart';
import 'pages/home.dart';

void main() async {
  Intl.defaultLocale = 'en';
  await initializeDateFormatting();
  await AppSettings.create();
  runApp(ScanApp());
}

class ScanApp extends StatelessWidget {
  final AppSettings settings = AppSettings.instance;

  @override
  Widget build(BuildContext context) {
    final elevatedButtonThemeData = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'EMAG\'23 scan app',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 3, 56, 116),
              brightness: Brightness.light),
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromARGB(255, 3, 56, 116),
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: elevatedButtonThemeData,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 3, 56, 116),
            brightness: Brightness.dark,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromARGB(255, 3, 56, 116),
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: elevatedButtonThemeData,
        ),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import '/app_settings.dart';
import '/data/backend_data_store.dart';
import '/data/data_manager.dart';
import '/data/local_data_store.dart';
import '/util/routes.dart';
import '/util/internet_connection_listener.dart';
import 'pages/home_page.dart';
import 'pages/activity_load_page.dart';
import 'pages/activity_select_page.dart';
import 'pages/activity_confirm_page.dart';
import 'pages/activity_participants_page.dart';
import 'pages/registration_setup_page.dart';
import 'pages/goodies_setup_page.dart';
import 'pages/goodies_show_page.dart';
import 'pages/settings_page.dart';
import 'pages/scan_page.dart';

void main() async {
  Intl.defaultLocale = 'en';
  await initializeDateFormatting();

  await AppSettings().initializeAsync();

  runApp(
    MultiProvider(
      providers: [
        Provider<LocalDataStore>(create: (_) => LocalDataStore()),
        Provider<BackendDataStore>(
          create: (_) => BackendDataStore(),
          lazy: false,
        ),
        ChangeNotifierProvider<InternetConnectionListener>(
            create: (_) => InternetConnectionListener()),
        ChangeNotifierProvider<AppSettings>(create: (_) => AppSettings()),
        ChangeNotifierProvider<DataManager>(
            create: (context) => DataManager(context)),
      ],
      child: const ScanApp(),
    ),
  );
}

class ScanApp extends StatelessWidget {
  const ScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    final elevatedButtonThemeData = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    return MaterialApp(
      title: 'EMAG\'23 scan app',
      initialRoute: '/',
      routes: {
        // '/': (context) => const HomePage(), -- redundant
        Routes.settings: (context) => const SettingsPage(),
        Routes.scan: (context) => const ScanPage(),        
        Routes.activityConfirm: (context) => ActivityConfirmPage(),
        Routes.activitySelect: (context) => const ActivitySelectPage(),
        Routes.activityDownload: (context) => const ActivityLoadPage(),
        Routes.activityParticipants: (context) => const ActivityParticipantsPage(),
        Routes.registrationSetup: (context) => const RegistrationSetupPage(),
        Routes.goodiesSetup: (context) => const GoodiesSetupPage(),
        Routes.goodiesShow: (context) => const GoodiesShowPage(),
      },
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 3, 56, 116),
            brightness: Brightness.light),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 3, 56, 116),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: elevatedButtonThemeData,
      ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: Color.fromARGB(255, 3, 56, 116),
      //     brightness: Brightness.dark,
      //   ),
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: Color.fromARGB(255, 3, 56, 116),
      //     foregroundColor: Colors.white,
      //   ),
      //   elevatedButtonTheme: elevatedButtonThemeData,
      // ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

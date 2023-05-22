import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'registration_setup_page.dart';
import 'activity_confirm_page.dart';
import 'settings_page.dart';
import '/widgets/connection_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('EMAG \'23 Scanner'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => const SettingsPage(),
                        settings:
                            RouteSettings(name: (SettingsPage).toString())));
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              ConnectionWidget.get(),
              SvgPicture.asset('./assets/graphics/logo.svg'),
              ElevatedButton(
                child: const Text('Scan for access'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => ActivityConfirmPage(),
                      settings: RouteSettings(
                        name: (ActivityConfirmPage).toString(),
                      ),
                    ),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Scan for registration'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const RegistrationSetupPage(),
                      settings: RouteSettings(
                        name: (RegistrationSetupPage).toString(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

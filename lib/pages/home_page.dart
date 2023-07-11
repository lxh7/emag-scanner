import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/util/routes.dart';
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
                Navigator.pushNamed(context, Routes.settings);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              ConnectionWidget.get(),
              SvgPicture.asset('./assets/images/logo.svg'),
              ElevatedButton(
                child: const Text('Scan for access'),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.activityConfirm);
                },
              ),
              ElevatedButton(
                child: const Text('Scan for registration'),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.registrationSetup);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

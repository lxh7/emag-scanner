import 'package:emag_scanner/data/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/scanning/goodies_scan_handler.dart';
import '/util/routes.dart';
import '/widgets/connection_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('EMAG Scanner'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {
                Navigator.pushNamed(context, Routes.help);
              },
            ),
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
              SvgPicture.asset('./assets/images/logo.svg', width: 300, height: 300),
              ElevatedButton(
                child: const Text('Show programme'),
                onPressed: () {
                  // ensure categories are fetched from the server
                  DataManager(context).getCategories().then((value) {
                    Navigator.pushNamed(context, Routes.programme
                        );
                  });
                },
              ),
              ElevatedButton(
                child: const Text('Scan for access'),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.activityConfirm);
                },
              ),
              // ElevatedButton(
              //   child: const Text('Scan for registration'),
              //   onPressed: () {
              //     Navigator.pushNamed(context, Routes.registrationSetup);
              //   },
              // ),
              ElevatedButton(
                child: const Text('Scan for goodies'),
                onPressed: () {
                  // ensure categories are fetched from the server
                  DataManager(context).getCategories().then((value) {
                    Navigator.pushNamed(context, Routes.scan,
                        arguments: GoodiesScanHandler());
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/app_state.dart';
import '/pages/activity_confirm.dart';
import '/pages/settings.dart';
import '/scanning/activity_scan_handler.dart';
import '/widgets/connection_widget.dart';
import 'scan.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _ = context.watch<AppState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Emag \'23 Scanner'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => SettingsPage(),
                        settings:
                            RouteSettings(name: (SettingsPage).toString())));
              },
            ),
          ],
        ),
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: const <Widget>[
        //       DrawerHeader(
        //         decoration: BoxDecoration(
        //           color: Colors.blue,
        //         ),
        //         child: Text(
        //           'Drawer Header',
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 24,
        //           ),
        //         ),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.message),
        //         title: Text('Messages'),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.account_circle),
        //         title: Text('Profile'),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.settings),
        //         title: Text('Settings'),
        //         // onTap: () {
        //         //   // change app state...
        //         //   Navigator.pop(context); // close the drawer
        //         // },
        //       ),
        //     ],
        //   ),
        // ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              ConnectionWidget.get(),
              //to show internet connection message on isoffline = true.
              SvgPicture.asset('./assets/graphics/logo.svg'),
              ElevatedButton(
                child: Text('Scan for access'),
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
                child: Text('Scan for registration'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) =>
                          ScanPage(handler: ActivityScanHandler()),
                      settings: RouteSettings(
                        name: (ScanPage).toString() +
                            (ActivityScanHandler).toString(),
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

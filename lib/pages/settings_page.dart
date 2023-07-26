import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '/app_settings.dart';
import '/util/routes.dart';
import '/scanning/settings_scan_handler.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool passwordVisible = false;
  bool oauthClientSecretVisible = false;
  // secrets entered. Never return stored secrets, but do provide a nice UX that the user can toggle visiblilty
  String _oauthClientSecretEntered = '';
  String _password = '';

  var titleScaleFactor = 0.8;
  @override
  Widget build(BuildContext context) {
    var appSettings = Provider.of<AppSettings>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Settings'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.qr_code),
                tooltip: 'Scan settings',
                onPressed: () {
                  Navigator.pushNamed(context, Routes.scan,
                      arguments: SettingsScanHandler());
                }),
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          primary: false,
          children: [
            ListTile(
              title: Text(
                'URL of the API (do not end with /)',
                style: const TextStyle(color: Colors.orange),
                textScaleFactor: titleScaleFactor,
              ),
              subtitle: TextField(
                controller: TextEditingController(text: appSettings.apiUrl),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  prefixIcon: Icon(Icons.power),
                  filled: true,
                ),
                autocorrect: false,
                
                onChanged: (value) {
                  appSettings.apiUrl = value;
                },
              ),
            ),
            ListTile(
              title: Text(
                'OAUTH token URL',
                style: const TextStyle(color: Colors.orange),
                textScaleFactor: titleScaleFactor,
              ),
              subtitle: TextField(
                controller:
                    TextEditingController(text: appSettings.oauthTokenUrl),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  prefixIcon: Icon(Icons.token),
                  filled: true,
                ),
                autocorrect: false,
                onChanged: (value) {
                  appSettings.oauthTokenUrl = value;
                },
              ),
            ),
            ListTile(
              title: Text(
                'OAUTH client id',
                style: const TextStyle(color: Colors.orange),
                textScaleFactor: titleScaleFactor,
              ),
              subtitle: TextField(
                controller:
                    TextEditingController(text: appSettings.oauthClientId),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  prefixIcon: Icon(Icons.perm_identity),
                  filled: true,
                ),
                autocorrect: false,
                enableIMEPersonalizedLearning: false,
                onChanged: (value) {
                  appSettings.oauthClientId = value;
                },
              ),
            ),
            ListTile(
              title: Text(
                'OAUTH client secret',
                style: const TextStyle(color: Colors.orange),
                textScaleFactor: titleScaleFactor,
              ),
              subtitle: TextField(
                obscureText: !oauthClientSecretVisible,
                autocorrect: false,
                enableIMEPersonalizedLearning: false,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    icon: Icon(oauthClientSecretVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          oauthClientSecretVisible = !oauthClientSecretVisible;
                        },
                      );
                    },
                  ),
                  helperText: 'Leave empty if no change is needed',
                  alignLabelWithHint: false,
                  filled: true,
                ),
                controller:
                    TextEditingController(text: _oauthClientSecretEntered),
                onChanged: (value) {
                  _oauthClientSecretEntered = value;
                  appSettings.oauthClientSecret = value;
                },
              ),
            ),
            ListTile(
              title: Text(
                'User ID',
                style: const TextStyle(color: Colors.orange),
                textScaleFactor: titleScaleFactor,
              ),
              subtitle: TextField(
                controller: TextEditingController(text: appSettings.userId),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  prefixIcon: Icon(Icons.perm_identity),
                  filled: true,
                ),
                autocorrect: false,
                enableIMEPersonalizedLearning: false,
                onChanged: (value) {
                  appSettings.userId = value;
                },
              ),
            ),
            ListTile(
              title: Text(
                'Password',
                style: const TextStyle(color: Colors.orange),
                textScaleFactor: titleScaleFactor,
              ),
              subtitle: TextField(
                obscureText: !passwordVisible,
                autocorrect: false,
                enableIMEPersonalizedLearning: false,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  ),
                  helperText: 'Leave empty if no change is needed',
                  alignLabelWithHint: false,
                  filled: true,
                ),
                controller: TextEditingController(text: _password),
                onChanged: (value) {
                  _password = value;
                  appSettings.password = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

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
        body: SettingsList(
          sections: [
            SettingsSection(
              title: const Text('API'),
              tiles: <SettingsTile>[
                SettingsTile(
                  title: Text(
                    'URL of the API (do not end with /)',
                    style: const TextStyle(color: Colors.orange),
                    textScaleFactor: titleScaleFactor,
                  ),
                  value: TextField(
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
                SettingsTile(
                  title: Text(
                    'OAUTH authorization URL',
                    style: const TextStyle(color: Colors.orange),
                    textScaleFactor: titleScaleFactor,
                  ),
                  value: TextField(
                    controller: TextEditingController(
                        text: appSettings.oauthAuthorizationUrl),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      prefixIcon: Icon(Icons.safety_check),
                      filled: true,
                    ),
                    autocorrect: false,
                    onChanged: (value) {
                      appSettings.oauthAuthorizationUrl = value;
                    },
                  ),
                ),
                SettingsTile(
                  title: Text(
                    'OAUTH token URL',
                    style: const TextStyle(color: Colors.orange),
                    textScaleFactor: titleScaleFactor,
                  ),
                  value: TextField(
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
                SettingsTile(
                  title: Text(
                    'OAUTH client id',
                    style: const TextStyle(color: Colors.orange),
                    textScaleFactor: titleScaleFactor,
                  ),
                  value: TextField(
                    controller:
                        TextEditingController(text: appSettings.oauthClientId),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      prefixIcon: Icon(Icons.perm_identity),
                      filled: true,
                    ),
                    autocorrect: false,
                    onChanged: (value) {
                      appSettings.oauthClientId = value;
                    },
                  ),
                ),
                SettingsTile(
                  title: Text(
                    'OAUTH client secret',
                    style: const TextStyle(color: Colors.orange),
                    textScaleFactor: titleScaleFactor,
                  ),
                  value: TextField(
                    obscureText: oauthClientSecretVisible,
                    autocorrect: false,
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
                              oauthClientSecretVisible =
                                  !oauthClientSecretVisible;
                            },
                          );
                        },
                      ),
                      helperText: 'Leave empty if no change is needed',
                      alignLabelWithHint: false,
                      filled: true,
                    ),
                    controller: TextEditingController(text: ''),
                    onChanged: (value) {
                      if (value != '') {
                        appSettings.oauthClientSecret = value;
                      }
                    },
                  ),
                ),
                SettingsTile(
                  title: Text(
                    'User ID',
                    style: const TextStyle(color: Colors.orange),
                    textScaleFactor: titleScaleFactor,
                  ),
                  value: TextField(
                    controller: TextEditingController(text: appSettings.userId),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      prefixIcon: Icon(Icons.perm_identity),
                      filled: true,
                    ),
                    autocorrect: false,
                    onChanged: (value) {
                      if (value != '') {
                        appSettings.userId = value;
                      }
                    },
                  ),
                ),
                SettingsTile(
                  title: Text(
                    'Password',
                    style: const TextStyle(color: Colors.orange),
                    textScaleFactor: titleScaleFactor,
                  ),
                  value: TextField(
                    obscureText: passwordVisible,
                    autocorrect: false,
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
                    controller: TextEditingController(text: ''),
                    onChanged: (value) {
                      if (value != '') {
                        appSettings.password = value;
                      }
                    },
                  ),
                ),
              ],
            ),
          ], // sections
        ),
      ),
    );
  }
}

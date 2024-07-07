import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '/widgets/spinner.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  Future<String> loadHelp(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString('assets/help.md');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Help'),
        ),
        body: FutureBuilder<String>(
          future: loadHelp(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Markdown(data: snapshot.data!);
            } else {
              return const Spinner();
            }
          },
        ),
      ),
    );
    // });
  }
}
/*
        
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('Help will apear here'),
          // Markdown(data: 'help_md'),
        ),
*/

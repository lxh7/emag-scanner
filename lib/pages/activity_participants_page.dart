import 'package:flutter/material.dart';

import '/models/domain.dart';
import '/widgets/connection_widget.dart';

class ActivityParticipantsPage extends StatefulWidget {
  const ActivityParticipantsPage({super.key});

  @override
  State<ActivityParticipantsPage> createState() =>
      _ActivityParticipantsPageState();
}

class _ActivityParticipantsPageState extends State<ActivityParticipantsPage> {
  // methods/functions
  Color _getParticitionColor(Participation p) {
    // TODO: set up colour scheme for different situations
    // never scanned
    // scanned a while ago
    // scanned recently
    return Colors.white60;
  }

  @override
  Widget build(BuildContext context) {
    var activity = ModalRoute.of(context)!.settings.arguments as Activity;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_left_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Participants in activity'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              ConnectionWidget.get(),
              Text(activity.name),
              const Text('Participants'),
              ..._buildParticipantsUI(activity),
            ], // children
          ),
        ),
      ),
    );
  }

  _buildParticipantsUI(Activity activity) {
    if (activity.participations.isEmpty == true) {
      return const Text('No participants found');
    }
    return ListView(
        shrinkWrap: true,
        primary: false,
        children: activity.participations
            .map((p) => ListTile(
                  title: Text(p.person!.name),
                  subtitle: const Text(
                    'subtitle',
                    maxLines: 2,
                  ), //second and third line of text
                  isThreeLine: true,

                  tileColor: _getParticitionColor(p),
                ))
            .toList());
  }
}

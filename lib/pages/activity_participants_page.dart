import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '/models/domain.dart';
import '/util/my_dialog.dart';
import '/util/my_formats.dart';
import '/widgets/connection_widget.dart';

class ActivityParticipantsPage extends StatefulWidget {
  const ActivityParticipantsPage({super.key});

  @override
  State<ActivityParticipantsPage> createState() =>
      _ActivityParticipantsPageState();
}

class _ActivityParticipantsPageState extends State<ActivityParticipantsPage> {
  static final DateTime _longAgo = DateTime.utc(2000, 1, 1);

  Color _getParticipationColor(Participation p) {
    if (p.scanTime == null) {
      // never scanned
      return Colors.red.shade100;
    } else if (DateTime.now().toUtc().difference(p.scanTime!).inMinutes < 30) {
      // scanned recently
      return Colors.green.shade100;
    } else {
      // scanned a while ago
      return Colors.orange.shade100;
    }
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
            shrinkWrap: true,
            primary: false,
            children: [
              ConnectionWidget.get(),
              Text(
                activity.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Participants:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              ..._buildParticipantsUI(activity),
            ], // children
          ),
        ),
      ),
    );
  }

  Iterable<Widget> _buildParticipantsUI(Activity activity) {
    if (activity.participations.isEmpty == true) {
      return [const Text('No participants found')];
    }
    var participations = List<Participation>.from(
      activity.participations.where((p) => p.paid && !p.waitlisted),
      growable: true,
    );
    participations.sort(_compareScanTimes);
    return participations.map((p) {
      var detailRows = List<Row>.empty(growable: true);
      detailRows.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Scan time: ${p.scanTime == null ? 'never' : MyFormats.dateTimeSec.format(p.scanTime!.toLocal().toLocal())}')
          ],
        ),
      );
      if (p.person != null) {
        if (p.person!.email.isNotEmpty == true) {
          detailRows.add(
            Row(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                onTap: () => launchUrl(Uri.parse('mailto:${p.person!.email}')),
                child: Text(
                  p.person!.email,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ]),
          );
        }
        if (p.person!.phone.isNotEmpty == true) {
          detailRows.add(
            Row(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                onTap: () async {
                  try {
                    await launchUrl(Uri.parse('tel:${p.person!.phone}'));
                  } catch (e) {
                    MyDialog.showError(context, 'Error starting phone app');
                  }
                },
                child: Text(
                  p.person!.phone,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ]),
          );
        }
      }
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(
          Icons.person,
          size: 50,
          color: Colors.blueGrey,
        ),
        title: Text(p.person?.name ?? p.personKey),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: detailRows),
        isThreeLine: false,
        tileColor: _getParticipationColor(p),
        visualDensity: VisualDensity.compact,
      );
    });
  }

  int _compareScanTimes(Participation p1, Participation p2) {
    var t1 = p1.scanTime ?? _longAgo;
    var t2 = p2.scanTime ?? _longAgo;
    var result = t1.compareTo(t2);
    return result;
    //   // sort so that the oldest times (or not scanned at all) are on top
    //   if (p1.scanTime == null && p2.scanTime == null) {
    //     return 0; // both never scanned
    //   }
    //   if (p1.scanTime == null) {
    //     return -1; // never scanned - bring to top
    //   }
    //   if (p2.scanTime == null) {
    //     return 1; // p1 scanned, p2 never - sink to bottom
    //   }
    //   return p1.scanTime!.compareTo(p2.scanTime!); // negative: p1 is before p2
  }
}

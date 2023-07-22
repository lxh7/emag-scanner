import 'package:backoffice_api/backoffice_api.dart';

import '/models/domain.dart';

class DtoHelper {
  static final DateTime defaultDateTime =
      DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
  static Activity fromEventDTO(EventDTO x) {
    var result = Activity(
        convertInt(x.id, 0)!,
        convertInt(x.categoryId, 0)!,
        convertString(x.name, ''),
        convertDate(x.start, defaultDateTime)!,
        convertDate(x.end, defaultDateTime)!,
        question1: x.question1,
        question2: x.question2,
        question3: x.question3,
        scanFunction: x.scanFunction,
        participations: getParticipations(x.participations));
    return result;
  }

  static Participation fromParticipationDTO(ParticipationDTO x) {
    var result = Participation(
      convertInt(x.eventId, -1)!, // activityId
      x.personId ?? '', // personId
      convertBool(x.paid, false),
      !convertBool(x.in_, true),
      scanTime: convertDate(x.scanTime, null)?.toUtc(),
      activity: x.event == null ? null : fromEventDTO(x.event!),
      person: x.person == null ? null : fromPersonDTO(x.person!),
      answer1: x.answer1,
      answer2: x.answer2,
      answer3: x.answer3,
    );
    return result;
  }

  static Person fromPersonDTO(PersonDTO x) {
    var result = Person(
        convertString(x.personId, ''),
        convertString(x.firstName, ''),
        convertString(x.surname, ''),
        convertString(x.nickname, ''),
        convertString(x.mobilePhone, ''),
        convertString(x.email, ''),
        participations: getParticipations(x.participations));
    return result;
  }

  static List<Participation> getParticipations(
      Iterable<ParticipationDTO>? dtos) {
    var result = List<Participation>.empty();
    if (dtos != null) {
      result = dtos.map((p) => fromParticipationDTO(p)).toList();
    }
    return result;
  }

  static int? convertInt(int? value, int? def) {
    if (value == null) {
      return def;
    }
    return value;
  }

  static String convertString(String? value, String def) {
    if (value == null) {
      return def;
    }
    return value;
  }

  static bool convertBool(bool? value, bool def) {
    if (value == null) {
      return def;
    }
    return value;
  }

  static DateTime? convertDate(String? value, DateTime? def) {
    if (value == null) {
      return def;
    }
    // the server struggles to handle the correct dates, as it seems it is configured at UTC (not local time)
    // cut-off the time zone offset and handle as local date/time
    var plus = value.indexOf('+');
    if (plus > 0) {
      value = value.substring(0, plus);
    }
    var result = DateTime.parse(value);
    return result;
    /* if DateTime.now().Timezone (=Duration object) needs to be formatted, we can use this:
      extension DurationFormatter on Duration {
      /// Returns a day, hour, minute, second string representation of this `Duration`.
      ///
      ///
      /// Returns a string with days, hours, minutes, and seconds in the
      /// following format: `dd:HH:MM:SS`. For example,
      ///
      ///   var d = new Duration(days:19, hours:22, minutes:33);
      ///    d.dayHourMinuteSecondFormatted();  // "19:22:33:00"
      String dayHourMinuteSecondFormatted() {
        this.toString();
        return [
          // this.inDays,
          this.inHours.remainder(24),
          this.inMinutes.remainder(60),
          // this.inSeconds.remainder(60)
        ].map((seg) {
          return seg.toString().padLeft(2, '0');
        }).join(':');
      }
    }
      */
    // or we can use Strict parsing with the UTC=false flag
    // return DateFormat().parseStrict(value, false); // UTC: false
  }
}

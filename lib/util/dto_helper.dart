import 'package:scan/apis/backend/lib/api.dart';

import '/models/activity.dart';

class DtoHelper {
  static Activity fromEventDTO(EventDTO x) {
    return Activity(
      convertInt(x.id, 0),
      convertInt(x.categoryId, 0),
      convertString(x.name, ''),
      convertDate(x.start, DateTime(2000, 1, 1, 12, 0, 0)),
      convertDate(x.end, DateTime(2000, 1, 1, 12, 0, 0, 1)),
    );
  }

  static int convertInt(int? value, int def) {
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

  static DateTime convertDate(String? value, DateTime def) {
    if (value == null) {
      return def;
    }
    // the server struggles to handle the correct dates, as it seems it is configured at UTC (not local time)
    // cut-off the time zone offset and handle as local date/time
    var plus = value.indexOf('+');
    if (plus > 0) {
      value = value.substring(0, plus);
    }
    return DateTime.parse(value);
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

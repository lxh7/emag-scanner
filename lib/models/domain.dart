import 'package:realm/realm.dart';

import '/enums/scan_result.dart';

part 'domain.g.dart';

// generate with: flutter pub run realm generate

@RealmModel()
class _Category {
  @PrimaryKey()
  late int id;
  late String name;
}

@RealmModel()
class _Activity {
  @PrimaryKey()
  late int id;
  late int categoryId;
  late String name;
  late DateTime start;
  late DateTime end;
  late String? question1;
  late String? question2;
  late String? question3;
  late List<_Participation> participations;
}

@RealmModel()
class _Participation {
  @Indexed()
  late int activityId;
  // @Backlink(#participations)
  late _Activity? activity;
  @Indexed()
  late String personKey;
  // @Backlink(#participations)
  late _Person? person;
  late DateTime? scanTime;
  late bool paid;
  late bool waitlisted;
  late String? answer1;
  late String? answer2;
  late String? answer3;
}

@RealmModel()
class _Person {
  @PrimaryKey()
  late String key;
  late String firstName;
  late String lastName;
  late String nickName;
  late String phone;
  late String email;
  late List<_Participation> participations;

  String get name {
    var buffer = StringBuffer();
    if (nickName.isNotEmpty) {
      buffer.write(nickName);
      buffer.write(' (');
      buffer.write(firstName);
      buffer.write(') ');
    } else {
      buffer.write(firstName);
      buffer.write(' ');
    }
    buffer.write(lastName);

    return buffer.toString();
  }
}

// info packet to send to API for access check
@RealmModel()
class _ScanInfo {
  late int activityId;
  late String personKey;
  @Indexed()
  late DateTime scanTime;
}

// answer from API for access check
class AccessCheckResult {
  ScanResult scanResult;
  DateTime? prevScanTime;
  String message;

  AccessCheckResult({
    this.scanResult = ScanResult.none,
    this.prevScanTime,
    this.message = '',
  });
}

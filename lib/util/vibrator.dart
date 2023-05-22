import 'package:vibration/vibration.dart';

class Vibrator {
  static const int _startWait = 5;
  static const int _shortBzt = 80;
  static const int _mediumBzt = 200;
  static const int _longBzt = 400;
  static const int _shortPause = 125;
  static const int _longPause = 250;

  static stopBuzzer() async {
    if (await Vibration.hasVibrator() == true) {
      Vibration.cancel();
    }
  }

  static okBuzzer() async {
    if (await Vibration.hasVibrator() == true) {
      if (await Vibration.hasCustomVibrationsSupport() == true) {
        Vibration.vibrate(duration: _shortBzt);
      } else {
        Vibration.vibrate();
      }
    }
  }

  static warningBuzzer() async {
    if (await Vibration.hasVibrator() == true) {
      if (await Vibration.hasCustomVibrationsSupport() == true) {
        Vibration.vibrate(
            pattern: [_startWait, _mediumBzt, _shortPause, _mediumBzt, _longPause]);
      } else {
        Vibration.vibrate();
        Vibration.vibrate();
      }
    }
  }

  static errorBuzzer() async {
    if (await Vibration.hasVibrator() == true) {
      if (await Vibration.hasCustomVibrationsSupport() == true) {
        Vibration.vibrate(
            pattern: [_startWait, _longBzt, _shortPause, _longBzt, _shortPause, _longBzt, _longPause]);
      } else {
        Vibration.vibrate();
        Vibration.vibrate();
        Vibration.vibrate();
      }
    }
  }
}

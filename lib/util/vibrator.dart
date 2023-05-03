import 'package:vibration/vibration.dart';

class Vibrator {
  static const int _startWait = 20;
  static const int _shortBzt = 200;
  static const int _mediumBzt = 400;
  static const int _longBzt = 800;
  static const int _shortPause = 250;
  static const int _longPause = 1000;

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
        Vibration.vibrate(pattern: [
          _startWait,
          _mediumBzt,
          _shortPause,
          _mediumBzt,
          _shortPause,
          _mediumBzt,
          _longPause
        ], repeat: 3);
      } else {
        Vibration.vibrate();
        Vibration.vibrate();
      }
    }
  }

  static errorBuzzer() async {
    if (await Vibration.hasVibrator() == true) {
      if (await Vibration.hasCustomVibrationsSupport() == true) {
        Vibration.vibrate(pattern: [
          _startWait,
          _longBzt,
          _shortPause,
          _longBzt,
          _shortPause,
          _longBzt,
          _longPause
        ], repeat: 3);
      } else {
        Vibration.vibrate();
        Vibration.vibrate();
        Vibration.vibrate();
      }
    }
  }
}

import 'package:flutter/material.dart';

class BrightnessHelper{
   Brightness getActualBrightness(BuildContext context, ThemeMode theme) {
    Brightness brightness;
    switch (theme) {
      case ThemeMode.system:
        brightness = MediaQuery.of(context).platformBrightness;
        break;
      case ThemeMode.light:
        brightness = Brightness.light;
        break;
      case ThemeMode.dark:
        brightness = Brightness.dark;
        break;
    }
    return brightness;
  }

}
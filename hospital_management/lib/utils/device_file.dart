

import 'package:flutter/material.dart';
import 'package:hospital_management/core/strings/strings.dart';

class DeviceUtil {
  static String get _getDeviceType {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 550 ? Strings.kPhone : Strings.kTablet;
  }

  static bool get isTablet {
    return _getDeviceType == Strings.kTablet;
  }

  static bool get isMobile {
    return _getDeviceType == Strings.kPhone;
  }
}
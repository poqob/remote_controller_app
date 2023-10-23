mixin DeviceScreen {
  static double? width;
  static double? height;
  void setDeviceDimensions({double? width, double? height}) {
    DeviceScreen.height = height;
    DeviceScreen.width = width;
  }
}
mixin HostScreen {
  static double? width;
  static double? height;

  void setHostDimensions({double? width, double? height}) {
    HostScreen.height = height;
    HostScreen.width = width;
  }
}

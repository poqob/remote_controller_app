import 'package:flutter/material.dart';
import 'package:remote_controller_app/models/network/a_communication.dart';
import 'package:remote_controller_app/models/network/lan.dart';
import 'package:remote_controller_app/screens/mousepad/mouse_pad.dart';

mixin Connection on State<MousePad> {
  Offset? lastOffsetPoint;
  ACommunication communication = LAN("192.168.8.121", 5100);
  @override
  void initState() {
    () async {
      await communication.connect();
    };
    super.initState();
  }

  @override
  dispose() {
    () async {
      await communication.disconnect();
    };
    super.dispose();
  }
}

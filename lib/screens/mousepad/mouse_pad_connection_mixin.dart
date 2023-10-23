import 'package:flutter/material.dart';
import 'package:remote_controller_app/models/network/a_communication.dart';
import 'package:remote_controller_app/models/network/lan.dart';
import 'package:remote_controller_app/screens/mousepad/mouse_pad.dart';

mixin Connection on State<MousePad> {
  ACommunication communication = LAN("192.168.8.121", 5100);
}

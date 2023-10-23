import 'package:flutter/material.dart';
import 'package:remote_controller_app/screens/mousepad/mouse_pad.dart';

mixin MouseScrollMixin on State<MousePad> {
  Offset? firstScrollOffsetPoint;
  Offset? currentScrollOffsetPoint;
}

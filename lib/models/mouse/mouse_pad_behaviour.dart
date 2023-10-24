// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:remote_controller_app/screens/mousepad/mouse_pad.dart';

enum MousePadBehaviour {
  STATIC,
  DYNAMIC, // TODO: Implement dynamic mouse pad behaviour
}

mixin MousePadBehaviourMixin on State<MousePad> {
  MousePadBehaviour mousePadBehaviour = MousePadBehaviour.STATIC;
  Offset? firstMoveOffsetPoint;
  Offset? currentMoveOffsetPoint;
  Offset? lastOffsetPoint;
  Offset? resultOffsetPoint;
  Offset? firstScrollOffsetPoint;
  Offset? currentScrollOffsetPoint;
}

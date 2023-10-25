import 'package:flutter/material.dart';
import 'package:remote_controller_app/models/mouse/mouse_pad_behaviour.dart';
import 'package:remote_controller_app/screens/mousepad/mouse_pad.dart';

mixin MousePadBehaviourMixin on State<MousePad> {
  MousePadBehaviour mousePadBehaviour = MousePadBehaviour.DYNAMIC;
  Offset? firstMoveOffsetPoint;
  Offset? currentMoveOffsetPoint;
  Offset? lastOffsetPoint;
  Offset? resultOffsetPoint;
  Offset? firstScrollOffsetPoint;
  Offset? currentScrollOffsetPoint;
}

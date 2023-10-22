import 'package:flutter/material.dart';
import 'package:remote_controller_app/models/model/input_type.dart';
import 'package:remote_controller_app/models/model/model.dart';
import 'package:remote_controller_app/models/mouse/mouse_actions.dart';
import 'package:remote_controller_app/models/mouse/mouse_model.dart';
import 'package:remote_controller_app/models/mouse/mouse_pad_behaviour.dart';
import 'package:remote_controller_app/screens/mousepad/mouse_pad.dart';

mixin MouseInput on State<MousePad> {
  Offset? lastOffsetPoint;
  Map<String, int> hostScreenSize = {
    "width": 1600,
    "height": 900
  }; // TODO: TAKE THIS INPUT FROM UI

  Model mouse({Offset? offset, required MouseActions action}) {
    return Model(
        type: InputType.MOUSE,
        data: MouseModel(
                mMode: MousePadBehaviour
                    .STATIC, // Mouse pad behaviour will be a value which can selectable on ui.
                x: _scale(offset!.dx, MediaQuery.of(context).size.width,
                    hostScreenSize["width"] as num),
                y: _scale(offset.dy, MediaQuery.of(context).size.height,
                    hostScreenSize["height"] as num),
                action: action)
            .toJson());
    // await communication.send(model);
  }

  int _scale(num input, num device, num host) {
    return input * host ~/ device;
  }
}

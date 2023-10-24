import 'package:flutter/material.dart';
import 'package:remote_controller_app/models/model/input_type.dart';
import 'package:remote_controller_app/models/model/model.dart';
import 'package:remote_controller_app/models/mouse/mouse_actions.dart';
import 'package:remote_controller_app/models/mouse/mouse_model.dart';
import 'package:remote_controller_app/models/mouse/mouse_pad_behaviour.dart';
import 'package:remote_controller_app/models/screen/screens_mixin.dart';
import 'package:remote_controller_app/screens/mousepad/mouse_pad.dart';

mixin MouseInput on State<MousePad>
    implements DeviceScreen, HostScreen, MousePadBehaviourMixin {
  Model mouse({Offset? offset, required MouseActions action}) {
    return Model(
        type: InputType.MOUSE,
        data: MouseModel(
                mMode: mousePadBehaviour,
                x: _scale(
                    offset!.dx, DeviceScreen.width!, HostScreen.width as num),
                y: _scale(
                    offset.dy, DeviceScreen.height!, HostScreen.height as num),
                action: action)
            .toJson());
    // await communication.send(model);
  }

  int _scale(num input, num device, num host) {
    return input * host ~/ device;
  }
}

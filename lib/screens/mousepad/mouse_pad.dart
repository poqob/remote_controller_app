import 'package:flutter/material.dart';
import 'package:remote_controller_app/models/model/input_type.dart';
import 'package:remote_controller_app/models/model/model.dart';
import 'package:remote_controller_app/models/mouse/mouse_actions.dart';
import 'package:remote_controller_app/models/mouse/mouse_model.dart';
import 'package:remote_controller_app/models/mouse/mouse_pad_behaviour.dart';
import 'package:remote_controller_app/models/network/a_communication.dart';
import 'package:remote_controller_app/models/network/lan.dart';

class MousePad extends StatefulWidget {
  const MousePad({super.key});

  @override
  State<MousePad> createState() => _MousePadState();
}

class _MousePadState extends State<MousePad> with Connection {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (event) => mouse(event, MouseActions.MOVE),
      child: Container(
        color: Colors.grey[900],
      ),
    );
  }
}

mixin Connection on State<MousePad> {
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

  Future<void> mouse(PointerEvent event, MouseActions action) async {
    var model = Model(
        type: InputType.MOUSE,
        data: MouseModel(
                mMode: MousePadBehaviour.STATIC,
                x: _scale(
                    event.position.dx, MediaQuery.of(context).size.width, 1600),
                y: _scale(
                    event.position.dy, MediaQuery.of(context).size.height, 900),
                action: action)
            .toJson());
    await communication.send(model);
  }

  int _scale(num input, num device, num host) {
    return input * host ~/ device;
  }
}

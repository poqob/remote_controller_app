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
      onPointerMove: (event) => name(event),
      child: Container(
        color: Colors.black,
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

  Future<void> name(PointerEvent event) async {
    var model = Model(
        type: InputType.MOUSE,
        data: MouseModel(
                mMode: MousePadBehaviour.STATIC,
                x: event.position.dx.toInt(),
                y: event.position.dy.toInt(),
                action: MouseActions.MOVE)
            .toJson());
    await communication.send(model);
  }
}

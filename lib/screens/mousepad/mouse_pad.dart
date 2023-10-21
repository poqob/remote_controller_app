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
  DragUpdateDetails? _lastevent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        mouse(event: details, action: MouseActions.MOVE);
        _lastevent = details;
      },
      onTap: () => mouse(event: _lastevent, action: MouseActions.LEFT_CLICK),
      onLongPress: () =>
          mouse(event: _lastevent, action: MouseActions.RIGHT_CLICK),
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

  Future<void> mouse(
      {DragUpdateDetails? event, required MouseActions action}) async {
    var model = Model(
        type: InputType.MOUSE,
        data: MouseModel(
                mMode: MousePadBehaviour.STATIC,
                x: _scale(
                    event!.localPosition.dx,
                    MediaQuery.of(context).size.width,
                    1600), // TODO: 1600 computer screen size depend on pixel density
                y: _scale(
                    event.localPosition.dy,
                    MediaQuery.of(context).size.height,
                    900), // TODO: 900 computer screen size depend on pixel density
                action: action)
            .toJson());
    await communication.send(model);
  }

  int _scale(num input, num device, num host) {
    return input * host ~/ device;
  }
}

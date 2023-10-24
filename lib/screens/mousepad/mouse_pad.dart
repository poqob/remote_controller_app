import 'dart:math';

import 'package:flutter/material.dart';
import 'package:remote_controller_app/models/mouse/mouse_actions.dart';
import 'package:remote_controller_app/models/mouse/mouse_pad_behaviour.dart';
import 'package:remote_controller_app/models/screen/screens_mixin.dart';
import 'package:remote_controller_app/screens/mousepad/mouse_pad_connection_mixin.dart';
import 'package:remote_controller_app/screens/mousepad/mouse_pad_mouse_input_mixin.dart';

class MousePad extends StatefulWidget {
  const MousePad({super.key});

  @override
  State<MousePad> createState() => _MousePadState();
}

class _MousePadState extends State<MousePad>
    with
        Connection,
        MouseInput,
        DeviceScreen,
        HostScreen,
        MousePadBehaviourMixin {
  @override
  void initState() {
    super.initState();

    () async {
      await communication.connect();
    };
    // new bie
    // TODO: update afrer rotation of the device screen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // setting mobile device and host device dimensions after build method.
      setDeviceDimensions(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height);
      setHostDimensions(width: 1600, height: 900);
    });
  }

  @override
  dispose() {
    () async {
      await communication.disconnect();
    };
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return pad();
  }

  GestureDetector pad() {
    return GestureDetector(
      onTap: () async => await communication.send(
          mouse(offset: lastOffsetPoint, action: MouseActions.LEFT_CLICK)),
      onDoubleTapDown: (details) => communication.send(mouse(
          offset: details.localPosition, action: MouseActions.DRAG_START)),
      onScaleStart: (ScaleStartDetails details) async {
        if (details.pointerCount == 1) {
          lastOffsetPoint = details.localFocalPoint;
        }
        // it confuses with scroll up-down.
        if (details.pointerCount == 2) {
          //lastOffsetPoint = details.localFocalPoint;
          // await communication.send(
          //   mouse(offset: lastOffsetPoint, action: MouseActions.RIGHT_CLICK));
        }
      },
      onScaleUpdate: (ScaleUpdateDetails details) async {
        if (details.pointerCount == 1) {
          // MOUSE MODE DYNAMIC
          if (mousePadBehaviour == MousePadBehaviour.DYNAMIC) {
            if (firstMoveOffsetPoint == null) {
              firstMoveOffsetPoint = details.localFocalPoint;
            } else {
              currentMoveOffsetPoint = details.localFocalPoint;
              lastOffsetPoint = currentMoveOffsetPoint! - firstMoveOffsetPoint!;

              await communication.send(
                  mouse(offset: lastOffsetPoint, action: MouseActions.MOVE));
              firstMoveOffsetPoint = currentMoveOffsetPoint;
            }
          } else {
            // MOUSE MODE STATIC
            await communication.send(mouse(
                offset: details.localFocalPoint, action: MouseActions.MOVE));
          }
        }

        if (details.pointerCount == 2) {
          // two finger scroll Mechanism.
          if (firstScrollOffsetPoint == null) {
            firstScrollOffsetPoint = details.localFocalPoint;
          } else {
            currentScrollOffsetPoint = details.localFocalPoint;
            if (firstScrollOffsetPoint!.dy > currentScrollOffsetPoint!.dy) {
              // scroll down
              communication.send(mouse(
                  offset: currentScrollOffsetPoint,
                  action: MouseActions.SCROLL_DOWN));
            } else if (firstScrollOffsetPoint!.dy <
                currentScrollOffsetPoint!.dy) {
              // scroll up
              communication.send(mouse(
                  offset: currentScrollOffsetPoint,
                  action: MouseActions.SCROLL_UP));
            }
            firstScrollOffsetPoint = currentScrollOffsetPoint;
          }
        }
        // triple finger tap Mechanism.
        if (details.pointerCount == 3) {
          //  print("TRIPLE KILL");
        }
      },
      onScaleEnd: (details) async => await communication
          .send(mouse(offset: lastOffsetPoint, action: MouseActions.RELEASE)),
      child: Container(
        color: Colors.black,
      ),
    );
  }
}
// TODO: dynamic mouse pad behaviour.
// TODO: solve multi pointer mechanics.

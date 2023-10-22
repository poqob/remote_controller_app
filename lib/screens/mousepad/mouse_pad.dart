import 'package:flutter/material.dart';
import 'package:remote_controller_app/models/mouse/mouse_actions.dart';
import 'package:remote_controller_app/screens/mousepad/mouse_pad_connection_mixin.dart';
import 'package:remote_controller_app/screens/mousepad/mouse_pad_mouse_input_mixin.dart';

class MousePad extends StatefulWidget {
  const MousePad({super.key});

  @override
  State<MousePad> createState() => _MousePadState();
}

/*
 onPanStart: (details) => (lastOffsetPoint = details.localPosition),
      onPanUpdate: (details) async {
        await communication.send(
            mouse(offset: details.localPosition, action: MouseActions.MOVE));
        lastOffsetPoint = details.localPosition;
      },
      onPanEnd: (details) => communication
          .send(mouse(offset: lastOffsetPoint, action: MouseActions.RELEASE)),
 */
class _MousePadState extends State<MousePad> with Connection, MouseInput {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await communication.send(
          mouse(offset: lastOffsetPoint, action: MouseActions.LEFT_CLICK)),
      onLongPress: () async => await communication.send(
          mouse(offset: lastOffsetPoint, action: MouseActions.RIGHT_CLICK)),
      onDoubleTapDown: (details) => communication.send(mouse(
          offset: details.localPosition, action: MouseActions.DRAG_START)),
      onScaleStart: (ScaleStartDetails details) {
        if (details.pointerCount == 1) lastOffsetPoint = details.focalPoint;

        // Check if two fingers are touching the screen
        if (details.pointerCount == 2) {
          // Two fingers are touching the screen
          //print('Two fingers are touching the screen');
        }
      },
      onScaleUpdate: (ScaleUpdateDetails details) async {
        if (details.pointerCount == 1) {
          await communication.send(
              mouse(offset: details.focalPoint, action: MouseActions.MOVE));
          lastOffsetPoint = details.focalPoint;
        }
        // Track the scale factor as the user continues to scale
        double scaleFactor = details.scale;
        //print('Scale factor: $scaleFactor');
      },
      onScaleEnd: (details) {
        if (details.pointerCount == 1) {
          communication.send(
              mouse(offset: lastOffsetPoint, action: MouseActions.RELEASE));
        }
      },
      child: Container(
        color: Colors.black,
      ),
    );
  }
}

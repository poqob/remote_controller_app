import 'package:remote_controller_app/models/mouse/mouse_actions.dart';
import 'package:remote_controller_app/models/mouse/mouse_pad_behaviour.dart';

class MouseModel {
  final MousePadBehaviour mMode;
  final int x;
  final int y;
  final MouseActions action;

  MouseModel(
      {required this.mMode,
      required this.x,
      required this.y,
      required this.action});

  Map<String, int> toJson() {
    return {
      'mMode': mMode.index,
      'X': x,
      'Y': y,
      'ACTION': action.index,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

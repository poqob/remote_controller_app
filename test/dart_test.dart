import 'package:remote_controller_app/models/model/input_type.dart';
import 'package:remote_controller_app/models/model/model.dart';
import 'package:remote_controller_app/models/mouse/mouse_actions.dart';
import 'package:remote_controller_app/models/mouse/mouse_model.dart';
import 'package:remote_controller_app/models/mouse/mouse_pad_behaviour.dart';
import 'package:remote_controller_app/models/network/LAN.dart';

Future<void> main() async {
  var mouseModel = MouseModel(
      x: 200,
      y: 200,
      mMode: MousePadBehaviour.STATIC,
      action: MouseActions.MOVE);

  var model = Model(type: InputType.MOUSE, data: mouseModel.toJson());
  var lan = LAN("192.168.56.1", 5100);
  await lan.connect();
  await lan.send(model);
  await lan.disconnect();
}

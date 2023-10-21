import 'package:remote_controller_app/models/model/model.dart';

abstract class ACommunication {
  Future<void> connect();
  Future<void> disconnect();
  Future<void> send(Model model);
}

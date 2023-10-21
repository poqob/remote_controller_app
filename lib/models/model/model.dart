import 'package:remote_controller_app/models/model/input_type.dart';

class Model {
  final InputType type;
  final Map<String, int> data;

  Model({required this.type, required this.data});

  toJson() {
    return {
      'INPUT_TYPE': type.index,
      'BODY': data,
    };
  }
}

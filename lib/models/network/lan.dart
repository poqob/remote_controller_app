import 'dart:convert';
import 'dart:ffi';
import 'package:remote_controller_app/models/model/model.dart';
import 'package:remote_controller_app/models/network/a_communication.dart';
import 'dart:io';

class LAN extends ACommunication {
  String ip;
  int port;
  RawDatagramSocket? socket;

  LAN(this.ip, this.port);

  Map<String, dynamic> toJson() => {
        'ip': ip,
        'port': port,
      };

  @override
  String toString() {
    return 'ACommunication{_ip: $ip, _port: $port}';
  }

  @override
  Future<void> connect() async {
    // pass-UDP Protocol
    socket == null
        ? socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
        : nullptr;
  }

  @override
  Future<void> disconnect() async {
    // pass-UDP Protocol
    socket!.close();
  }

  @override
  Future<void> send(Model model) async {
    final message = jsonEncode(model.toJson());
    final encodedMessage = utf8.encode(message);
    await connect();
    socket!.send(encodedMessage, InternetAddress(ip), port);
    // print(message);
  }
}

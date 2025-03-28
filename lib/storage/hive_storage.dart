import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  static const String _authBox = "authBox";
  static Box<dynamic>? _box;

  static Future<void> init() async {
    if (!Hive.isBoxOpen(_authBox)) {
      _box = await Hive.openBox(_authBox);
    } else {
      _box = Hive.box(_authBox);
    }
  }

  Future<void> saveToken(String token) async {
    await init(); // Ensure box is opened before using it
    await _box?.put("token", token);
  }

  String? getToken() {
    return _box?.get("token");
  }

  Future<void> clearToken() async {
    await init();
    await _box?.delete("token");
  }
}


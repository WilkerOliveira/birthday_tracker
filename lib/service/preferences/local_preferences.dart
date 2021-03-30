import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences {
  static final LocalPreferences _instance = LocalPreferences._();

  LocalPreferences._();

  static LocalPreferences get instance => _instance;

  factory LocalPreferences() {
    return _instance;
  }

  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('userId') ?? "");
  }
}

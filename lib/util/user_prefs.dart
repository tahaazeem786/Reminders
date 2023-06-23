import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _preferences;

class UserPrefs {
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //Setter Methods
  static Future setString(String key, String s) async {
    await _preferences?.setString(key, s);
  }

  static Future setInt(String key, int number) async {
    await _preferences?.setInt(key, number);
  }

  static Future setStringList(String key, List<String> list) async {
    await _preferences?.setStringList(key, list);
  }

  static Future remove(String key) async {
    await _preferences?.remove(key);
  }

  //Getter Methods
  static Future<String?> getString(String key) async {
    print(await _preferences?.getString(key));
    return await _preferences?.getString(key) ?? '';
  }

  static Future getStringList(String key) async {
    return await _preferences?.getStringList(key);
  }

  static Future<bool?> getBool(String key) async {
    return await _preferences?.getBool(key);
  }

  static Future<int?> getInt(String key) async {
    return await _preferences?.getInt(key);
  }

  static Future<bool?> containsKey(String key) async {
    return await _preferences?.containsKey(key);
  }
}

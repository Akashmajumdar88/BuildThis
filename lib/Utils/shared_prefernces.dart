import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static SharedPreferences? _sharedPreferences;

  static Future<SharedPreferences> getSharedPreferences() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }
}
class UserLoginDetails{
  Future<void>  setUserData(key , text )async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }

  Future<String> getUserData(key)async{
    final prefs = await SharedPreferences.getInstance();
    String? text= prefs.getString(key);
    print("share pre data -------------------------- $text");
    return text.toString();
  }
  remove(key)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
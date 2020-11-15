import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  Future<int> get userId async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getInt('userId') ?? 0;
  }

  setUserId(int userId) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setInt('userId', userId);
  }

  deleteUserId() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.remove('userId');
  }
}

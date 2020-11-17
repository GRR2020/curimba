import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferences _sharedPrefs;

  Future<int> get userId async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
    return _sharedPrefs.getInt('userId') ?? 0;
  }

  setUserId(int userId) async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
    _sharedPrefs.setInt('userId', userId);
  }

  deleteUserId() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
    _sharedPrefs.remove('userId');
  }
}

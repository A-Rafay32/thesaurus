import "package:shared_preferences/shared_preferences.dart";

class UserPreferences {
  static SharedPreferences? _preferences;
  static List<String> starredKeyList = [];
  static String historyKey = "history";
  static String starredKey = "starred";
  static int index = 0;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setHistoryList(List<String> list) async {
    await _preferences?.setStringList(historyKey, list);
  }

  static List<String>? getHistoryList() {
    return _preferences?.getStringList(historyKey);
  }

  static Future deleteHistory() async {
    await _preferences?.remove(historyKey);
  }

  static Future deleteHistoryWord(String word) async {
    List<String> temp = _preferences?.getStringList(historyKey) as List<String>;
    temp.remove(word);
    await _preferences?.setStringList(historyKey, temp);
  }

  static Future setStarredList(List<String> list) async {
    await _preferences?.setStringList(starredKey, list);
  }

  static List<String>? getStarredList() {
    return _preferences?.getStringList(starredKey);
  }

  static Future deleteStarredWord(String word) async {
    List<String> temp = _preferences?.getStringList(starredKey) as List<String>;
    temp.remove(word);
    await _preferences?.setStringList(starredKey, temp);
  }

  static Future deleteStarred() async {
    await _preferences?.remove(starredKey);
  }
}

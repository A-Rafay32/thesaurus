import "package:flutter/material.dart";
import 'package:thesaurus/model/shared_prefs.dart';
import '../view_model/thesaurus.dart';

class Model extends ChangeNotifier {
  late Thesaurus thesaurus;
  static List<String> history = [];
  static List<String> starred = [];
  static String searchedWord = '';
  static List<String>? historypref;
  static List<String>? starredpref;
  final TextEditingController controller = TextEditingController();

  void onSubmitted(String value) {
    Model().controller.text = value;
    int index = 0;
    print("_controller.text : ${controller.text}");
    searchedWord = value;
    controller.text = searchedWord;
    print("Searched Word : $searchedWord ");
    history.add(searchedWord);
    // UserPreferences.setHistoryWord(searchedWord);
    // historypref?.add(UserPreferences.getHistoryWord(index));
    // index++;
    // to set the recent changing list
    UserPreferences.setHistoryList(history);
    // to update the recent changing list on history card
    historypref = UserPreferences.getHistoryList();
    if (starred.contains(searchedWord)) {
      Thesaurus.isStarred = true;
    } else {
      Thesaurus.isStarred = false;
    }
    notifyListeners();
  }

  void reloadHistory() {
    Model.history = UserPreferences.getHistoryList() ?? [];
    notifyListeners();
  }

  void reloadStarred() {
    Model.starred = UserPreferences.getStarredList() ?? [];
    notifyListeners();
  }

  void SwitchStarred(String word) {
    int index = 0;
    if (Thesaurus.isStarred) {
      starred.remove(word);
      UserPreferences.setStarredList(starred);
      starredpref = UserPreferences.getStarredList();
      Thesaurus.isStarred = false;
      --index;
      notifyListeners();
      print("$word removed from Starred");
    } else {
      if (starred.contains(word)) {
        starred.remove(word);
        UserPreferences.setStarredList(starred);
        starredpref = UserPreferences.getStarredList();
        --index;
        Thesaurus.isStarred = false;
        notifyListeners();
        print("$word removed from Starred");
      }
      starred.add(word);
      UserPreferences.setStarredList(starred);
      starredpref = UserPreferences.getStarredList();
      index++;
      Thesaurus.isStarred = true;
      print("$word added to Starred");
      notifyListeners();
    }
  }

  void deleteHistory() {
    history.clear();
    UserPreferences.deleteHistory();
    historypref = UserPreferences.getHistoryList() ?? [];
    print("history cleared  ${history.length}");
    notifyListeners();
  }

  void deleteHistoryWord(String word) {
    history.remove(word);
    UserPreferences.deleteHistoryWord(word);
    historypref = UserPreferences.getHistoryList() ?? [];
    notifyListeners();
  }

  void deleteStarred() {
    starred.clear();
    UserPreferences.deleteStarred();
    starredpref = UserPreferences.getStarredList() ?? [];
    print("starred cleared  ${starred.length}");
    notifyListeners();
  }

  void deleteStarredWord(String word){
    starred.remove(word);
    UserPreferences.deleteStarredWord(word);
    starredpref = UserPreferences.getStarredList();
    notifyListeners();
  }
}

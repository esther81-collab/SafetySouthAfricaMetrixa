import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  SharedPreferences? _prefs;
  Set<String> saved = {};

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    saved = (_prefs!.getStringList('saved') ?? []).toSet();
  }

  bool isSaved(String id) => saved.contains(id);

  void toggleSaved(String id) {
    saved.contains(id) ? saved.remove(id) : saved.add(id);
    _prefs?.setStringList('saved', saved.toList());
    notifyListeners();
  }
}

final appState = AppState();
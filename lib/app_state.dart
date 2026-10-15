import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'strings.dart';

class MyContact {
  final String name, number;
  const MyContact(this.name, this.number);
}

class AppState extends ChangeNotifier {
  SharedPreferences? _prefs;
  Set<String> saved = {};
  Set<String> subscribed = {};
  List<MyContact> contacts = [];
  String lang = 'en';
  bool dailyTips = true;
  bool alerts = false;

  String t(String key) => strings[lang]?[key] ?? strings['en']![key] ?? key;

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    saved = (_prefs!.getStringList('saved') ?? []).toSet();
    subscribed = (_prefs!.getStringList('subs') ?? []).toSet();
    lang = _prefs!.getString('lang') ?? 'en';
    dailyTips = _prefs!.getBool('daily') ?? true;
    alerts = _prefs!.getBool('alerts') ?? false;
    contacts = (_prefs!.getStringList('contacts') ?? []).map((s) {
      final i = s.indexOf('|');
      return MyContact(s.substring(0, i), s.substring(i + 1));
    }).toList();
  }

  bool isSaved(String id) => saved.contains(id);

  void toggleSaved(String id) {
    saved.contains(id) ? saved.remove(id) : saved.add(id);
    _prefs?.setStringList('saved', saved.toList());
    notifyListeners();
  }

  void toggleSub(String id) {
    subscribed.contains(id) ? subscribed.remove(id) : subscribed.add(id);
    _prefs?.setStringList('subs', subscribed.toList());
    notifyListeners();
  }

  void setLang(String l) {
    lang = l;
    _prefs?.setString('lang', l);
    notifyListeners();
  }

  void setDaily(bool v) {
    dailyTips = v;
    _prefs?.setBool('daily', v);
    notifyListeners();
  }

  void setAlerts(bool v) {
    alerts = v;
    _prefs?.setBool('alerts', v);
    notifyListeners();
  }

  void _saveContacts() {
    _prefs?.setStringList(
        'contacts', contacts.map((c) => '${c.name}|${c.number}').toList());
    notifyListeners();
  }

  void addContact(MyContact c) {
    contacts.add(c);
    _saveContacts();
  }

  void removeContact(MyContact c) {
    contacts.remove(c);
    _saveContacts();
  }
}

final appState = AppState();
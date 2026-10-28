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
  bool isLoggedIn = false;
  String userEmail = '';
  String registeredEmail = '';
  String registeredPassword = '';

  String t(String key) => strings[lang]?[key] ?? strings['en']![key] ?? key;

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    saved = (_prefs!.getStringList('saved') ?? []).toSet();
    subscribed = (_prefs!.getStringList('subs') ?? []).toSet();
    lang = _prefs!.getString('lang') ?? 'en';
    dailyTips = _prefs!.getBool('daily') ?? true;
    alerts = _prefs!.getBool('alerts') ?? false;
    isLoggedIn = _prefs!.getBool('isLoggedIn') ?? false;
    userEmail = _prefs!.getString('userEmail') ?? '';
    registeredEmail = _prefs!.getString('regEmail') ?? '';
    registeredPassword = _prefs!.getString('regPass') ?? '';
    contacts = (_prefs!.getStringList('contacts') ?? []).map((s) {
      final i = s.indexOf('|');
      return MyContact(s.substring(0, i), s.substring(i + 1));
    }).toList();
  }

  Future<void> login(String email) async {
    isLoggedIn = true;
    userEmail = email;
    await _prefs?.setBool('isLoggedIn', true);
    await _prefs?.setString('userEmail', email);
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    registeredEmail = email;
    registeredPassword = password;
    await _prefs?.setString('regEmail', email);
    await _prefs?.setString('regPass', password);
    await login(email);
  }

  Future<bool> loginWithCredentials(String email, String password) async {
    // If no account has been registered yet, allow sign in and register it
    if (registeredEmail.isEmpty) {
      await register(email, password);
      return true;
    }
    // Verify credentials
    if (email.trim().toLowerCase() == registeredEmail.toLowerCase() &&
        password == registeredPassword) {
      await login(email);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    isLoggedIn = false;
    userEmail = '';
    await _prefs?.setBool('isLoggedIn', false);
    await _prefs?.remove('userEmail');
    notifyListeners();
  }

  bool isSaved(String id) => saved.contains(id);
  bool isSubscribed(String id) => subscribed.contains(id);

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

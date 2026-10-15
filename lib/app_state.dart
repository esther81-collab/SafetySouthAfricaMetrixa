import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyContact {
  final String name, number;
  const MyContact(this.name, this.number);
}

class AppState extends ChangeNotifier {
  SharedPreferences? _prefs;
  Set<String> saved = {};
  List<MyContact> contacts = [];

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    saved = (_prefs!.getStringList('saved') ?? []).toSet();
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
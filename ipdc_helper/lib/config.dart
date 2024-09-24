import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config extends ChangeNotifier {
  Config._();

  static final Config _instance = Config._();

  static Config get instance => _instance;

  late final SharedPreferences _preferences;

  bool _showReadyDialog = true;

  bool get showReadyDialog => _showReadyDialog;

  set showReadyDialog(bool value) {
    _showReadyDialog = value;
    _preferences.setBool('beginDialog', _showReadyDialog);
  }

  bool _showCorrectAnswer = false;

  bool get showCorrectAnswer => _showCorrectAnswer;

  set showCorrectAnswer(bool value) {
    _showCorrectAnswer = value;
    _preferences.setBool('showCorrect', _showCorrectAnswer);
  }

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode mode) {
    _themeMode = mode;
    _preferences.setString('themeMode', _themeMode.name);
    notifyListeners();
  }

  Future<void> initSP() async {
    WidgetsFlutterBinding.ensureInitialized();
    _preferences = await SharedPreferences.getInstance();

    switch (_preferences.getString('themeMode')) {
      case 'system':
        break;
      case 'light':
        _themeMode = ThemeMode.light;
        break;
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      case null:
        _preferences.setString('themeMode', _themeMode.name);
        break;
    }

    switch (_preferences.getBool('beginDialog')) {
      case true:
        break;
      case false:
        _showReadyDialog = false;
        break;
      case null:
        _preferences.setBool('beginDialog', _showReadyDialog);
        break;
    }

    switch (_preferences.getBool('showCorrect')) {
      case true:
        _showCorrectAnswer = true;
        break;
      case false:
        break;
      case null:
        _preferences.setBool('showCorrect', _showCorrectAnswer);
        break;
    }
  }
}

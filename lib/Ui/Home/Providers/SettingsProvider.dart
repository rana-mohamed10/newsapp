import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier{
  SharedPreferences? preference;
  String currentLocale='en';


  void changeLang(String locale) {
    if (currentLocale == locale) return;
    currentLocale = locale;
    saveLocale(locale);
    notifyListeners();
  }


  Future<void> saveLocale(String locale) async {
    await preference?.setString('language', locale);
  }


  String? getLocale(){
    return preference?.getString('language');
  }
  Future<void> loadLocale() async {
    preference = await SharedPreferences.getInstance();
    String? locale = getLocale();
    if (locale != null) {
      currentLocale = locale == 'en' ? 'en' : 'ar';
    }
  }

}
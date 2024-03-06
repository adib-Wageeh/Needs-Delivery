import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier{

  Locale? _locale;

  Locale? get getLocale => _locale;
  
  void initLang()async{
    
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('lang');
    
    if(lang == null || lang == 'ar'){
      _locale = const Locale('ar');
    }else{
      _locale = const Locale('en');
    }
    notifyListeners();
  }

  Future<String> getSwitchLang()async{

    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('lang');

    if(lang == null || lang == 'ar'){
      return 'en';
    }
      return 'ar';

  }

  void switchLang()async{

    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('lang');

    if(lang == null || lang == 'ar'){
      _locale = const Locale('en');
      prefs.setString('lang', 'en');
    }else{
      _locale = const Locale('ar');
      prefs.setString('lang', 'ar');
    }
    notifyListeners();
  }

  void changeLang(Locale locale)async{

    final prefs = await SharedPreferences.getInstance();
    if(locale.languageCode == _locale!.languageCode) return;

    if(locale.languageCode == 'en'){
      prefs.setString('lang', 'en');
    }else{
      prefs.setString('lang', 'ar');
    }
    initLang();
  }

}
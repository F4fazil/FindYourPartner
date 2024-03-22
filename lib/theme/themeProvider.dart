import 'package:chatapp/theme/dark_theme.dart';
import 'package:chatapp/theme/light_theme.dart';
import 'package:flutter/material.dart';
class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData=light_theme;

  ThemeData get themedata=>_themeData;
  bool get isdark=>_themeData==dark_theme;
  set(ThemeData theme){
    _themeData=theme;
    notifyListeners();
  }
   toggle(){
    if(_themeData==light_theme) {
      _themeData = dark_theme;
      notifyListeners();
    }
      else{
        _themeData=light_theme;
        notifyListeners();
    }
    }
  }
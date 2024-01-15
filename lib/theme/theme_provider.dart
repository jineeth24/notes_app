import 'package:flutter/material.dart';
import 'package:notesapp/theme/theme.dart';
import 'package:provider/provider.dart';
class ThemeProvider extends ChangeNotifier{
  //theme initially
  ThemeData _themeData=lightMode;
  //getter
  ThemeData get themeData=>_themeData;


  //
  bool get isDarkMode =>_themeData==darkMode;

  //setter
  set themeData(ThemeData  newTheme){
    _themeData=newTheme;
    notifyListeners();
  }

  //toggle method
  void toggleTheme(){
    if(_themeData==lightMode){
      themeData=darkMode;
    }
    else{
     themeData=lightMode;
    }
  }
}
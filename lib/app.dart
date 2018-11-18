import 'package:conter/screens/index.dart';
import 'package:conter/styles/style.dart';
import 'package:flutter/material.dart';

class App {
  static processMain() async {
    runApp(new MaterialApp(
      title: "Itis.cards",
      home: new HomeScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: StyleColors.primary,
        accentColor: StyleColors.accent,
      ),
    ));
  }
}

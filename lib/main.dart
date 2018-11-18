import 'package:conter/app.dart';
import 'package:conter/models/config.dart';
import 'package:flutter/services.dart';
import 'package:conter/services/database.dart';

void main() {
  startHome();
}

void startHome() async {
  var db = DataBase();
  if (!await db.open()) {
    await db.open();
  }
  await Config.loadFromDB();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  App.processMain();
}

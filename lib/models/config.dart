import 'dart:async';
import 'dart:convert';

import 'package:conter/services/database.dart';

class Config {
  static final String dbName = "choolo";
  static final int dbVersion = 1;

  static Future loadFromDB() async {}

  static Future saveToDB() async {}

  static Future saveRow(String key, dynamic value, {String keyPrefix}) {
    if (keyPrefix != null) key = keyPrefix + key;
    var db = new DataBase();
    return db.updateOrInsert("config", {"key": key, "value": value});
  }

  static Future<dynamic> loadRow(String key, {String keyPrefix}) {
    if (keyPrefix != null) key = keyPrefix + key;
    var db = new DataBase();
    return db.getField("config", key, "value", filterField: "key");
  }

  static Future saveMap(Map<String, dynamic> data, String keyPrefix) {
    var db = new DataBase();
    List<Map<String, dynamic>> list = [];
    data.forEach((String k, dynamic v) {
      if (v is Map || v is List) json.encode(v);
      if (v is bool) v = v ? "1" : "0";
      list.add({"key": keyPrefix + k, "value": v});
    });
    return db.insertList("config", list);
  }

  static Future<Map<String, dynamic>> load(String keyPrefix) async {
    var db = new DataBase();
    Map<String, dynamic> data = {};
    var _ = (await db.filterLike("key", keyPrefix + "%").get<Map<String, dynamic>>("config"))
        .forEach((_) => data[(_['key'] as String).substring(keyPrefix.length)] = _['value']);
    print(data);
    return data;
  }

  static void dump() async {
    await new DataBase().get<Map>("config", callback: (row) {
      print(row['key'] + " - " + row['value'].toString());
    });
  }
}

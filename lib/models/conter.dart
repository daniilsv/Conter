import 'dart:async';
import 'package:conter/services/database.dart';
import 'package:conter/widgets/conter.dart';
import 'package:flutter/material.dart';

class Conter {
  int id;
  String title;
  int count;

  bool isDeleted = false;
  Conter({this.id = 0, this.title, this.count = 0});

  GlobalKey<ConterWidgetState> _key = new GlobalKey<ConterWidgetState>();
  FocusNode get titleFocusNode => _key.currentState.titleFocusNode;

  Widget buildRow() {
    return ConterWidget(key: _key, item: this);
  }

  factory Conter.fromJson(Map<String, dynamic> data) {
    return new Conter(
        id: data['id'] is String ? int.parse(data['id']) : (data['id'] ?? 0),
        title: data['title'].toString(),
        count: data["count"]);
  }

  Map<String, dynamic> toJson() {
    if (id == 0)
      return <String, dynamic>{
        "title": this.title,
        "count": this.count.toString(),
      };
    else
      return <String, dynamic>{
        "id": this.id.toString(),
        "title": this.title,
        "count": this.count.toString(),
      };
  }

  Future save() async {
    int id = await DataBase().updateOrInsert("conters", toJson());
    this.id = id;
    return;
  }

  Future delete() async {
    isDeleted = true;
    if (id != 0) DataBase().delete("conters", id);
    return;
  }
}

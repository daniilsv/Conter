import 'package:conter/models/conter.dart';
import 'package:conter/services/database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Conter> list = [];
  @override
  void initState() {
    super.initState();
    loadConters();
  }

  @override
  void dispose() {
    super.dispose();
  }

  createConter() {
    Conter conter = Conter();
    list.add(conter);
    setState(() {});
    Future.delayed(Duration(seconds: 1)).then((_) => FocusScope.of(context).requestFocus(conter.titleFocusNode));
  }

  Widget buildCreateButton() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            iconSize: 64,
            icon: Icon(Icons.add_circle_outline),
            onPressed: createConter,
          ),
          Text("Нажмите + чтобы добавить счетчик")
        ],
      ),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: list.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == list.length) {
          return buildCreateButton();
        }
        Conter item = list[index];
        return item.buildRow();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildList());
  }

  void loadConters() async {
    DataBase db = DataBase();
    list = await db.get<Conter>("conters", callback: (_) => Conter.fromJson(_));
    setState(() {});
  }
}

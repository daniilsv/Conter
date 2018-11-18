import 'package:conter/models/conter.dart';
import 'package:conter/styles/style.dart';
import 'package:flutter/material.dart';

class ConterWidget extends StatefulWidget {
  final Conter item;
  ConterWidget({Key key, this.item}) : super(key: key);
  ConterWidgetState createState() => ConterWidgetState();
}

class ConterWidgetState extends State<ConterWidget> {
  TextEditingController _titleController;
  FocusNode titleFocusNode;
  bool saveVisible = false;
  minus() {
    widget.item.count--;
    setState(() {});
    widget.item.save();
  }

  plus() {
    widget.item.count++;
    setState(() {});
    widget.item.save();
  }

  saveTitle() {
    widget.item.title = _titleController.text;
    saveVisible = false;
    titleFocusNode.unfocus();
    setState(() {});
    widget.item.save();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.isDeleted) return Container();
    Size size = MediaQuery.of(context).size;
    if (_titleController == null) {
      _titleController = TextEditingController(text: widget.item.title ?? "");
      _titleController.addListener(() {
        saveVisible = _titleController.text != widget.item.title;
        setState(() {});
      });
    }
    if (titleFocusNode == null) titleFocusNode = FocusNode();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: StyleColors.primaryLight),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.delete_forever,color: StyleColors.primaryLight,),
                iconSize: 32,
                padding: EdgeInsets.all(0),
                onPressed: delete,
              ),
              Container(
                constraints: BoxConstraints.expand(width: size.width * .6, height: 48),
                child: TextField(
                  controller: _titleController,
                  focusNode: titleFocusNode,
                  textAlign: TextAlign.center,
                  onEditingComplete: saveTitle,
                  decoration: InputDecoration(
                    hintText: "Название",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                  ),
                ),
              ),
              saveVisible
                  ? IconButton(
                      icon: Icon(Icons.check),
                      iconSize: 32,
                      padding: EdgeInsets.all(0),
                      onPressed: saveTitle,
                    )
                  : Container(width: 48),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: minus,
              ),
              Text(
                widget.item.count.toString(),
                style: TextStyle(fontSize: 24),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: plus,
              ),
            ],
          )
        ],
      ),
    );
  }

  void delete() async {
    bool confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Удалить счетчик ${widget.item.title}"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Отмена"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            new FlatButton(
              child: new Text("Удалить"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
    if (!confirm) return;
    widget.item.delete();
    setState(() {});
  }
}

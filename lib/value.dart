import 'package:flutter/material.dart';
import 'function/dateFunc.dart';
import 'sqlite.dart';
import 'main.dart';
import 'drawerMenu.dart';
//main.dartから受け取るデータをもとに内容を表示

class ValueList extends StatefulWidget {
  String catch_title; //main.dartから受け取った科目名
  String catch_key; //main.dartから受け取ったキーワード
  String catch_id; //main.dartから受け取ったid

  ValueList({this.catch_title, this.catch_key, this.catch_id}); //受け取った変数の値をセット
  @override
  _ValueListState createState() =>
      _ValueListState(title: catch_title, keyword: catch_key, id: catch_id);
}

class _ValueListState extends State<ValueList> {
  String title;
  String keyword;
  String id;
  List<String> listItem;

  _ValueListState({this.title, this.keyword, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text("${date(0)}　学習内容"),backgroundColor: Colors.blueGrey.withOpacity(0.5)),
        drawer: Drawer(
          child: drawerMenu(context),
        ),
        //stack 背景設定
        body: Stack(
        children: <Widget>[
          new Container(
            height: double.infinity,
            width: double.infinity,
            decoration:new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          showText(context, title, keyword, id)
        ]));   
  }
}
//内容を表示する処理
Widget showText(BuildContext context, String title, String keyword, String id) {
  return Container(
      child: Column(
    children: <Widget>[
      Container(
        margin: const EdgeInsets.only(top: 15.0),
        child: Text("科目名"),
      ), //科目名
      Center(
        //科目名内容
        child: Container(
            width: 300.0,
            margin:
                const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: new Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 20.0),
              ),
            )),
      ),
      Container(
        margin: const EdgeInsets.only(top: 1.0),
        child: Text("キーワード"),
      ), //キーワード
      Center(
        //キーワード内容
        child: Container(
            width: 300.0,
            margin: const EdgeInsets.only(top: 1.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: new Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                keyword,
                style: TextStyle(fontSize: 20.0),
              ),
            )),
      ),
      Center(
        //compleate 学習完了処理
        child: Container(
          width: 200.0,
          margin: const EdgeInsets.only(top: 20.0),
          padding: const EdgeInsets.all(10.0),
          child: RaisedButton(
            child: Text("Complete!"),
            onPressed: () async{
              await completeStudy(id);
              //Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  //settings: RouteSettings(name: "/rooms/<roomId>"),
                  builder: (BuildContext context) =>
                      MyApp(), //引数に県ナンバーを挿入して値を渡す
                ));
            },
            highlightElevation: 16.0,
            highlightColor: Colors.blue,
            onHighlightChanged: (value) {},
          ),
        ),
      ),
    ],
  ));
}

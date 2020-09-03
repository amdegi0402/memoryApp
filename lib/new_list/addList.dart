import 'package:flutter/material.dart';
import '../function/dateFunc.dart';
import '../sqlite.dart';
import '../main.dart';
import 'allList.dart';
import '../drawerMenu.dart';

class AddList extends StatefulWidget {
  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  final myController_1 = TextEditingController();
  final myController_2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("${date(0)}　新規追加"),
            backgroundColor: Colors.pink.withOpacity(0.5)),
        drawer: Drawer(
          child: drawerMenu(context),
        ),
        body: Stack(children: <Widget>[
          new Container(
            height: double.infinity,
            width: double.infinity,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              //Padding(padding: EdgeInsets.all(10.0), child: Text(date(0))),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  obscureText: false, //文字にマスク処理 true or false
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '科目名',
                  ),
                  controller: myController_1,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'キーワード（任意）',
                  ),
                  controller: myController_2,
                ),
              ),
              RaisedButton(
                child: Text("登録"),
                shape: UnderlineInputBorder(),
                onPressed: () async {
                  if (myController_1.text == "") {
                    print("科目名が入力されていません");
                  } else {
                    var str = myController_1.text;
                    var key = myController_2.text;
                    if (key == null) {
                      addDatabase(str, date(0));
                    } else {
                      addDatabase(str, date(0), key);
                    }

                    print(myController_1.text);
                    print(myController_2.text);
                    myController_1.clear();
                    myController_2.clear();

                    //完了ダイアログ表示
                    var result = await showDialog<int>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text('登録完了'),
                          actions: <Widget>[
                            FlatButton(
                                child: Text('OK'),
                                //onPressed: () => Navigator.of(context).pop(),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute<Null>(
                                        builder: (BuildContext context) =>
                                            MyApp2(),
                                      ));
                                }),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ]));
  }
}
/*
//drawerメニューリスト
Widget drawerMenu(BuildContext context) {
  return ListView(
    children: <Widget>[
      /*DrawerHeader(
              child: Text("Drawer", style: TextStyle(fontSize: 24, color: Colors.blue,),),
              decoration: BoxDecoration(color: Colors.black,),
            ),*/
      ListTile(
          leading: Icon(Icons.grade),
          title: Text(
            "HOME",
            style: TextStyle(fontSize: 18),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  //settings: RouteSettings(name: "/rooms/<roomId>"),
                  builder: (BuildContext context) =>
                      MyApp(), //引数に県ナンバーを挿入して値を渡す
                ));
          }),
      ListTile(
          leading: Icon(Icons.grade),
          title: Text(
            "新規追加",
            style: TextStyle(fontSize: 18),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  //settings: RouteSettings(name: "/rooms/<roomId>"),
                  builder: (BuildContext context) =>
                      AddList(), //引数に県ナンバーを挿入して値を渡す
                ));
          }),
      ListTile(
          leading: Icon(Icons.grade),
          title: Text(
            "リスト一覧",
            style: TextStyle(fontSize: 18),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  //settings: RouteSettings(name: "/rooms/<roomId>"),
                  builder: (BuildContext context) =>
                      AllList(), //引数に県ナンバーを挿入して値を渡す
                ));
          }),
    ],
  );
}*/

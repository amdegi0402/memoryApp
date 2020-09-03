import 'package:flutter/material.dart';
import '../../function/dateFunc.dart';
import '../../sqlite.dart';
import '../../main.dart';
import '../../drawerMenu.dart';
import '../allList.dart';

/*リスト内編集ファイル*/

class EditList extends StatefulWidget {
  String catch_id; //main.dartから受け取ったid

  EditList({this.catch_id}); //受け取った変数の値をセット

  @override
  State createState() {
    return EditListState(id: catch_id);
  }
}

class EditListState extends State<EditList> {
  String title;
  String keyword;
  String id;

  TextEditingController controller_title;
  TextEditingController controller_keyword;

  //List<String> listItem;

  EditListState({this.id});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var data = readEditValue(id); //タイトル,キーワード読み込み
    data.then((var ndatas) => setState(() {
          title = ndatas[0];
          keyword = ndatas[1];
          controller_title = TextEditingController(text: title);
          controller_keyword = TextEditingController(text: keyword);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.transparent,
        appBar: AppBar(
            title: Text("学習内容を編集"),
            backgroundColor: Colors.blueGrey.withOpacity(0.5)),
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
          //showText(context, title, keyword, id)
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  obscureText: false, //文字にマスク処理 true or false
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '科目名',
                  ),
                  controller: controller_title,
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
                  controller: controller_keyword,
                ),
              ),
              RaisedButton(
                child: Text("登録"),
                shape: UnderlineInputBorder(),
                onPressed: () async {
                  //編集内容を更新する処理
                  String title = controller_title.text;
                  String keyword = controller_keyword.text;
                  //print("keyword->$controller_keyword.text");
                  updateEditList(id, title, keyword);

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
                            onPressed: () => Navigator.of(context).pop(1),
                            /*
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<Null>(
                                    builder: (BuildContext context) =>
                                        MyApp2(),
                                  ));
                            }
                            */
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ]));
  }
}
// StatelessWidgetを使用する
// TextFieldの変更が反映されない
/*
class MyStatelessWidget extends StatelessWidget {
  TextEditingController controller;

  MyStatelessWidget() {
    controller = TextEditingController(text: "default1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyStatelessWidget"),
      ),
      body: TextField(
        controller: controller,
      ),
    );
  }
}


// StatefullWidgetを使用する
// TextFieldの変更が反映される
class MyStatefullWidget extends StatefulWidget {
  @override
  State createState() {
    return MyStatefullWidgetState();
  }
}

class MyStatefullWidgetState extends State<MyStatefullWidget> {
  TextEditingController controller;

  MyStatefullWidgetState() {
    controller = TextEditingController(text: "test");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyStatelessWidget"),
      ),
      body: TextField(
        controller: this.controller,
      ),
    );
  }
}
*/

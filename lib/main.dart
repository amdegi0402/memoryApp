import 'package:flutter/material.dart';
import 'sqlite.dart';
import 'function/dateFunc.dart';
import 'function/dateFunc_2.dart';
import 'value.dart';
import 'drawerMenu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Baby Names",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController_1 = TextEditingController();
  final myController_2 = TextEditingController();
  List<String> title = [];
  List<String> keyword = [];
  List<String> id = [];

  /*ページ初期時のデータベース関係の処理*/
  _initReadStudyDays() async {
    await createDatabase(); //データベース接続
    await updateDb(date(0)); //juge判定　学習日と今日の日付が一致していればjuge=1
    var result_1 = await readStudyDays(0, date(0)); //タイトル読み込み
    var result_2 = await readStudyDays(1, date(0)); //キーワード読み込み
    var result_3 = await readStudyDays(5, date(0)); //ID読み込み
    setState(() {
      title = result_1;
      keyword = result_2;
      id = result_3;
    });
  }

  /*復習日を過ぎた未学習の項目を本日の日付に変更する処理*/
  _initChangeStudyDay() {
    //次回の学習日と今日の日付を比較して今日の日付より古ければ今日の日付に変える
    //日付比較判定処理
    updateNextNum(calcToday(), date(0));
  }

  @override
  initState() {
    super.initState();
    _initChangeStudyDay();
    _initReadStudyDays(); //データベース処理
  }

  @override
  Widget build(BuildContext context) {
    var val = calcDateNumber();
    var result = calcDate(val);
    return Scaffold(
        appBar: AppBar(
            title: Text("${date(0)}　反復学習リスト"),
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
          listViewes(context, title, keyword, id),
        ]));
  }
}

Widget listViewes(BuildContext context, var title, var key, var id) {
  if (title == null) {
    print("titleはnull");
    return Center(child: Text("本日のタスクはありません"));
  } else {
    print("titleはnullではありません");
    return ListView.separated(
        //ListView.separatedでリストに区切り線を表示する
        itemCount: title.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.black,
            ),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
                leading: Icon(Icons.grade),
                title: Text("${title[index]}"),
                subtitle: Text(key[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ValueList(
                          catch_title: title[index],
                          catch_key: key[index],
                          catch_id: id[
                              index]), //次のページへ　科目名,キーワード,idを渡す処理　ValueListクラスが呼び出される value.dart
                    ),
                  );
                }),
          );
        });
  }
}

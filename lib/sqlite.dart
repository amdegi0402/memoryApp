import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'function/dateFunc.dart';

//database start
createDatabase() async {
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my.db'); //データベース　テーブル作成

  var database =
      await openDatabase(dbPath, version: 1, onCreate: populateDb); //
  //print("データベース登録OK");
  //var result = await database.rawQuery("select count(id) from MyDatas");
}

//create
//テーブルrowを設定
void populateDb(Database database, int version) async {
  //id:プライマリキー title:科目名 add_day:登録した日付（初日),next_day:次の復習日付, keyword:キーワード, level:現在の記憶レベル（Lv6で完了）,juge:判定 0 or 1 学習日は1, next_value: 次の学習日を表す数値（2019/01/05 = 2019*10000 + 1*100 + 5)
  await database.execute(
      // "CREATE TABLE MyDatas(id INTEGER PRIMARY KEY, title TEXT, day_0 TEXT, day_1 TEXT, day_4 TEXT, day_7 TEXT, day_11 TEXT, day_15 TEXT, day_20 TEXT, keyword TEXT, level INTEGER, juge INTEGER)");
      "CREATE TABLE MyDatas(id INTEGER PRIMARY KEY, title TEXT, add_day TEXT, next_day TEXT, keyword TEXT, level INTEGER, juge INTEGER, next_number INTEGER)");
}

//update 本日の日付と学習日(next_day)が同じであればjugeを1に変更
updateDb(String today) async {
  //databaseへ接続
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my.db');
  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
  //指定テーブルから選択したデータのsel値を更新　0->1
  await database.rawQuery('UPDATE MyDatas SET juge=1 WHERE next_day="$today"');
  //print("UPDATE compleate!");
}

//update 削除したリストのresultを0に変更（これによりリスト検索から外れるようにする）
deleteDb(String listName) async {
  //databaseへ接続
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my.db');
  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
  //指定テーブルから選択した山データのsel値を更新　0->1
  await database.rawQuery('DELETE FROM MyDatas WHERE title="$listName"');
  //print("DELETE compleate!");
}

//addDatabase(String title, String day_1, String day_4, String day_7, String day_11, String day_15, String day_20) async{
addDatabase(String title, String add_day, [String keyword = "なし"]) async {
  int juge = 0;
  int level = 0;
  //String next_day = date(1);

  //データベース接続
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my.db'); //データベース　テーブル作成
  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);

  Map<String, int> result = calcInitNextVal(); //next_numberとnext_dayを計算
  print("map=${result}");
  String keys = result.keys.toString();
  String next_day = keys.substring(1, keys.length - 1); //Map格納のnext_dayを文字型へ変換
  String val = result.values.toString();
  int next_number = changeToInt(val.substring(1, val.length - 1));
  print("nextNUmber = $next_number");
  
  //データベースへ値を挿入
  database.transaction((txn) async {
    await txn.rawInsert(
        'INSERT INTO MyDatas(title, add_day, next_day, keyword, level, juge, next_number) VALUES("$title", "$add_day", "$next_day", "$keyword", "$level", "$juge", "$next_number")');
    //print("databaseOK");
  });
}

//本日の復習リストを読み込み(引数num 0:タイトルを返す(学習が完了していないもの）　1:キーワードを返す 2:すべてのリストタイトルを返す 3:学習登録日を返す 4:現在のレベルを返す 5:IDを返す（学習未完了）6:次の学習日を返す 7:登録されているすべてのIDを返す 8:juge=1 学習未完了日があるタイトルをすべて返す
Future readStudyDays(int num, [String days]) async {
  List<String> data = [];

  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my.db');
  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
  //本日の日付と学習日が一致したものをリストへ挿入
  //print("days=$days");
  if (num == 0) {
    //var value = await database.rawQuery('SELECT title FROM MyDatas');
    var value =
        await database.rawQuery('SELECT title FROM MyDatas WHERE juge=1');
    //print("科目名={$value}");
    //print("データは${value.length}");
    for (var i = 0; i < value.length; i++) {
      data.add(value[i]["title"].toString());
    }
  } else if (num == 1) {
    //var value = await database.rawQuery('SELECT keyword FROM MyDatas');
    var value =
        await database.rawQuery('SELECT keyword FROM MyDatas WHERE juge=1');
    //print("value=$value");
    for (var i = 0; i < value.length; i++) {
      data.add(value[i]["keyword"].toString());
    }
  } else if (num == 2) {
    var value = await database.rawQuery('SELECT title FROM MyDatas');
    //print(value);
    for (var i = 0; i < value.length; i++) {
      data.add(value[i]["title"].toString());
    }
  } else if (num == 3) {
    var value = await database.rawQuery('SELECT add_day FROM MyDatas');
    for (var i = 0; i < value.length; i++) {
      data.add(value[i]["add_day"].toString());
    }
  } else if (num == 4) {
    var value = await database.rawQuery('SELECT level FROM MyDatas');
    for (var i = 0; i < value.length; i++) {
      data.add(value[i]["level"].toString());
      //print(value[i]["level"].toString());
    }
  } else if (num == 5) {
    var value = await database.rawQuery('SELECT id FROM MyDatas WHERE juge=1');
    for (var i = 0; i < value.length; i++) {
      data.add(value[i]["id"].toString());
      //print(value[i]["id"].toString());
    }
  } else if (num == 6) {
    var value = await database.rawQuery('SELECT next_day FROM MyDatas');
    for (var i = 0; i < value.length; i++) {
      data.add(value[i]["next_day"].toString());
      //print("next ${value[i]["next_day"].toString()}");
    }
  } else if (num == 7) {
    var value = await database.rawQuery('SELECT id FROM MyDatas');
    for (var i = 0; i < value.length; i++) {
      data.add(value[i]["id"].toString());
      //print("next ${value[i]["next_day"].toString()}");
    }
  } else if (num == 8) {
    var value =
        await database.rawQuery('SELECT title FROM MyDatas WHERE juge=1');
    for (var i = 0; i < value.length; i++) {
      data.add(value[i]["title"].toString());
      //print("next ${value[i]["title"]}");
    }
  } else if (num == 9) {
    //next_number読み込み
    var value = await database.rawQuery('SELECT next_number FROM MyDatas');
    for (var i = 0; i < value.length; i++) {
      data.add(value[i]["next_number"].toString());
      //print("next ${value[i]["title"]}");
    }
  }
  if (data.length == 0) {
    data = null;
    //print("からです");
  }

  //print(data);
  return data;
}

/*データベース内に登録されているデータがあるかチェックする処理*/
Future checkDb() async {
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my.db');
  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
  var val = await database.rawQuery("select count(id) from MyDatas");
  var result = val[0]['count(id)'].toString();
  return result;
}

/*idからタイトルとキーワードを返す処理*/
Future readEditValue(String id) async {
  List<String> data = [];

  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my.db');
  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);

  var title_val =
      await database.rawQuery('SELECT title FROM MyDatas WHERE id="$id"');
  data.add(title_val[0]["title"].toString());
  var keyword_val =
      await database.rawQuery('SELECT keyword FROM MyDatas WHERE id="$id"');
  data.add(keyword_val[0]["keyword"].toString());
  return data;
}

calcDays(String level) {
  //levelの値から次の学習日までの日数を計算　level6の場合は次がないので"complete"を返す
  switch (level) {
    case '0':
      return 1;
    case '1':
      return 3;
    case '2':
      return 3;
    case '3':
      return 4;
    case '4':
      return 4;
    case '5':
      return 5;
    case '6':
      return "complete!";
  }
}

//学習完了処理
completeStudy(String id) async {
  //databaseへ接続
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my.db');
  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);

  //一致したidレコードのjuge値を更新 1->0
  await database.rawQuery('UPDATE MyDatas SET juge=0 WHERE "$id"=id');
  //idからlevelを取得
  var val_level =
      await database.rawQuery('SELECT level FROM MyDatas WHERE "$id"=id');

  //取得したレベルの値から次の学習日までの日数計算
  int inextDays = calcDays(val_level[0]["level"].toString());

  //今日の日付と日数から次の学習日を計算
  var next_days = date(inextDays);

  //next_dayを更新
  await database
      .rawQuery('UPDATE MyDatas SET next_day="$next_days" WHERE id="$id"');

  //levelを更新
  int val = changeToInt(val_level[0]["level"].toString());
  if (val <= 5) {
    val += 1;
    await database.rawQuery('UPDATE MyDatas SET level="$val" WHERE id="$id"');
  } else if (val == 6) {
    await database
        .rawQuery('UPDATE MyDatas SET level="Complete!" WHERE id="$id"');
  }
}

//特定の文字列を含むレコードを探す
searchStr(String searchStr) async {
  List<String> data = [];
  //databaseへ接続
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my.db');
  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
  //print("str=$searchStr");
  var value = await database
      .rawQuery("SELECT title FROM MyDatas WHERE title LIKE '%$searchStr%'");
  //print("科目名={$value}");
  //print("データは${value.length}");
  for (var i = 0; i < value.length; i++) {
    data.add(value[i]["title"].toString());
  }
  return data;
}

//update リストの内容を編集して登録する処理(id: リストのid num 0: タイトル編集　1:キーワード編集　value:編集内容)
updateEditList(String id, String title, String keyword) async {
  //databaseへ接続
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my.db');
  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
  //指定テーブルの内容を変更
  await database.rawQuery('UPDATE MyDatas SET title="$title" WHERE id="$id"');
  await database
      .rawQuery('UPDATE MyDatas SET keyword="$keyword" WHERE id="$id"');
}

//データベースの値更新（next_value）
updateNextValue(int value) async {
  //databaseへ接続
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my.db');
  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
  await database.rawQuery('UPDATE MyDatas SET next_number="$value"');
}

//update 本日のナンバーがnext_numberより大きければnext_numberにtoday_numberを挿入,next_dayに本日の日付挿入
updateNextNum(int today_number, String today) async {
  //databaseへ接続
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my.db');
  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);

  await database.rawQuery('UPDATE MyDatas SET next_number="$today_number",next_day="$today" WHERE next_number<"$today_number"');
  //print("UPDATE compleate!");
}

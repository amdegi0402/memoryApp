import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:super_memory/sqlite.dart';

//next_numberに挿入するの値を計算
int calcNextVal(int year, int month, int day) {
  int value = year * 10000 + month * 100 + day;
  print(value);
  return value;
}

//today_numberとnext_number比較
checkNumbers(int today_num, int next_num) {
  if (today_num > next_num) {
    next_num = today_num;
    updateNextValue(
        next_num); //もしtoday_numer > next_numberだったらnext_numberを今日のナンバーに更新
    //次の学習日を今日の日付に更新
  }
}

//現在の日付
String date(int add) {
  //add 加算する日数　1-2-4-7-11-15-20
  initializeDateFormatting('ja');
  //var format = new DateFormat.yMMMd('ja');
  String year_now = new DateFormat.y().format(DateTime.now()); //現在の年
  String month_now = new DateFormat.M().format(DateTime.now()); //現在の月
  String day_now = new DateFormat.d().format(DateTime.now()); //現在の日付
  int days;
  int monthes;
  int years;

  //print("${year_now}年　${month_now}月　${day_now}日");

  //文字型を整数型へ変換
  try {
    days = int.parse(day_now.toString());
  } catch (exception) {
    days = 0;
  }
  try {
    monthes = int.parse(month_now.toString());
  } catch (exception) {
    monthes = 0;
  }
  try {
    years = int.parse(year_now.toString());
  } catch (exception) {
    monthes = 0;
  }
  var add_days = days + add;
  //print("month_now=$month_now");
  //print("add_days=$add_days");

  //date(0)の場合　今日の日付を返す
  if (add == 0) {
    String result = monthes.toString() + "/" + add_days.toString();
    return result;
  } else {
    /*次回学習日を計算*/
    switch (month_now.toString()) {
      case "1": //31
        {
          if (add_days > 31) {
            monthes += 1;
            add_days -= 31;
          }
          int value = calcNextVal(years, monthes, add_days); //next_number 計算
          updateNextValue(value); //next_valueの値をデータベースへ挿入
          String result = monthes.toString() + "/" + add_days.toString();
          return result;
        }
      case "2": //28
        {
          if (add_days > 28) {
            monthes += 1;
            add_days -= 28;
          }
          int value = calcNextVal(years, monthes, add_days); //next_number 計算
          updateNextValue(value); //next_valueの値をデータベースへ挿入
          String result = monthes.toString() + "/" + add_days.toString();
          return result;
        }
      case "3": //31
        {
          if (add_days > 31) {
            monthes += 1;
            add_days -= 31;
          }
          int value = calcNextVal(years, monthes, add_days); //next_number 計算
          updateNextValue(value); //next_valueの値をデータベースへ挿入
          String result = monthes.toString() + "/" + add_days.toString();
          return result;
        }
      case "4": //30
        {
          if (add_days > 30) {
            monthes += 1;
            add_days -= 30;
          }
          int value = calcNextVal(years, monthes, add_days); //next_number 計算
          updateNextValue(value); //next_valueの値をデータベースへ挿入
          String result = monthes.toString() + "/" + add_days.toString();
          return result;
        }
      case "5": //31
        {
          if (add_days > 31) {
            monthes += 1;
            add_days -= 31;
          }
          int value = calcNextVal(years, monthes, add_days); //next_number 計算
          updateNextValue(value); //next_valueの値をデータベースへ挿入
          String result = monthes.toString() + "/" + add_days.toString();
          return result;
        }
      case "6": //30
        {
          if (add_days > 30) {
            monthes += 1;
            add_days -= 30;
          }
          int value = calcNextVal(years, monthes, add_days); //next_number 計算
          updateNextValue(value); //next_valueの値をデータベースへ挿入
          String result = monthes.toString() + "/" + add_days.toString();
          return result;
        }
      case "7": //31
        {
          if (add_days > 31) {
            monthes += 1;
            add_days -= 31;
          }
          int value = calcNextVal(years, monthes, add_days); //next_number 計算
          updateNextValue(value); //next_valueの値をデータベースへ挿入
          String result = monthes.toString() + "/" + add_days.toString();
          return result;
        }
      case "8": //31
        {
          if (add_days > 31) {
            monthes += 1;
            add_days -= 31;
          }
          int value = calcNextVal(years, monthes, add_days); //next_number 計算
          updateNextValue(value); //next_valueの値をデータベースへ挿入
          String result = monthes.toString() + "/" + add_days.toString();
          return result;
        }
      case "9": //31
        {
          if (add_days > 30) {
            monthes += 1;
            add_days -= 30;
          }
          int value = calcNextVal(years, monthes, add_days); //next_number 計算
          updateNextValue(value); //next_valueの値をデータベースへ挿入
          String result = monthes.toString() + "/" + add_days.toString();
          return result;
        }
      case "10": //31
        {
          if (add_days > 31) {
            monthes += 1;
            add_days -= 31;
          }
          int value = calcNextVal(years, monthes, add_days); //next_number 計算
          updateNextValue(value); //next_valueの値をデータベースへ挿入
          String result = monthes.toString() + "/" + add_days.toString();
          return result;
        }
      case "11": //30
        {
          if (add_days > 30) {
            monthes += 1;
            add_days -= 30;
          }
          int value = calcNextVal(years, monthes, add_days); //next_number 計算
          updateNextValue(value); //next_valueの値をデータベースへ挿入
          String result = monthes.toString() + "/" + add_days.toString();
          return result;
        }
      case "12": //31
        {
          if (add_days > 31) {
            monthes = 1;
            add_days -= 31;
            years += 1;
          }
          int value = calcNextVal(years, monthes, add_days); //next_number 計算
          updateNextValue(value); //next_valueの値をデータベースへ挿入
          String result = monthes.toString() + "/" + add_days.toString();
          return result;
        }
    }
  }
}

//文字型を整数型へ変換する処理
changeToInt(String str) {
  int value;
  try {
    value = int.parse(str.toString());
  } catch (exception) {
    value = 0;
  }
  return value;
}

//新規追加時に登録するnext_number(1日後のnumberとなる)を計算
calcInitNextVal() {
  initializeDateFormatting('ja');
  //var format = new DateFormat.yMMMd('ja');
  String year_now = new DateFormat.y().format(DateTime.now()); //現在の年
  String month_now = new DateFormat.M().format(DateTime.now()); //現在の月
  String day_now = new DateFormat.d().format(DateTime.now()); //現在の日付
  int days;
  int monthes;
  int years;
  Map<String, int> result;

  //文字型を整数型へ変換
  days = changeToInt(day_now);
  monthes = changeToInt(month_now);
  years = changeToInt(year_now);

  int add_days = days + 1;

  if (add_days > 31) {
    monthes += 1;
    add_days -= 31;
  }
  int next_num = calcNextVal(years, monthes, add_days); //next_number 計算
  String next_day = monthes.toString() + "/" + add_days.toString();
  result = {next_day: next_num}; //mapに格納
  return result;
}

//今日の日付ナンバーを返す
int calcToday() {
  int days;
  int monthes;
  int years;
  int today_number;

  initializeDateFormatting('ja');
  //var format = new DateFormat.yMMMd('ja');
  String year_now = new DateFormat.y().format(DateTime.now()); //現在の年
  String month_now = new DateFormat.M().format(DateTime.now()); //現在の月
  String day_now = new DateFormat.d().format(DateTime.now()); //現在の日付

  //文字型を整数型へ変換
  days = changeToInt(day_now);
  monthes = changeToInt(month_now);
  years = changeToInt(year_now);

  today_number = calcNextVal(years, monthes, days); //next_numberと比較する本日のナンバーを計算
  return today_number;
}

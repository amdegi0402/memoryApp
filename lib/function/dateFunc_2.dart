import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

//現在の日付
int calcDateNumber() {
  //add 加算する日数　1-2-4-7-11-15-20
  initializeDateFormatting('ja');
  //var format = new DateFormat.yMMMd('ja');
  //1:31,2:28,3:31,4:30,5:31,6:30,7:31,8:31,9:30,10:31,11:30,12:31
  var month_now = new DateFormat.M().format(DateTime.now()); //現在の月
  var day_now = new DateFormat.d().format(DateTime.now()); //現在の日付
  var dateNumber;
  var days;
  var monthes;

  //dateナンバーを計算
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

  switch (month_now.toString()) {
    case "1": //31
      {
        dateNumber = days;
        return dateNumber;
      }
    case "2": //28
      {
        dateNumber = 31 + days;
        return dateNumber;
      }
    case "3": //31
      {
        dateNumber = 59 + days;
        return dateNumber;
      }
    case "4": //30
      {
        dateNumber = 90 + days;
        return dateNumber;
      }
    case "5": //31
      {
        dateNumber = 120 + days;
        return dateNumber;
      }
    case "6": //30
      {
        dateNumber = 151 + days;
        return dateNumber;
      }
    case "7": //31
      {
        dateNumber = 181 + days;
        return dateNumber;
      }
    case "8": //31
      {
        dateNumber = 212 + days;
        return dateNumber;
      }
    case "9": //30
      {
        dateNumber = 243 + days;
        return dateNumber;
      }
    case "10": //31
      {
        dateNumber = 273 + days;
        return dateNumber;
      }
    case "11": //30
      {
        dateNumber = 304 + days;
        return dateNumber;
      }
    case "12": //31
      {
        dateNumber = 334 + days;
        return dateNumber;
      }
  }
}

//dateNumberから日付を計算

calcDate(int dateNumbers) {
  String dateResult;

  if (dateNumbers >= 1 && dateNumbers <= 31) {
    dateResult = "1" + "/" + dateNumbers.toString();
  }
  if (dateNumbers >= 32 && dateNumbers <= 59) {
    dateNumbers -= 31; //1月の31日の差分から日付を求める
    dateResult = "2" + "/" + dateNumbers.toString();
  }
  if (dateNumbers >= 60 && dateNumbers <= 90) {
    dateNumbers -= 59; //2月までの差分から日付を求める
    dateResult = "3" + "/" + dateNumbers.toString();
  }
  if (dateNumbers >= 91 && dateNumbers <= 120) {
    dateNumbers -= 90; //3月までの差分から日付を求める
    dateResult = "4" + "/" + dateNumbers.toString();
  }
  if (dateNumbers >= 121 && dateNumbers <= 151) {
    dateNumbers -= 120; //4月までの差分から日付を求める
    dateResult = "5" + "/" + dateNumbers.toString();
  }
  if (dateNumbers >= 152 && dateNumbers <= 181) {
    dateNumbers -= 151; //5月までの差分から日付を求める
    dateResult = "6" + "/" + dateNumbers.toString();
  }
  if (dateNumbers >= 182 && dateNumbers <= 212) {
    dateNumbers -= 181; //6月までの差分から日付を求める
    dateResult = "7" + "/" + dateNumbers.toString();
  }
  if (dateNumbers >= 213 && dateNumbers <= 243) {
    dateNumbers -= 212; //7月までの差分から日付を求める
    dateResult = "8" + "/" + dateNumbers.toString();
  }
  if (dateNumbers >= 244 && dateNumbers <= 273) {
    dateNumbers -= 243; //8月までの差分から日付を求める
    dateResult = "9" + "/" + dateNumbers.toString();
  }
  if (dateNumbers >= 274 && dateNumbers <= 304) {
    dateNumbers -= 273; //9月までの差分から日付を求める
    dateResult = "10" + "/" + dateNumbers.toString();
  }
  if (dateNumbers >= 305 && dateNumbers <= 334) {
    dateNumbers -= 304; //10月までの差分から日付を求める
    dateResult = "11" + "/" + dateNumbers.toString();
  }
  if (dateNumbers >= 335 && dateNumbers <= 365) {
    dateNumbers -= 334; //11月までの差分から日付を求める
    dateResult = "1" + "/" + dateNumbers.toString();
  }
  print("日付計算結果は $dateResult");
  return dateResult;
}

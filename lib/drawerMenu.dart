import 'package:flutter/material.dart';
import 'new_list/addList.dart';
import 'new_list/allList.dart';
import 'main.dart';

//drawerメニューリスト
Widget drawerMenu(BuildContext context) {
  return ListView(
    children: <Widget>[
      /*DrawerHeader(
              child: Text("Drawer", style: TextStyle(fontSize: 24, color: Colors.blue,),),
              decoration: BoxDecoration(color: Colors.black,),
            ),*/
      ListTile(
          leading: Icon(Icons.home),
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
          leading: Icon(Icons.add),
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
          leading: Icon(Icons.content_paste),
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
}

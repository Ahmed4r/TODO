import 'package:flutter/material.dart';
import 'package:todolist/screens/homepage.dart';
import 'package:todolist/themeData.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const TodoList());
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: MyThemeData.ligthTheme,
      darkTheme: MyThemeData.darkTheme,
      initialRoute: Homepage.routeName,
      routes: {Homepage.routeName: (context) => Homepage()},
      debugShowCheckedModeBanner: false,
    );
  }
}

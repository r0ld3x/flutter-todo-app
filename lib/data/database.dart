import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List todoList = [];

  final _myBox = Hive.box('myBox');

  void createInitialData() {
    todoList = [
      ["go to gym", false],
      ["go to school", false],
    ];
  }

  void loadData() {
    todoList = _myBox.get("todoList", defaultValue: [
      ["go to gym", false],
      ["go to school", false],
    ]);
  }

  void updateDatabase() {
    _myBox.put("todoList", todoList);
  }
}

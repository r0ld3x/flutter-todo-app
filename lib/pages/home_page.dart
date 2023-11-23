import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled/data/database.dart';
import 'package:untitled/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ToDoDatabase db = ToDoDatabase();
  final _controller = TextEditingController();

  final _myBox = Hive.box('myBox');

  @override
  void initState() {
    super.initState();
    if (_myBox.get("todoList") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = value!;
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateDatabase();

    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.cyan[100],
            title: Center(
              child: Text(
                'New Task',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: 'Enter new task',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  )),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                onPressed: saveNewTask,
                child: Text('Add'),
              ),
            ],
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[200],
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.cyan[500],
          title: Center(
              child: Text(
            "TO DO",
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
          elevation: 0,
        ),
        body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.todoList[index][0],
              taskCompleted: db.todoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}

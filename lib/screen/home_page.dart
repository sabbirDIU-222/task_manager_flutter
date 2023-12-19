import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_manager/todo_data/todo_database.dart';
import 'package:task_manager/util/dialog_manager/dialog.dart';
import 'package:task_manager/util/to_do_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final mybox  = Hive.box('myBox');

  final  taskController = TextEditingController();

  TodoDatabase todoDatabase = TodoDatabase();

  @override
  void initState() {
    // TODO: implement initState
    if(mybox.get('TODOLIST')==null) {
      todoDatabase.createInitialData();
    }else{
      todoDatabase.loadData();
    }

    super.initState();
  }



  void checkBoxActivity(bool? value, int index){
    setState(() {
      todoDatabase.todoList[index][1] = !todoDatabase.todoList[index][1];
    });
    todoDatabase.updataDatabase();
  }

  void saveNewTask(){
    setState(() {
      todoDatabase.todoList.add([taskController.text,false]);
      taskController.clear();
    });
    Navigator.of(context).pop();
    todoDatabase.updataDatabase();
  }

  void myTask(){
    showDialog(context: context, builder: (context) {
      return DialogeBox(
        controller: taskController,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),

      );
    },);
  }

  void deleteTask(int index){
    setState(() {
      todoDatabase.todoList.removeAt(index);
    });
    todoDatabase.updataDatabase();

  }

  void editTask(int index) {
    taskController.text = todoDatabase.todoList[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return DialogeBox(
          controller: taskController,
          onSave: () {
            setState(() {
              todoDatabase.todoList[index][0] = taskController.text;
              taskController.clear();
            });
            Navigator.of(context).pop();
            todoDatabase.updataDatabase();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: Text('My Task Manager',style: TextStyle(letterSpacing: 2),),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: todoDatabase.todoList.length,
        itemBuilder: (context, index) {
        return TODOTile(
            taskName: todoDatabase.todoList[index][0],
            isTaskComplete: todoDatabase.todoList[index][1],
            onChanged: (value) => checkBoxActivity(value, index),
          deleteFunction: (context) => deleteTask(index),
          onEdit: () => editTask(index),
        );
      },),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            myTask();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

import 'package:hive/hive.dart';

class TodoDatabase{

  List todoList = [];
  final myBox = Hive.box('myBox');

  void createInitialData(){
     todoList = [
      ['did you pray', true],
      ['Morning walk', false],
    ];
  }

  void loadData(){
    todoList = myBox.get('TODOLIST');
  }

  void updataDatabase(){
    myBox.put('TODOLIST', todoList);
  }

}
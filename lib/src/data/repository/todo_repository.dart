import 'package:flutter_todo_app/src/data/model/todo_model.dart';
import 'package:flutter_todo_app/src/data/provider/firebase_db.dart';

class TodoRepository {
  static Stream<List<TodoModel>> fetchTodos() => TodoApi.getTodos();
}

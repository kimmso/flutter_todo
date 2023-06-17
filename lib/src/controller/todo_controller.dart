import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/src/data/model/todo_model.dart';
import 'package:flutter_todo_app/src/data/provider/firebase_db.dart';
import 'package:flutter_todo_app/src/data/repository/todo_repository.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  Rx<List<TodoModel>> _todos = Rx<List<TodoModel>>([]);
  final TextEditingController _controller = TextEditingController();

  List<TodoModel> get todos => _todos.value;
  TextEditingController get createC => _controller;

  @override
  void onReady() {
    super.onReady();
    _todos.bindStream(TodoRepository.fetchTodos());
  }

  void create() {
    final todo = _controller.value.text;
    if (todo.isNotEmpty) {
      try {
        final todoModel = TodoModel.toJson(todo);
        TodoApi.createTodo(todoModel);
        _controller.clear();
      } catch (e) {
        debugPrint("Error");
      }
    }
  }

  void updateTodo(String id) {
    try {
      TodoApi.updateTodo(id);
    } catch (e) {
      debugPrint("Error");
    }
  }

  void deleteTodo(String id) {
    try {
      TodoApi.deleteTodo(id);
    } catch (e) {
      debugPrint("Error");
    }
  }
}

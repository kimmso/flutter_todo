import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_app/src/constants/firebase_constants.dart';
import 'package:flutter_todo_app/src/data/model/todo_model.dart';

class TodoApi {
  static Stream<List<TodoModel>> getTodos() {
    return firebaseFirestore
        .collection('todo')
        .orderBy('time', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> todos = [];
      for (var doc in query.docs) {
        final _todoModel = TodoModel.fromJson(doc);
        todos.add(_todoModel);
      }
      return todos;
    });
  }

  static void createTodo(TodoModel todoModel) async {
    firebaseFirestore.collection('todo').doc().set({
      'todo': todoModel.todo,
      'time': Timestamp.now(),
      'isDone': false,
    });
  }

  static void updateTodo(String id) {
    firebaseFirestore.collection('todo').doc(id).update({
      'isDone': true,
    });
  }

  static void deleteTodo(String id) {
    firebaseFirestore.collection('todo').doc(id).delete();
  }
}

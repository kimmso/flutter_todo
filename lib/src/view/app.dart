import 'package:flutter/material.dart';
import 'package:flutter_todo_app/src/controller/todo_controller.dart';
import 'package:get/get.dart';

class App extends GetView<TodoController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Firebase getx CRUD')),
      ),
      body: Column(
        children: [
          _create(),
          _todoList(),
        ],
      ),
    );
  }

  Widget _todoList() {
    return Expanded(
        child: Obx(
      (() => ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todoModel = controller.todos[index];
            return ListTile(
              leading: (todoModel.isDone!)
                  ? GestureDetector(
                      onTap: () {
                        controller.deleteTodo(todoModel.id!);
                      },
                      child: Icon(Icons.check, color: Colors.green))
                  : GestureDetector(
                      onTap: () {
                        controller.updateTodo(todoModel.id!);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
              title: Text(todoModel.todo),
              subtitle: Text(todoModel.time.toString()),
            );
          })),
    ));
  }

  Widget _create() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 250,
          child: TextField(
            controller: controller.createC,
          ),
        ),
        ElevatedButton(onPressed: controller.create, child: Icon(Icons.send))
      ],
    );
  }
}

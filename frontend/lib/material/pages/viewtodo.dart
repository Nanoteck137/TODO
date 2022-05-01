import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';

class ViewTodo extends StatelessWidget {
  const ViewTodo(this.todo, {Key? key}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Center(
        child: TextButton(
          child: const Text("View Todo"),
          onPressed: () {},
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Todo {
  final String id;
  final String title;

  const Todo({
    required this.id,
    required this.title,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json["_id"],
      title: json["title"],
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<Todo>> futureTodos;
  int _counter = 0;

  Future<List<Todo>> fetchTodos() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/todos'));

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      return json.map((d) => Todo.fromJson(d)).toList();
    } else {
      throw Exception("Failed to load todos");
    }
  }

  Future deleteTodo(Todo todo) async {
    final id = todo.id;
    final response =
        await http.delete(Uri.parse('http://localhost:3000/api/todos/$id'));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete todos");
    }
  }

  Future addTodo(String title) async {
    var body = jsonEncode({"title": title});

    Map<String, String> headers = {
      'Content-type': 'application/json',
    };

    final response = await http.post(
        Uri.parse('http://localhost:3000/api/todos'),
        body: body,
        headers: headers);

    if (response.statusCode != 200) {
      throw Exception("Failed to delete todos");
    }
  }

  @override
  void initState() {
    super.initState();
    futureTodos = fetchTodos();
  }

  Widget buildItem(BuildContext context, Todo todo) {
    return Card(
      child: ListTile(
          onTap: () {
            // TODO(patrik): Goto the TODO page
          },
          title: Text(todo.title),
          leading: const Icon(Icons.assignment),
          trailing: IconButton(
            splashRadius: 20.0,
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              deleteTodo(todo).then(
                (_) {
                  setState(() {
                    futureTodos = fetchTodos();
                  });
                },
              );
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: FutureBuilder<List<Todo>>(
        future: futureTodos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Todo> todos = snapshot.data!;
            return ListView.builder(
                itemCount: todos.length,
                itemBuilder: ((context, index) {
                  return buildItem(context, todos[index]);
                }));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
            addTodo("Count: $_counter");
            futureTodos = fetchTodos();
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

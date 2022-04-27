import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Todo {
  final String title;

  const Todo({
    required this.title,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
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

  Future<List<Todo>> fetchTodos() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      await Future.delayed(const Duration(seconds: 5));
      List<dynamic> json = jsonDecode(response.body);
      return json.map((d) => Todo.fromJson(d)).toList();
    } else {
      throw Exception("Failed to load todos");
    }
  }

  @override
  void initState() {
    super.initState();
    futureTodos = fetchTodos();
    // futureTodos.whenComplete(() => );
  }

  Widget buildItem(BuildContext context, String title) {
    return Card(
      child: ListTile(
          onTap: () {
            // TODO(patrik): Goto the TODO page
          },
          title: Text(title),
          leading: const Icon(Icons.assignment),
          trailing: IconButton(
            splashRadius: 20.0,
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              setState(() {
                futureTodos = fetchTodos();
              });
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
                  return buildItem(context, todos[index].title);
                }));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

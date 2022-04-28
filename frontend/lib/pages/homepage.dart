import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/pages/viewtodo.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget buildItem(BuildContext context, Todo todo) {
    List<Widget> widgets = todo.steps
        .map((step) => ListTile(
              title: Text(step.title),
              leading: const Icon(Icons.assignment),
              trailing: IconButton(
                splashRadius: 20.0,
                icon: const Icon(Icons.delete_forever),
                onPressed: () {
                  todo.removeStep(step);
                  /*
                  todo
                    ..setRemove("steps", step.toJson())
                    ..save();
                    */
                },
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => ViewTodo(todo))));
              },
            ))
        .toList();

    return Card(
      child: ExpansionTile(
          title: Text(todo.title),
          controlAffinity: ListTileControlAffinity.leading,
          trailing: IconButton(
            splashRadius: 20.0,
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              todo.delete(id: todo.objectId!);
            },
          ),
          children: widgets),
    );
  }

  Widget buildList(BuildContext context) {
    QueryBuilder<Todo> query = QueryBuilder<Todo>(Todo());

    return ParseLiveListWidget<Todo>(
      query: query,
      childBuilder:
          (BuildContext context, ParseLiveListElementSnapshot<Todo> snapshot) {
        if (snapshot.hasData) {
          var todo = snapshot.loadedData!;
          return buildItem(context, todo);
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: buildList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
            var todo = ParseObject("Test")
              ..set("title", "$_counter")
              ..set("content", "test");

            todo.save();
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

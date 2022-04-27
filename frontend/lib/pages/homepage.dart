import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

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
  int _counter = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget buildItem(BuildContext context, String id, String title) {
    return Card(
      child: ListTile(
          title: Text(title),
          leading: const Icon(Icons.assignment),
          trailing: IconButton(
            splashRadius: 20.0,
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              ParseObject("Test").delete(id: id);
            },
          )),
    );
  }

  Widget buildList(BuildContext context) {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject('Test'));

    return ParseLiveListWidget<ParseObject>(
      query: query,
      childBuilder: (BuildContext context,
          ParseLiveListElementSnapshot<ParseObject> snapshot) {
        if (snapshot.hasData) {
          var id = snapshot.loadedData!.objectId!;
          var title = snapshot.loadedData!.get("title");
          return buildItem(context, id, title);
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

import 'dart:developer';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todo/models/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  Widget buildItem(BuildContext context, Todo todo) {
    var stepViews = List<TreeViewItem>.empty(growable: true);
    var steps = todo.steps;
    for (var stepIndex = 0; stepIndex < steps.length; stepIndex++) {
      var step = steps[stepIndex];

      var view = TreeViewItem(
        content: Row(
          children: [
            Checkbox(
              checked: step.completed,
              onChanged: (value) {
                setState(() {
                  todo.setStepCompleted(stepIndex, value ?? false);
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(step.title),
            ),
          ],
        ),
      );

      stepViews.add(view);
    }

    return TreeView(
      items: [
        TreeViewItem(
          content: Text(todo.title),
          children: stepViews,
        ),
      ],
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
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: buildList(context),
    );
  }
}

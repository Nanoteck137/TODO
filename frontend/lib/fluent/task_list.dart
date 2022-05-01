import 'dart:developer';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todo/models/task.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  Widget buildItem(BuildContext context, Task task) {
    return TappableListTile(
      title: Text(
        task.title,
        style: task.completed
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      leading: Checkbox(
        checked: task.completed,
        onChanged: (value) {
          setState(() {
            task.completed = value ?? false;
            task.update();
          });
        },
      ),
      onTap: () {
        setState(() {
          var completed = task.completed;
          task.completed = !completed;
          task.update();
        });
      },
    );
  }

  Widget buildList(BuildContext context) {
    QueryBuilder<Task> query = QueryBuilder<Task>(Task());

    return ParseLiveListWidget<Task>(
      query: query,
      childBuilder:
          (BuildContext context, ParseLiveListElementSnapshot<Task> snapshot) {
        if (snapshot.hasData) {
          var task = snapshot.loadedData!;
          return buildItem(context, task);
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

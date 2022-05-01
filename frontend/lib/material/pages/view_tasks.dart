import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todo/models/task.dart';

class ViewTasks extends StatefulWidget {
  const ViewTasks(this.folder, {Key? key}) : super(key: key);

  final ParseObject folder;

  @override
  State<ViewTasks> createState() => _ViewTasksState();
}

class _ViewTasksState extends State<ViewTasks> {
  Widget buildItem(BuildContext context, Task task) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.task),
        title: Text(task.title),
        trailing: Checkbox(
          onChanged: (value) {
            setState(() {
              task.completed = value ?? false;
              task.update();
            });
          },
          value: task.completed,
        ),
        onTap: () {
          task.completed = !task.completed;
          task.update();
        },
      ),
    );
  }

  Widget buildList(BuildContext context) {
    QueryBuilder<Task> query = QueryBuilder<Task>(Task());
    return ParseLiveListWidget(
      query: query,
      childBuilder:
          (BuildContext context, ParseLiveListElementSnapshot<Task> snapshot) {
        if (snapshot.hasData) {
          var obj = snapshot.loadedData!;
          return buildItem(context, obj);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var folderTitle = widget.folder.get<String>("title", defaultValue: "")!;
    return Scaffold(
      appBar: AppBar(
        title: Text(folderTitle),
      ),
      body: buildList(context),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'view_tasks.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
  }

  Widget buildItem(BuildContext context, ParseObject folder) {
    var title = folder.get<String>("title", defaultValue: "")!;
    return Card(
      child: ListTile(
        leading: const Icon(Icons.folder),
        trailing: const Icon(Icons.arrow_forward_sharp),
        title: Text(title),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ViewTasks(folder);
          }));
        },
      ),
    );
  }

  Widget buildList(BuildContext context) {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject("folders"));
    return ParseLiveListWidget(
      query: query,
      childBuilder: (BuildContext context,
          ParseLiveListElementSnapshot<ParseObject> snapshot) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: buildList(context),
    );
  }
}

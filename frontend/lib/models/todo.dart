import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class TodoStep {
  final String title;
  final bool completed;

  TodoStep(this.title, this.completed);

  TodoStep.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        completed = json["completed"];

  Map<String, dynamic> toJson() {
    var result = <String, dynamic>{"title": title, "completed": completed};

    return result;
  }
}

class Todo extends ParseObject implements ParseCloneable {
  static const String _keyTableName = "todos";
  static const String _keyTitle = "title";
  static const String _keySteps = "steps";

  Todo() : super(_keyTableName);
  Todo.clone() : this();

  @override
  clone(Map<String, dynamic> map) => Todo.clone()..fromJson(map);

  String get title => get<String>(_keyTitle, defaultValue: "")!;
  set title(String title) => set<String>(_keyTitle, title);

  List<TodoStep> get steps =>
      get<List<dynamic>>(_keySteps, defaultValue: List.empty())!
          .map((e) => e as Map<String, dynamic>)
          .map((e) => TodoStep.fromJson(e))
          .toList();

  Future<ParseResponse> removeStep(TodoStep step) {
    var obj = this..setRemove("steps", step.toJson());
    return obj.save();
  }
}

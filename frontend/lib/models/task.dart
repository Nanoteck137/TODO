import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Task extends ParseObject implements ParseCloneable {
  static const String _keyTableName = "tasks";
  static const String _keyTitle = "title";
  static const String _keyCompleted = "completed";

  Task() : super(_keyTableName);
  Task.clone() : this();

  @override
  clone(Map<String, dynamic> map) => Task.clone()..fromJson(map);

  String get title => get<String>(_keyTitle, defaultValue: "")!;
  set title(String title) => set<String>(_keyTitle, title);

  bool get completed => get<bool>(_keyCompleted, defaultValue: false)!;
  set completed(bool value) => set<bool>(_keyCompleted, value);
}

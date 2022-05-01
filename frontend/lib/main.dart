import 'package:fluent_ui/fluent_ui.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todo/macos/app.dart';
import 'package:todo/material/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Parse().initialize(
    "myAppId",
    "http://wooh.com:3000/parse",
    debug: true,
    liveQueryUrl: "ws://wooh.com:3000/",
    coreStore: await CoreStoreSharedPrefsImp.getInstance(),
  );

  runApp(const TodoMaterialApp());
}

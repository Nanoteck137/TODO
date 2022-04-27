import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todo/pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Parse().initialize("myAppId", "http://localhost:3000/parse",
      debug: true,
      liveQueryUrl: "ws://localhost:3000/",
      coreStore: await CoreStoreSharedPrefsImp.getInstance());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
    );
  }
}

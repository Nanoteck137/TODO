import 'package:flutter/material.dart';

import 'pages/homepage.dart';

class TodoMaterialApp extends StatelessWidget {
  const TodoMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
    );
  }
}

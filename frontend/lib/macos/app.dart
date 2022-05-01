import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class TodoMacosApp extends StatelessWidget {
  const TodoMacosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MacosApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const Test(),
    );
  }
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
        bottom: Text("Settings"),
        builder: (context, scrollController) {
          return SidebarItems(
            currentIndex: currentIndex,
            onChanged: (i) {
              setState(() {
                currentIndex = i;
              });
            },
            items: [
              SidebarItem(
                label: Text("Hello World"),
                disclosureItems: [
                  SidebarItem(
                    label: Text("Test"),
                  ),
                ],
              ),
              SidebarItem(
                label: Text("Hello World"),
              ),
              SidebarItem(
                label: Text("Hello World"),
              ),
            ],
          );
        },
        minWidth: 200.0,
      ),
      child: Text("Hello World"),
    );
  }
}

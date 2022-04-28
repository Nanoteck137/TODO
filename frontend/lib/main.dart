import 'dart:developer';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/pages/homepage.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

/*
  await Parse().initialize("myAppId", "http://localhost:3000/parse",
      debug: true,
      liveQueryUrl: "ws://localhost:3000/",
      coreStore: await CoreStoreSharedPrefsImp.getInstance(),
      registeredSubClassMap: <String, ParseObjectConstructor>{
        'Test': () => Todo(),
      });
      */

  await flutter_acrylic.Window.initialize();
  await WindowManager.instance.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitleBarStyle(
      TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    // await windowManager.setSize(const Size(755, 545));
    await windowManager.setMinimumSize(const Size(755, 545));
    await windowManager.center();
    await windowManager.setSkipTaskbar(false);
    await windowManager.show();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Flutter Demo',
      home: const Test(),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.red,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen() ? 2.0 : 0.0,
        ),
      ),
      theme: ThemeData(
        accentColor: Colors.red,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen() ? 2.0 : 0.0,
        ),
      ),
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
    return NavigationView(
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        height: 35.0,
        backgroundColor: FluentTheme.of(context).scaffoldBackgroundColor,
        title: DragToMoveArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text("Todo App"),
            ),
          ),
        ),
        actions: DragToMoveArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Spacer(),
              WindowButtons(),
            ],
          ),
        ),
      ),
      content: NavigationBody.builder(
        index: currentIndex,
        itemBuilder: (context, index) {
          return ScaffoldPage(
            header: PageHeader(
              title: const Text("Hello World"),
            ),
            content: Center(
              child: Text("Hello World"),
            ),
          );
        },
      ),
      pane: NavigationPane(
        selected: currentIndex,
        onChanged: (i) {
          setState(() {
            log("Index: $i");
            currentIndex = i;
          });
        },
        footerItems: [
          PaneItem(
            title: const Text("Settings"),
            icon: const Icon(FluentIcons.settings),
          ),
        ],
        items: [
          PaneItem(
            title: const Text("Hello World"),
            icon: const Icon(FluentIcons.folder),
          ),
          PaneItem(
            title: const Text("Hello World 2"),
            icon: const Icon(FluentIcons.folder),
          ),
          PaneItem(
            title: const Text("Hello World 3"),
            icon: const Icon(FluentIcons.folder),
          ),
        ],
        displayMode: PaneDisplayMode.open,
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: double.infinity,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

/*
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
*/
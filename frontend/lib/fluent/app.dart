import 'package:fluent_ui/fluent_ui.dart';
import 'package:todo/fluent/task_list.dart';
import 'package:todo/fluent/todolist.dart';
import 'package:window_manager/window_manager.dart';

class TodoFluentApp extends StatelessWidget {
  const TodoFluentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: "Todo App",
      home: const HomePage(),
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    var list = List<NavigationPaneItem>.empty(growable: true);
    for (var i = 0; i < counter; i++) {
      var item = PaneItem(
        title: Text("Folder: $i"),
        icon: const Icon(FluentIcons.folder),
      );

      list.add(item);
    }

    return NavigationView(
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        height: 35.0,
        // backgroundColor: FluentTheme.of(context).scaffoldBackgroundColor,
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
          return const TaskList();
        },
      ),
      pane: NavigationPane(
        selected: currentIndex,
        onChanged: (i) {
          setState(() {
            currentIndex = i;
          });
        },
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: NavigationPaneTheme.of(context).iconPadding ??
                  const EdgeInsets.all(10.0),
              child: const Text("Folders"),
            ),
            PaneItemSeparator().build(context, Axis.horizontal),
          ],
        ),
        footerItems: [
          PaneItemSeparator(),
          PaneItemAction(
            icon: const Icon(FluentIcons.add),
            title: const Text("Add Folder"),
            onTap: () {
              setState(() {
                counter++;
              });
            },
          ),
          PaneItem(
            title: const Text("Settings"),
            icon: const Icon(FluentIcons.settings),
          ),
        ],
        items: list,
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

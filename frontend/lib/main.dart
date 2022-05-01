import 'package:fluent_ui/fluent_ui.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todo/fluent/app.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:todo/macos/app.dart';
import 'package:todo/material/app.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Parse().initialize(
    "myAppId",
    "http://localhost:3000/parse",
    debug: true,
    liveQueryUrl: "ws://localhost:3000/",
    coreStore: await CoreStoreSharedPrefsImp.getInstance(),
  );

  const useFluent = true;

  if (useFluent) {
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

    runApp(const TodoFluentApp());
  } else {
    runApp(const TodoMacosApp());
  }
}

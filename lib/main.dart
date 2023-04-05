import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_encryption_app/src/app_widget.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitle('IT Tools');
    await windowManager.setTitleBarStyle(TitleBarStyle.normal);
    await windowManager.setBackgroundColor(Colors.transparent);
    await windowManager.setSize(const Size(755, 620));
    await windowManager.setMinimumSize(const Size(755, 620));
    // await windowManager.center();
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);
  });
  runApp(const AppWidget());
}

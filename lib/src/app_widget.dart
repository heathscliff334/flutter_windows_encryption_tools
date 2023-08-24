import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_encryption_app/src/blocs/encryption/cubit/encryption_cubit.dart';
import 'package:flutter_encryption_app/src/res/globals.dart';
import 'package:flutter_encryption_app/src/services/storage/prefs.dart';
import 'package:flutter_encryption_app/src/views/data/data_view.dart';

import 'package:flutter_encryption_app/src/views/encryption/home_view.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget>
    with AutomaticKeepAliveClientMixin<AppWidget> {
  @override
  bool get wantKeepAlive => true;
  int index = 0;
  bool checked = false;
  PageController controller = PageController();
  Duration pageChanging = const Duration(milliseconds: 400);
  List<NavigationPaneItem> items = [
    PaneItem(
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: const Text("test"),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: const Text("test"),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: const Text("test"),
    ),
  ];
  _getPrefs() {
    Prefs.getString('');
  }

  // This widget is the root of your application.
  @override
  void initState() {
    controller = PageController(initialPage: index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => EncryptionCubit())],
      child: FluentApp(
        title: 'Flutter Demo',
        themeMode: themeMode.value,
        // theme: ThemeData(
        //     scaffoldBackgroundColor: Colors.white,
        //     accentColor: Colors.blue,
        //     iconTheme: const IconThemeData(size: 24)),
        // darkTheme: ThemeData(
        //     scaffoldBackgroundColor: Colors.black,
        //     accentColor: Colors.blue,
        //     iconTheme: const IconThemeData(size: 24)),
        theme: FluentThemeData(
            brightness: Brightness.light, accentColor: Colors.orange),
        darkTheme: FluentThemeData(
            brightness: Brightness.dark, accentColor: Colors.blue),

        home: NavigationView(
          appBar: NavigationAppBar(
              title: const Text("Fluent Design App Bar"),
              actions: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerRight,
                child: ToggleSwitch(
                  checked: isDark.value,
                  onChanged: (v) => setState(() {
                    isDark.value = v;
                    isDark.value
                        ? themeMode.value = ThemeMode.dark
                        : themeMode.value = ThemeMode.light;
                    isDark.notifyListeners();

                    debugPrint(isDark.value.toString());
                  }),
                ),
              )),
          pane: NavigationPane(
              selected: index,
              onChanged: (newIndex) {
                // print("Current => $index");
                setState(() {
                  index = newIndex;
                  // controller.animateToPage(
                  //   index,
                  //   duration: pageChanging,
                  //   curve: Curves.fastLinearToSlowEaseIn,
                  // );
                });
                // print("New => $index");
              },
              displayMode: PaneDisplayMode.auto,
              items: [
                PaneItem(
                  icon: const Icon(FluentIcons.code),
                  title: const Text("Sample Page 1"),
                  body: ScaffoldPage(
                    header: Text(
                      "Sample Page 1",
                      style: TextStyle(fontSize: 60),
                    ),
                    padding: EdgeInsets.only(left: 20),

                    /// Content property
                    ///
                    /// The content property specifies the other widgets in the ScaffoldPage,
                    /// similar to the body property in a Material Scaffold
                    content: Column(
                      children: [
                        Center(
                          child: Text("Welcome to Page 1!"),
                        ),
                        // Button(
                        //     child: const Text("Page 2"),
                        //     onPressed: () {
                        //       Navigator.push(
                        //           context,
                        //           FluentPageRoute(
                        //               builder: (context) => const HomeView()));
                        //     })
                      ],
                    ),
                  ),
                ),
                PaneItem(
                    icon: const Icon(FluentIcons.encryption),
                    title: const Text("Encryption"),
                    body: EncryptionView()),
                PaneItem(
                    icon: const Icon(FluentIcons.user_sync),
                    title: const Text("Sample Page 3"),
                    body: const DataView()),
              ]),

          // content: NavigationBody(
          // content: PageView(
          //   // index: index,
          //   controller: controller,
          //   onPageChanged: onPageChanged,
          //   children: const [
          //     ScaffoldPage(
          //       header: Text(
          //         "Sample Page 1",
          //         style: TextStyle(fontSize: 60),
          //       ),
          //       padding: EdgeInsets.only(left: 20),

          //       /// Content property
          //       ///
          //       /// The content property specifies the other widgets in the ScaffoldPage,
          //       /// similar to the body property in a Material Scaffold
          //       content: Column(
          //         children: [
          //           Center(
          //             child: Text("Welcome to Page 1!"),
          //           ),
          //           // Button(
          //           //     child: const Text("Page 2"),
          //           //     onPressed: () {
          //           //       Navigator.push(
          //           //           context,
          //           //           FluentPageRoute(
          //           //               builder: (context) => const HomeView()));
          //           //     })
          //         ],
          //       ),
          //     ),
          //     EncryptionView(),
          //     ScaffoldPage(
          //       header: Text(
          //         "Sample Page 2",
          //         style: TextStyle(fontSize: 60),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    print("page: $page");
    if (mounted) {
      setState(() {
        index = page;
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:provider/provider.dart';
import 'package:palette/theme.dart';
import 'package:palette/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyThemeModel(),
      child: MyThemedApp(),
    ),
  );
}

class MyThemedApp extends StatelessWidget {
  const MyThemedApp ({super.key});

  @override
  Widget build(BuildContext context) {
    var routes = {
      '/': (context) => const MyHomePage(),
    };
    return Consumer<MyThemeModel>(
      builder: (context, myThemeModel, child) {
        return DynamicColorBuilder(
            builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
              if (myThemeModel.useDynamicColor==true&&lightDynamic!=null&&darkDynamic!=null) {
                myThemeModel.setThemeColor(lightDynamic.primary,needBuild: false);
              }
              return MaterialApp(
                title: "调色盘",
                theme: myThemeModel.themeData,
                darkTheme: myThemeModel.themeData,
                initialRoute: '/',
                routes: routes,
              );
            }
        );
      },
    );
  }
}
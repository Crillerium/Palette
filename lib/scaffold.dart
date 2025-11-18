import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:palette/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  final String currentRoute;

  const MyDrawer({super.key, required this.currentRoute});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _launchUrl() async {
    Uri uri = Uri.parse("https://github.com/Crillerium/palette");
    if (!await launchUrl(uri) && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("打开失败"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10.0),
          duration: Duration(milliseconds: 3000),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Text(
              '菜单',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text("调色盘"),
            selected: widget.currentRoute == "/",
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.input_rounded),
            title: const Text("开源仓库"),
            onTap: () {
              Navigator.pop(context);
              _launchUrl();
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outlined),
            title: const Text("应用信息"),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationIcon: Icon(Icons.palette_outlined),
                applicationName: "调色盘",
                applicationVersion: "1.0.0",
                children: [Text("纯享版调色盘\n没有其他任何功能❤️")],
              );
            },
          ),
        ],
      ),
    );
  }
}

class MyFloatingButton extends StatefulWidget {
  const MyFloatingButton({super.key});

  @override
  State<MyFloatingButton> createState() => _MyFloatingButtonState();
}

class _MyFloatingButtonState extends State<MyFloatingButton> {
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<MyThemeModel>(context);
    return FloatingActionButton(
      onPressed: themeModel.toggleMode,
      tooltip: themeModel.followSystem
          ? "跟随系统"
          : (themeModel.themeMode ? "日间模式" : "夜间模式"),
      child: themeModel.followSystem
          ? Icon(Icons.auto_mode)
          : Icon(themeModel.themeMode ? Icons.light_mode : Icons.dark_mode),
    );
  }
}

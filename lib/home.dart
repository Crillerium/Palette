import 'package:flutter/material.dart';
import 'package:palette/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:palette/theme.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<MyThemeModel>(context);

    Future<void> setColorFromImage() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);
        FileImage imageProvider = FileImage(file);
        try {
          ColorScheme scheme = await ColorScheme.fromImageProvider(
            provider: imageProvider,
            brightness: Brightness.light,
          );
          themeModel.toggleImageTheme(scheme.primary);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("生成配色方案成功！"),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10.0),
                duration: Duration(milliseconds: 3000),
              ),
            );
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("生成配色方案失败！"),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10.0),
                duration: Duration(milliseconds: 3000),
              ),
            );
          }
        }
      }
    }

    return Scaffold(
      drawer: MyDrawer(currentRoute: "/"),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: "打开菜单",
            );
          },
        ),
        title: const Text('调色盘'),
        backgroundColor: themeModel.useMaterial3
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 80),
        child: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.palette_outlined),
                  title: const Text("选择颜色"),
                  trailing: FilledButton.tonal(
                    // 更符合 M3 的按钮
                    onPressed: () {
                      setColorFromImage();
                    },
                    child: const Text("从图片获取"),
                  ),
                ),

                const Divider(),

                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(6),

                    child: ColorPicker(
                      // Use the screenPickerColor as start and active color.
                      color: themeModel.themeColor,
                      // Update the screenPickerColor using the callback.
                      onColorChanged: (Color color) =>
                          themeModel.setThemeColor(color),
                      width: 44,
                      height: 44,
                      borderRadius: 22,
                      heading: Text(
                        '选择颜色',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      subheading: Text(
                        '选择色调',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                ),

                const Divider(),
                SwitchListTile(
                  secondary: const Icon(Icons.design_services_outlined),
                  title: const Text("使用 Material 3 设计"),
                  value: themeModel.useMaterial3,
                  onChanged: (_) => themeModel.toggleMaterial3(),
                ),

                SwitchListTile(
                  secondary: const Icon(Icons.auto_awesome),
                  title: const Text("使用系统动态配色"),
                  value: themeModel.useDynamicColor,
                  onChanged: (_) => themeModel.toggleDynamic(),
                ),
              ],
            ),
          ),
        ),
      ),),
      floatingActionButton: MyFloatingButton(),
    );
  }
}

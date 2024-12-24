// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:plc_project/Components/Appbars.dart';
import 'package:plc_project/Components/ListTiles.dart';
import 'package:plc_project/Components/Navigation.dart';
import 'package:plc_project/Constant/buttons.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Widgets/AppWidgets.dart';
import 'package:theme_provider/theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeProvider.themeOf(context)
            .data
            .extension<SAPTheme>()!
            .appBarBackgroundColor,
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SAPSliverAppBar(
              title: 'Settings',
              leading: SAPIconButton(
                  icon: Icons.arrow_back,
                  onPress: () {
                    SAPPageNavigation.back(context: context);
                  }),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SAPListTile(
                  icon: Icons.phonelink_setup_outlined,
                  title: 'App Permissions',
                  subtitle: 'Manage app permissions',
                  onTap: () => SAPPageNavigation.next(
                      page: const AppPermissions(), context: context),
                  trailing: SAPIconButton(
                      icon: Icons.arrow_forward_outlined, onPress: () {}),
                  isUnderline: true),
              SAPListTile(
                  icon: Icons.palette_outlined,
                  title: 'Theme',
                  subtitle: 'Manage app Themes',
                  onTap: () => showDialog(
                      context: context,
                      builder: (_) => ThemeConsumer(child: ThemeDialog())),
                  trailing: SAPIconButton(
                      icon: Icons.arrow_forward_outlined, onPress: () {}),
                  isUnderline: true),
              // SAPListTile(
              //     icon: Icons.translate_outlined,
              //     title: 'Langauge',
              //     subtitle: 'Manage app Langauage',
              //     onTap: () => SAPPageNavigation.next(
              //         page: const AppLanguages(), context: context),
              //     trailing: SAPIconButton(
              //         icon: Icons.arrow_forward_outlined, onPress: () {}),
              //     isUnderline: true)
            ]))
          ],
        ));
  }
}

// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:plc_project/Components/DataCard.dart';
import 'package:plc_project/Constant/buttons.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/dimensions.dart';
import 'package:plc_project/Constant/textfiledstyle.dart';
import 'package:theme_provider/theme_provider.dart';

abstract class SAPListTiles {
  String title;
  String subtitle;
  bool isUnderline;
  IconData? icon;
  void Function()? onIconTap;
  void Function()? onTap;
  Widget? trailing;
  EdgeInsets? padding;
  SAPListTiles(
      {required this.icon,
      this.onIconTap,
      required this.isUnderline,
      required this.onTap,
      required this.subtitle,
      required this.title,
      required this.trailing,
      required this.padding});
}

class SAPListTile extends StatefulWidget implements SAPListTiles {
  @override
  String title;
  @override
  String subtitle;
  @override
  bool isUnderline;
  @override
  IconData? icon;
  @override
  void Function()? onTap;

  SAPListTile(
      {super.key,
      this.onIconTap,
      required this.title,
      required this.subtitle,
      this.icon,
      this.onTap,
      required this.isUnderline,
      this.trailing,
      this.padding});

  @override
  State<SAPListTile> createState() => _SAPListTileState();

  @override
  Widget? trailing;

  @override
  EdgeInsets? padding;

  @override
  void Function()? onIconTap;
}

class _SAPListTileState extends State<SAPListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? SAPDimensions.componentZeroPadding,
      child: Container(
        color: ThemeProvider.themeOf(context)
            .data
            .extension<SAPTheme>()!
            .listTileBackgroundColor,
        padding: SAPDimensions.componentHorizontalPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              trailing: SizedBox(
                  width: 100,
                  child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: widget.trailing)),
              onTap: widget.onTap,
              contentPadding: SAPDimensions.componentZeroPadding,
              leading: (widget.icon != null)
                  ? CircleAvatar(
                      backgroundColor: ThemeProvider.themeOf(context)
                          .data
                          .extension<SAPTheme>()!
                          .listTileIconBackgroundColor,
                      child: SAPIconButton(
                        icon: widget.icon,
                        onPress: widget.onIconTap,
                      ),
                    )
                  : null,
              title: Transform.translate(
                  offset: (widget.subtitle == '')
                      ? const Offset(0, 5)
                      : const Offset(
                          0,
                          0,
                        ),
                  child: Text(widget.title,
                      style: SAPTextSTyle.listTileTitleTextStyle(context))),
              subtitle: Text(
                widget.subtitle,
                style: SAPTextSTyle.listTileSubTitleTextStyle(context),
              ),
            ),
            if (widget.isUnderline)
              Divider(
                thickness: 1,
                color: ThemeProvider.themeOf(context)
                    .data
                    .extension<SAPTheme>()!
                    .dividerColor,
                height: 1,
              )
          ],
        ),
      ),
    );
  }
}

class SAPExpansionTile extends StatefulWidget implements SAPDetailsCards {
  SAPExpansionTile(
      {super.key,
      this.buttons,
      required this.dataList,
      required this.isUnderline,
      required this.onTap,
      required this.title,
      required this.subtitle,
      this.icon,
      this.inputs,
      this.trailing})
      : padding = SAPDimensions.componentZeroPadding;

  @override
  State<SAPExpansionTile> createState() => _SAPExpansionTileState();
  @override
  List<Widget>? buttons;
  @override
  Map<String, String> dataList;
  @override
  IconData? icon;
  @override
  List? inputs;
  @override
  bool isUnderline;
  @override
  void Function()? onTap;
  @override
  String subtitle;
  @override
  String title;

  @override
  Widget? trailing;

  @override
  EdgeInsets? padding;

  @override
  void Function()? onIconTap;
}

class _SAPExpansionTileState extends State<SAPExpansionTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 90),
      child: isExpanded
          ? SAPDetailsCard(
              icon: widget.icon,
              isUnderline: widget.isUnderline,
              title: widget.title,
              subtitle: widget.subtitle,
              buttons: widget.buttons,
              dataList: widget.dataList,
              inputs: widget.inputs,
              onTap: () {
                setState(() {
                  isExpanded = false;
                });
              },
            )
          : SAPListTile(
              trailing: widget.trailing,
              icon: widget.icon,
              title: widget.title,
              subtitle: widget.subtitle,
              isUnderline: true,
              onTap: () {
                setState(() {
                  isExpanded = true;
                });
              },
            ),
    );
  }
}

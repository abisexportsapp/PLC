// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:plc_project/Components/ListTiles.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/dimensions.dart';
import 'package:plc_project/Constant/textfiledstyle.dart';
import 'package:theme_provider/theme_provider.dart';

class SAPCheckBox extends StatelessWidget {
  String? title;
  String? subtitle;
  bool? value;
  void Function(bool? value)? onChanged;
  SAPCheckBox(
      {super.key,
      required this.value,
      required this.onChanged,
      this.subtitle,
      this.title});

  @override
  Widget build(BuildContext context) {
    return (title == null)
        ? Checkbox(
            value: value,
            activeColor: ThemeProvider.themeOf(context)
                .data
                .extension<SAPTheme>()!
                .primaryButtonBackgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: SAPDimensions.checkBoxBorderRadius),
            side: WidgetStateBorderSide.resolveWith(
              (states) => BorderSide(
                  width: 2.0,
                  color: ThemeProvider.themeOf(context)
                      .data
                      .extension<SAPTheme>()!
                      .globalTextColor),
            ),
            onChanged: onChanged)
        : SAPListTile(
            title: title ?? '',
            subtitle: subtitle ?? '',
            isUnderline: false,
            trailing: Checkbox(
                value: value,
                activeColor: ThemeProvider.themeOf(context)
                    .data
                    .extension<SAPTheme>()!
                    .primaryButtonBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: SAPDimensions.checkBoxBorderRadius),
                side: WidgetStateBorderSide.resolveWith(
                  (states) => BorderSide(
                      width: 2.0,
                      color: ThemeProvider.themeOf(context)
                          .data
                          .extension<SAPTheme>()!
                          .globalTextColor),
                ),
                onChanged: onChanged),
          );
  }
}

class SAPSwitch extends StatelessWidget {
  String? title;
  String? subtitle;
  bool? value;
  IconData? icon;
  void Function(bool? value)? onChanged;
  SAPSwitch(
      {super.key,
      required this.onChanged,
      required this.value,
      this.icon,
      this.title,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return (title == null)
        ? Checkbox(
            value: value,
            activeColor: ThemeProvider.themeOf(context)
                .data
                .extension<SAPTheme>()!
                .primaryButtonBackgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: SAPDimensions.checkBoxBorderRadius),
            side: WidgetStateBorderSide.resolveWith(
              (states) => BorderSide(
                  width: 2.0,
                  color: ThemeProvider.themeOf(context)
                      .data
                      .extension<SAPTheme>()!
                      .globalTextColor),
            ),
            onChanged: onChanged)
        : SAPListTile(
            title: title ?? '',
            subtitle: subtitle ?? '',
            icon: icon,
            isUnderline: false,
            trailing: Switch(
                inactiveTrackColor: ThemeProvider.themeOf(context)
                    .data
                    .extension<SAPTheme>()!
                    .secondaryButtonBackgroundColor,
                activeColor: ThemeProvider.themeOf(context)
                    .data
                    .extension<SAPTheme>()!
                    .primaryButtonBackgroundColor,
                value: value ?? false,
                onChanged: onChanged));
  }
}

class SAPRadioButton extends StatefulWidget {
  String name;
  SAPRadioButton({super.key, required this.name});

  @override
  State<SAPRadioButton> createState() => _SAPRadioButtonState();
}

class _SAPRadioButtonState extends State<SAPRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SAPDimensions.componentVerticalPadding,
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name,
                style: SAPTextSTyle.textfieldHeaderStyle(context)),
            const SizedBox(
              height: 10,
            ),
            RadioListTile(
              title: Text(widget.name,
                  style: SAPTextSTyle.textfieldHeaderStyle(context)),
              value: 'a',
              groupValue: 'SAPRadioButton',
              onChanged: (value) {},
            ),
            RadioListTile(
              title: Text(widget.name,
                  style: SAPTextSTyle.textfieldHeaderStyle(context)),
              value: 'b',
              groupValue: 'SAPRadioButton',
              onChanged: (value) {},
            )
          ],
        ),
      ),
    );
  }
}

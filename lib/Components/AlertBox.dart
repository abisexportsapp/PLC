import 'package:flutter/material.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/dimensions.dart';
import 'package:plc_project/Constant/textfiledstyle.dart';
import 'package:theme_provider/theme_provider.dart';

class SAPAlertBox {
  BuildContext context;
  String title;
  String subTitle;
  List<Widget>? actions;
  SAPAlertBox(
      {required this.context,
      required this.title,
      required this.subTitle,
      this.actions}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        elevation: 0,
        backgroundColor: ThemeProvider.themeOf(context)
            .data
            .extension<SAPTheme>()!
            .alertBoxBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: SAPDimensions.alertBoxBorderRadius,
        ),
        title: Text(
          title,
          style: SAPTextSTyle.alertBoxTitleTextStyle(context),
        ),
        content: Text(
          subTitle,
          style: SAPTextSTyle.alertBoxsubTitleTextStyle(context),
        ),
        actions: actions,
      ),
    );
  }
}

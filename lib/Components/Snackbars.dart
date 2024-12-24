// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/dimensions.dart';
import 'package:plc_project/Constant/textfiledstyle.dart';
import 'package:theme_provider/theme_provider.dart';

class SAPSnackBar {
  BuildContext context;
  IconData? icon;
  String message;
  Widget? actionButton;
  Color? backgroundColor;
  SAPSnackBar(
      {required this.context,
      required this.message,
      this.icon,
      this.actionButton}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: SAPDimensions.componentBorderRadius,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        elevation: 2,
        content: Row(
          children: [
            if (icon != null)
              Icon(
                icon,
                size: SAPDimensions.iconSize,
                color: ThemeProvider.themeOf(context)
                    .data
                    .extension<SAPTheme>()!
                    .primaryButtonIconColor,
              ),
            if (icon != null)
              const SizedBox(
                width: 20,
              ),
            Expanded(
                child: Text(
              message,
              style: SAPTextSTyle.snackbarTextStyle(context),
              maxLines: 2,
            )),
            if (actionButton != null) actionButton ?? Container()
          ],
        )));
  }
  SAPSnackBar.alert(
      {required this.context,
      required this.message,
      this.icon,
      this.actionButton}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: SAPDimensions.componentBorderRadius,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color.fromARGB(255, 191, 77, 77),
        elevation: 2,
        content: Row(
          children: [
            if (icon != null)
              Icon(
                icon,
                size: SAPDimensions.iconSize,
                color:
                    ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
              ),
            if (icon != null)
              const SizedBox(
                width: 20,
              ),
            Expanded(
                child: Text(
              message,
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
              maxLines: 2,
            )),
            if (actionButton != null) actionButton ?? Container()
          ],
        )));
  }
}

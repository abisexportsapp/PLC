//This file contains all the Text Styles which is required for application UI Part .
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/dimensions.dart';
import 'package:theme_provider/theme_provider.dart';

class SAPTextSTyle {
  static TextStyle textfieldHeaderStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .globalHeaderColor,
          fontSize: SAPDimensions.textFieldHeaderSize); // for textfield header
  static TextStyle textfieldFocusedHeaderStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .primaryButtonBackgroundColor,
          fontSize: SAPDimensions
              .textFieldHeaderSize); // for textfield header when it is focused .
  static TextStyle textfieldFocusedHeaderErrorStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: Colors.red,
          fontSize: SAPDimensions
              .textFieldHeaderSize); // for textfield header when it is error .
  static TextStyle dataCardtextfieldHeaderStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .globalHeaderColor,
          fontSize: SAPDimensions.textFieldinputSize); // for textfield header
  static TextStyle dataCardtextfieldFocusedHeaderStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .primaryButtonBackgroundColor,
          fontSize: SAPDimensions
              .textFieldinputSize); // for textfield header when it is focused .
  static TextStyle textfieldinputStyle(
          BuildContext context) =>
      GoogleFonts.poppins(
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .globalTextColor,
          fontSize: SAPDimensions.textFieldinputSize); // for textfield input
  static TextStyle hintTextinputStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontSize: SAPDimensions.textFieldinputSize,
          color: Colors.grey.shade600);
  static TextStyle buttonTextStyle(BuildContext context) => GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: ThemeProvider.themeOf(context)
          .data
          .extension<SAPTheme>()!
          .primaryButtonTextColor); // for Button Text
  static TextStyle whiteColorTextStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor);
  static TextStyle secondaryButtonTextStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .secondaryButtonTextColor); // for secondary button text
  static TextStyle appBarTitleTextStyle(BuildContext context) =>
      GoogleFonts.poppins(
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .globalTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w700); // for any Appbar Title
  static TextStyle listTileTitleTextStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .globalTextColor); // for ListTile Title
  static TextStyle listTileSubTitleTextStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .globalTextColor); // for listTile sub title
  static TextStyle dataCardKeyTextStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .globalTextColor); // for data Card Key
  static TextStyle dataCardValueTextStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .globalTextColor); // for data Card value
  static TextStyle snackbarTextStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .snackbarTextColor); // for data Card value
  static TextStyle alertBoxTitleTextStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .alertBoxTitleColor); // for Alert Box Title
  static TextStyle alertBoxsubTitleTextStyle(BuildContext context) =>
      GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .alertBoxsubTitleColor); // for Alert Box Subtitle
  static TextStyle graphValueTextStyle(
          BuildContext context) =>
      GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .globalTextColor);
  static TextStyle errorTextStyle(BuildContext context) => GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w400,
      );
}

// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plc_project/Components/Navigation.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/dimensions.dart';
import 'package:plc_project/Constant/loading.dart';
import 'package:plc_project/Constant/textfiledstyle.dart';
import 'package:theme_provider/theme_provider.dart';

abstract class SAPButtons {
  bool isLoading;
  String name;
  IconData? icon;
  void Function()? onPress;
  EdgeInsetsGeometry? padding;
  SAPButtons(
      {required this.onPress,
      required this.name,
      this.icon,
      this.padding,
      this.isLoading = false});
}

class SAPPrimaryButton extends StatefulWidget implements SAPButtons {
  @override
  String name;
  @override
  IconData? icon;
  @override
  void Function()? onPress;
  @override
  EdgeInsetsGeometry? padding;
  SAPPrimaryButton(
      {super.key,
      required this.onPress,
      required this.name,
      this.icon,
      this.padding,
      this.isLoading = false});

  @override
  State<SAPPrimaryButton> createState() => _SAPPrimaryButtonState();

  @override
  bool isLoading;
}

class _SAPPrimaryButtonState extends State<SAPPrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: widget.padding,
        width: double.maxFinite,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: ThemeProvider.themeOf(context)
                    .data
                    .extension<SAPTheme>()!
                    .primaryButtonBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: SAPDimensions.componentBorderRadius,
                )),
            onPressed: widget.isLoading ? null : widget.onPress,
            child: widget.isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: SAPLoadingIndicator.button(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null)
                        Icon(
                          widget.icon,
                          size: SAPDimensions.iconSize,
                          color: ThemeProvider.themeOf(context)
                              .data
                              .extension<SAPTheme>()!
                              .primaryButtonIconColor,
                        ),
                      if (widget.icon != null)
                        const SizedBox(
                          width: 20,
                        ),
                      Text(
                        widget.name,
                        style: SAPTextSTyle.buttonTextStyle(context),
                      ),
                    ],
                  )));
  }
}

class SAPIconButton extends StatefulWidget implements SAPButtons {
  SAPIconButton(
      {super.key,
      required this.icon,
      required this.onPress,
      this.padding,
      this.isLoading = false})
      : name = '';

  @override
  State<SAPIconButton> createState() => _SAPIconButtonState();

  @override
  String name;

  @override
  void Function()? onPress;

  @override
  EdgeInsetsGeometry? padding;

  @override
  IconData? icon;

  @override
  bool isLoading;
}

class _SAPIconButtonState extends State<SAPIconButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        padding: SAPDimensions.componentZeroPadding,
        icon: widget.isLoading
            ? SizedBox(width: 30, child: SAPLoadingIndicator())
            : Icon(widget.icon,
                size: SAPDimensions.iconSize,
                color: ThemeProvider.themeOf(context)
                    .data
                    .extension<SAPTheme>()!
                    .iconButtonColor),
        style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: SAPDimensions.componentBorderRadius)),
        onPressed: widget.isLoading ? null : widget.onPress,
      ),
    );
  }
}

class SAPSecondaryButton extends StatefulWidget implements SAPButtons {
  @override
  String name;
  @override
  IconData? icon;
  @override
  void Function()? onPress;
  @override
  EdgeInsetsGeometry? padding;
  SAPSecondaryButton(
      {super.key,
      required this.onPress,
      required this.name,
      this.icon,
      this.padding,
      this.isLoading = false});

  @override
  State<SAPSecondaryButton> createState() => _SAPSecondaryButtonState();

  @override
  bool isLoading;
}

class _SAPSecondaryButtonState extends State<SAPSecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 41,
        padding: widget.padding,
        width: double.maxFinite,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: ThemeProvider.themeOf(context)
                    .data
                    .extension<SAPTheme>()!
                    .primaryButtonBackgroundColor,
                backgroundColor: ThemeProvider.themeOf(context)
                    .data
                    .extension<SAPTheme>()!
                    .secondaryButtonBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: SAPDimensions.componentBorderRadius,
                )),
            onPressed: widget.isLoading ? null : widget.onPress,
            child: widget.isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: SAPLoadingIndicator.button(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null)
                        Icon(
                          widget.icon,
                          size: SAPDimensions.iconSize,
                          color: ThemeProvider.themeOf(context)
                              .data
                              .extension<SAPTheme>()!
                              .secondaryButtonIconColor,
                        ),
                      if (widget.icon != null)
                        const SizedBox(
                          width: 20,
                        ),
                      Expanded(
                        child: Text(
                          widget.name,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: SAPTextSTyle.secondaryButtonTextStyle(context),
                        ),
                      ),
                    ],
                  )));
  }
}

class SAPCancelButton extends StatefulWidget implements SAPButtons {
  @override
  String name;
  @override
  IconData? icon;
  @override
  void Function()? onPress;
  @override
  EdgeInsetsGeometry? padding;
  SAPCancelButton(
      {super.key,
      required this.onPress,
      required this.name,
      this.icon,
      this.padding,
      this.isLoading = false});

  @override
  State<SAPCancelButton> createState() => _SAPCancelButtonState();

  @override
  bool isLoading;
}

class _SAPCancelButtonState extends State<SAPCancelButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: widget.padding,
        width: double.maxFinite,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: ThemeProvider.themeOf(context)
                    .data
                    .extension<SAPTheme>()!
                    .cancelButtonBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: SAPDimensions.componentBorderRadius,
                )),
            onPressed: widget.isLoading ? null : widget.onPress,
            child: widget.isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: SAPLoadingIndicator.button(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null)
                        Icon(
                          widget.icon,
                          size: SAPDimensions.iconSize,
                          color: ThemeProvider.themeOf(context)
                              .data
                              .extension<SAPTheme>()!
                              .cancelButtonIconColor,
                        ),
                      if (widget.icon != null)
                        const SizedBox(
                          width: 20,
                        ),
                      Text(
                        widget.name,
                        style: GoogleFonts.poppins(
                            color: ThemeProvider.themeOf(context)
                                .data
                                .extension<SAPTheme>()!
                                .cancelButtonTextColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )));
  }
}

class SAPTextButton extends StatefulWidget implements SAPButtons {
  Color color;
  SAPTextButton(
      {super.key,
      required this.onPress,
      required this.name,
      this.icon,
      this.padding,
      this.isLoading = false})
      : color = Colors.blueAccent;
  SAPTextButton.cancel(
      {super.key,
      required this.onPress,
      required this.name,
      this.icon,
      this.padding,
      this.isLoading = false})
      : color = Colors.red;
  @override
  State<SAPTextButton> createState() => _SAPTextButtonState();
  @override
  IconData? icon;
  @override
  String name;
  @override
  void Function()? onPress;
  @override
  EdgeInsetsGeometry? padding;
  @override
  bool isLoading;
}

class _SAPTextButtonState extends State<SAPTextButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: widget.padding,
        child: TextButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor:
                    ThemeProvider.themeOf(context).data.shadowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: SAPDimensions.componentBorderRadius,
                )),
            onPressed: widget.isLoading ? null : widget.onPress,
            child: widget.isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: SAPLoadingIndicator.button(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null)
                        Icon(widget.icon,
                            size: SAPDimensions.iconSize,
                            color: ThemeProvider.themeOf(context)
                                .data
                                .extension<SAPTheme>()!
                                .textButtonIconColor),
                      if (widget.icon != null)
                        const SizedBox(
                          width: 20,
                        ),
                      Text(
                        widget.name,
                        style: GoogleFonts.poppins(
                            color: ThemeProvider.themeOf(context)
                                .data
                                .extension<SAPTheme>()!
                                .textButtonColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )));
  }
}

class SAPCardButton extends StatelessWidget {
  String name;
  String icon;
  double height;
  double width;
  void Function()? onPressed;
  Widget? navigateTo;
  SAPCardButton(
      {super.key,
      required this.icon,
      required this.name,
      this.onPressed,
      required this.height,
      required this.width});

  SAPCardButton.navigate(
      {super.key,
      required this.icon,
      required this.name,
      this.onPressed,
      required this.height,
      required this.navigateTo,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(1, 2),
          ),
        ],
        color: ThemeProvider.themeOf(context)
            .data
            .extension<SAPTheme>()!
            .appBarBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: (navigateTo != null)
            ? () => SAPPageNavigation.next(page: navigateTo!, context: context)
            : onPressed,
        style: OutlinedButton.styleFrom(
            elevation: 0,
            side: BorderSide(
              color: Colors.grey,
              width: 0.8,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(),
              Image.asset(
                (ThemeProvider.themeOf(context).id == "sapibtheme")
                    ? "assets/${icon}_green.png"
                    : "assets/${icon}_blue.png",
                height: height * 0.5,
                width: width * 0.5,
              ),
              Text(
                name,
                style: GoogleFonts.poppins(
                    color: ThemeProvider.themeOf(context)
                        .data
                        .extension<SAPTheme>()!
                        .cardButtonTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

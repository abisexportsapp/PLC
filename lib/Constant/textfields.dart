// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/dimensions.dart';
import 'package:plc_project/Constant/textfiledstyle.dart';
import 'package:theme_provider/theme_provider.dart';

abstract class SAPTextfields {
  bool? enabled;
  String? defaultValue;
  List<TextInputFormatter>? inputFormatters;
  String? errorText;
  Widget? suffix;
  TextEditingController? controller;
  TextInputType? keyboardType;
  bool? hide;
  TextInputAction? textInputAction;
  String name;
  String hintText;
  String? leftFooter;
  String? rightFooter;
  void Function(String)? onChanged;
  SAPTextfields(
      {required this.keyboardType,
      this.enabled,
      this.defaultValue,
      this.inputFormatters,
      required this.textInputAction,
      required this.hintText,
      required this.name,
      this.suffix,
      this.hide,
      required this.controller,
      required this.onChanged,
      this.errorText});
}

class SAPTextfieldWithHeader extends StatefulWidget implements SAPTextfields {
  SAPTextfieldWithHeader(
      {super.key,
      this.textInputAction,
      this.keyboardType,
      required this.hintText,
      required this.name,
      this.controller,
      this.onChanged,
      this.defaultValue,
      this.errorText,
      this.inputFormatters,
      this.hide,
      this.leftFooter,
      this.enabled,
      this.suffix,
      this.rightFooter});

  @override
  State<SAPTextfieldWithHeader> createState() => _SAPTextfieldWithHeaderState();

  @override
  String hintText;

  @override
  String name;

  @override
  TextEditingController? controller;

  @override
  void Function(String value)? onChanged;

  @override
  String? errorText;

  @override
  String? leftFooter;

  @override
  String? rightFooter;

  @override
  TextInputType? keyboardType;

  @override
  TextInputAction? textInputAction;

  @override
  bool? hide;

  @override
  Widget? suffix;

  @override
  List<TextInputFormatter>? inputFormatters;

  @override
  bool? enabled;

  @override
  String? defaultValue;
}

class _SAPTextfieldWithHeaderState extends State<SAPTextfieldWithHeader> {
  bool isFocused = false;
  FocusNode focus = FocusNode();
  TextEditingController defaultValue = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.defaultValue != null && widget.controller == null) {
      defaultValue.text = widget.defaultValue ?? "";
    }
    focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      isFocused = focus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SAPDimensions.componentVerticalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name,
              style: (widget.errorText != null)
                  ? SAPTextSTyle.textfieldFocusedHeaderErrorStyle(context)
                  : isFocused
                      ? SAPTextSTyle.textfieldFocusedHeaderStyle(context)
                      : SAPTextSTyle.textfieldHeaderStyle(context)),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: (widget.errorText != null) ? 70 : 50,
            child: TextField(
              enabled: widget.enabled,
              inputFormatters: widget.inputFormatters,
              textInputAction: widget.textInputAction,
              obscureText: widget.hide ?? false,
              keyboardType: widget.keyboardType,
              controller: (widget.defaultValue != null)
                  ? defaultValue
                  : widget.controller,
              onChanged: widget.onChanged,
              style: SAPTextSTyle.textfieldinputStyle(context),
              focusNode: focus,
              decoration: InputDecoration(
                  errorText: widget.errorText,
                  errorStyle: SAPTextSTyle.errorTextStyle(context),
                  hintText: widget.hintText,
                  suffixIcon: widget.suffix,
                  hintStyle: SAPTextSTyle.hintTextinputStyle(context),
                  contentPadding:
                      const EdgeInsets.only(top: 5, left: 15, right: 15),
                  focusColor: ThemeProvider.themeOf(context)
                      .data
                      .extension<SAPTheme>()!
                      .primaryButtonBackgroundColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ThemeProvider.themeOf(context)
                            .data
                            .extension<SAPTheme>()!
                            .primaryButtonBackgroundColor,
                        width: 1.2),
                    borderRadius: SAPDimensions.componentBorderRadius,
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: SAPDimensions.componentBorderRadius,
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.2)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade500, width: 1.2),
                    borderRadius: SAPDimensions.componentBorderRadius,
                  )),
            ),
          ),
          if (widget.leftFooter != null || widget.rightFooter != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: (widget.leftFooter != null &&
                        widget.rightFooter != null)
                    ? [
                        Text(
                          widget.leftFooter!,
                          style: SAPTextSTyle.dataCardValueTextStyle(context),
                        ),
                        Text(
                          widget.rightFooter!,
                          style: SAPTextSTyle.dataCardValueTextStyle(context),
                        ),
                      ]
                    : (widget.leftFooter != null)
                        ? [
                            Text(
                              widget.leftFooter!,
                              style:
                                  SAPTextSTyle.dataCardValueTextStyle(context),
                            ),
                            Expanded(child: Container())
                          ]
                        : (widget.rightFooter != null)
                            ? [
                                Expanded(child: Container()),
                                Text(
                                  widget.rightFooter!,
                                  style: SAPTextSTyle.dataCardValueTextStyle(
                                      context),
                                ),
                              ]
                            : [
                                Text(
                                  widget.leftFooter!,
                                  style: SAPTextSTyle.dataCardValueTextStyle(
                                      context),
                                ),
                                Text(
                                  widget.rightFooter!,
                                  style: SAPTextSTyle.dataCardValueTextStyle(
                                      context),
                                )
                              ],
              ),
            )
        ],
      ),
    );
  }
}

class SAPTextfieldWithDataCard extends StatefulWidget implements SAPTextfields {
  SAPTextfieldWithDataCard(
      {super.key,
      required this.hintText,
      required this.name,
      this.controller,
      this.onChanged,
      this.inputFormatters,
      this.errorText,
      this.suffix,
      this.hide,
      this.defaultValue,
      this.enabled,
      this.leftFooter,
      this.rightFooter});

  @override
  State<SAPTextfieldWithDataCard> createState() =>
      _SAPTextfieldWithDataCardState();

  @override
  String hintText;

  @override
  String name;

  @override
  TextEditingController? controller;

  @override
  void Function(String value)? onChanged;

  @override
  String? errorText;

  @override
  String? leftFooter;

  @override
  String? rightFooter;

  @override
  TextInputType? keyboardType;

  @override
  TextInputAction? textInputAction;

  @override
  bool? hide;

  @override
  Widget? suffix;

  @override
  List<TextInputFormatter>? inputFormatters;

  @override
  bool? enabled;

  @override
  String? defaultValue;
}

class _SAPTextfieldWithDataCardState extends State<SAPTextfieldWithDataCard> {
  bool isFocused = false;
  FocusNode focus = FocusNode();
  TextEditingController defaultValue = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.defaultValue != null && widget.controller == null) {
      defaultValue.text = widget.defaultValue ?? "";
    }
    focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      isFocused = focus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SAPDimensions.componentBottomPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name,
              style: (widget.errorText != null)
                  ? SAPTextSTyle.textfieldFocusedHeaderErrorStyle(context)
                  : isFocused
                      ? SAPTextSTyle.dataCardtextfieldFocusedHeaderStyle(
                          context)
                      : SAPTextSTyle.dataCardtextfieldHeaderStyle(context)),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: (widget.errorText != null) ? 80 : 50,
            child: TextField(
              obscureText: widget.hide ?? false,
              style: SAPTextSTyle.textfieldinputStyle(context),
              focusNode: focus,
              enabled: widget.enabled,
              controller: (widget.defaultValue != null)
                  ? defaultValue
                  : widget.controller,
              onChanged: widget.onChanged,
              textInputAction: widget.textInputAction,
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                  suffixIcon: widget.suffix,
                  errorText: widget.errorText,
                  hintText: widget.hintText,
                  hintStyle: SAPTextSTyle.hintTextinputStyle(context),
                  contentPadding:
                      const EdgeInsets.only(top: 5, left: 15, right: 15),
                  focusColor: ThemeProvider.themeOf(context)
                      .data
                      .extension<SAPTheme>()!
                      .primaryButtonBackgroundColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ThemeProvider.themeOf(context)
                            .data
                            .extension<SAPTheme>()!
                            .primaryButtonBackgroundColor,
                        width: 1.2),
                    borderRadius: SAPDimensions.componentBorderRadius,
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: SAPDimensions.componentBorderRadius,
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.2)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade500, width: 1.2),
                    borderRadius: SAPDimensions.componentBorderRadius,
                  )),
            ),
          ),
          if (widget.leftFooter != null || widget.rightFooter != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: (widget.leftFooter != null &&
                        widget.rightFooter != null)
                    ? [
                        Text(
                          widget.leftFooter!,
                          style: SAPTextSTyle.dataCardValueTextStyle(context),
                        ),
                        Text(
                          widget.rightFooter!,
                          style: SAPTextSTyle.dataCardValueTextStyle(context),
                        ),
                      ]
                    : (widget.leftFooter != null)
                        ? [
                            Text(
                              widget.leftFooter!,
                              style:
                                  SAPTextSTyle.dataCardValueTextStyle(context),
                            ),
                            Expanded(child: Container())
                          ]
                        : (widget.rightFooter != null)
                            ? [
                                Expanded(child: Container()),
                                Text(
                                  widget.rightFooter!,
                                  style: SAPTextSTyle.dataCardValueTextStyle(
                                      context),
                                ),
                              ]
                            : [
                                Text(
                                  widget.leftFooter!,
                                  style: SAPTextSTyle.dataCardValueTextStyle(
                                      context),
                                ),
                                Text(
                                  widget.rightFooter!,
                                  style: SAPTextSTyle.dataCardValueTextStyle(
                                      context),
                                )
                              ],
              ),
            )
        ],
      ),
    );
  }
}

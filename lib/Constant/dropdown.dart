import 'package:flutter/material.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/dimensions.dart';
import 'package:plc_project/Constant/textfiledstyle.dart';
import 'package:theme_provider/theme_provider.dart';

abstract class SAPDropdownButtons {
  List items;
  String hintText;
  void Function(String?) onChanged;
  String name;
  SAPDropdownButtons(
      {required this.hintText,
      required this.name,
      required this.items,
      required this.onChanged});
}

// ignore: must_be_immutable
class SAPDropdownButton extends StatefulWidget implements SAPDropdownButtons {
  @override
  List items;
  @override
  String hintText;
  @override
  String name;
  SAPDropdownButton(
      {super.key,
      required this.hintText,
      required this.name,
      required this.items,
      required this.onChanged});

  @override
  State<SAPDropdownButton> createState() => _SAPDropdownButtonState();

  @override
  void Function(String? value) onChanged;
}

class _SAPDropdownButtonState extends State<SAPDropdownButton> {
  String? val;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SAPDimensions.componentVerticalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name, style: SAPTextSTyle.textfieldHeaderStyle(context)),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: double.maxFinite,
            padding: SAPDimensions.componentHorizontalPadding,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500, width: 1.2),
                borderRadius: SAPDimensions.componentBorderRadius),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
              dropdownColor: ThemeProvider.themeOf(context)
                  .data
                  .extension<SAPTheme>()!
                  .dropdownMenuColor,
              isExpanded: true,
              borderRadius: SAPDimensions.componentBorderRadius,
              hint: Text(widget.hintText,
                  style: SAPTextSTyle.hintTextinputStyle(context)),
              value: val,
              items: widget.items
                  .map((e) => DropdownMenuItem(
                        value: e.toString(),
                        child: Text(e.toString(),
                            style: SAPTextSTyle.textfieldinputStyle(context)),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  val = value;
                });
                widget.onChanged(value);
              },
            )),
          )
        ],
      ),
    );
  }
}

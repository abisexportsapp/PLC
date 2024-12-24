// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:plc_project/Components/ListTiles.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/dimensions.dart';
import 'package:plc_project/Constant/textfiledstyle.dart';
import 'package:theme_provider/theme_provider.dart';

abstract class SAPDataCards {
  Map<String, String> dataList;
  SAPDataCards({required this.dataList});
}

class SAPDetailsCards implements SAPDataCards, SAPListTiles {
  @override
  Map<String, String> dataList;
  @override
  IconData? icon;
  @override
  bool isUnderline;
  @override
  void Function()? onTap;
  @override
  String subtitle;
  @override
  String title;
  List? inputs;
  List<Widget>? buttons;
  SAPDetailsCards(
      {required this.dataList,
      required this.buttons,
      required this.icon,
      required this.inputs,
      required this.isUnderline,
      required this.onTap,
      required this.subtitle,
      required this.title})
      : padding = SAPDimensions.componentZeroPadding;

  @override
  Widget? trailing;

  @override
  EdgeInsets? padding;

  @override
  void Function()? onIconTap;
}

class SAPDataCard extends StatelessWidget implements SAPDataCards {
  @override
  Map<String, String> dataList;
  SAPDataCard({super.key, required this.dataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeProvider.themeOf(context)
          .data
          .extension<SAPTheme>()!
          .dataCardBackgroundColor,
      child: Column(
        children: [
          for (var entry in dataList.entries)
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(entry.key.toString(),
                          style: SAPTextSTyle.dataCardKeyTextStyle(context))),
                  Expanded(
                      child: Text(
                    entry.value.toString(),
                    style: SAPTextSTyle.dataCardValueTextStyle(context),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                  ))
                ],
              ),
            )
        ],
      ),
    );
  }
}

class SAPDetailsCard extends StatefulWidget implements SAPDetailsCards {
  SAPDetailsCard(
      {super.key,
      required this.dataList,
      required this.isUnderline,
      required this.title,
      required this.subtitle,
      this.buttons,
      this.inputs,
      this.icon,
      required this.onTap,
      this.trailing})
      : padding = SAPDimensions.componentZeroPadding;
  @override
  State<SAPDetailsCard> createState() => _SAPDetailsCardState();
  @override
  Map<String, String> dataList;
  @override
  IconData? icon;
  @override
  bool isUnderline;
  @override
  void Function()? onTap;
  @override
  String subtitle;
  @override
  String title;
  @override
  List? inputs;
  @override
  List<Widget>? buttons;

  @override
  Widget? trailing;

  @override
  EdgeInsets? padding;

  @override
  void Function()? onIconTap;
}

class _SAPDetailsCardState extends State<SAPDetailsCard> {
  @override
  void initState() {
    if (widget.buttons != null) {
      for (int i = 0; i <= (widget.buttons!.length - 2); i += 2) {
        if ((i + 2) == (widget.buttons!.length - 1)) {}
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(bottom: 4),
      color: ThemeProvider.themeOf(context)
          .data
          .extension<SAPTheme>()!
          .detailsCardShadowColor,
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 0),
        color: ThemeProvider.themeOf(context)
            .data
            .extension<SAPTheme>()!
            .detailsCardBackgroundColor,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SAPListTile(
              trailing: widget.trailing,
              title: widget.title,
              subtitle: widget.subtitle,
              isUnderline: widget.isUnderline,
              onTap: widget.onTap,
              icon: widget.icon,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: SAPDataCard(dataList: widget.dataList),
            ),
            const SizedBox(
              height: 5,
            ),
            if (widget.inputs != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [...widget.inputs!.map((e) => e)],
                ),
              ),
            const SizedBox(
              height: 15,
            ),
            if (widget.buttons != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    //...widget.buttons!.map((e) => e).toList()
                    if (widget.buttons!.length == 1)
                      ...widget.buttons!.map((e) => e),
                    if (widget.buttons!.length % 2 == 0)
                      for (int i = 0; i <= (widget.buttons!.length - 1); i += 2)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              Expanded(child: widget.buttons![i]),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(child: widget.buttons![i + 1])
                            ],
                          ),
                        ),
                    if (widget.buttons!.length % 2 != 0 &&
                        widget.buttons!.length != 1)
                      for (int i = 0; i <= (widget.buttons!.length - 2); i += 2)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: widget.buttons![i]),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child: widget.buttons![i + 1])
                                ],
                              ),
                              if ((i + 2) == (widget.buttons!.length - 1))
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: widget.buttons![i + 2],
                                )
                            ],
                          ),
                        )
                  ],
                ),
              ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

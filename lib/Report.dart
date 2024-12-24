// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plc_project/BinStockReport.dart';
import 'package:plc_project/Constant/buttons.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Constant/dimensions.dart';
import 'package:plc_project/Constant/text.dart';
import 'package:theme_provider/theme_provider.dart';

class Reportpage extends StatefulWidget {
  final String selectedPlant;
  const Reportpage({super.key, required this.selectedPlant});

  @override
  State<Reportpage> createState() => _ReportpageState();
}

class _ReportpageState extends State<Reportpage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarColor: ThemeProvider.themeOf(context)
              .data
              .extension<SAPTheme>()!
              .appBarBackgroundColor),
      child: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: ThemeProvider.themeOf(context)
                  .data
                  .extension<SAPTheme>()!
                  .appBarBackgroundColor,
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      scrolledUnderElevation: 0,
                      backgroundColor: ThemeProvider.themeOf(context)
                          .data
                          .extension<SAPTheme>()!
                          .appBarBackgroundColor,
                      title: SAPText(
                        data: 'Reports',
                        size: 16,
                        weight: FontWeight.w700,
                      ),
                      snap: false,
                      pinned: true,
                      floating: false,
                      // flexibleSpace: FlexibleSpaceBar(
                      //   background: Container(
                      //     margin: const EdgeInsets.only(bottom: 10),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.end,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         SAPListTile(
                      //           isUnderline: false,
                      //           icon: Icons.person,
                      //           title: widget.employeeName,
                      //           subtitle: 'Employee Id - ${widget.employeeID}',
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 70),
                      //           child: SAPText(
                      //             data: 'Employee Role - ${widget.roleText}',
                      //             size: 12,
                      //             weight: FontWeight.w400,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // expandedHeight: 150,
                      // automaticallyImplyLeading: false,
                      // actions: <Widget>[
                      //   SAPIconButton(
                      //     icon: Icons.settings,
                      //     onPress: () {
                      //       SAPPageNavigation.next(
                      //           page: const Settings(), context: context);
                      //     },
                      //   ),
                      //   Padding(
                      //     padding: const EdgeInsets.only(right: 20),
                      //     child: SAPIconButton(
                      //       onPress: () async {
                      //         logOutAlert();
                      //       },
                      //       icon: Icons.power_settings_new_rounded,
                      //     ),
                      //   ),
                      // ],
                    ),
                  ];
                },
                body: Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                        padding: SAPDimensions.componentAllPadding,
                        crossAxisCount: 2,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                        children: [
                          // SAPCardButton.navigate(
                          //   icon: "silo",
                          //   name: "SILO Stock Report",
                          //   height: 120,
                          //   width: 120,
                          //   navigateTo: Silostockpage(
                          //     selectedPlant: '${widget.selectedPlant}',
                          //   ),
                          // ),
                          // SAPCardButton.navigate(
                          //   icon: "warehouse",
                          //   name: "Feed Godown Stock Report",
                          //   height: 120,
                          //   width: 120,
                          //   navigateTo: Feedgodownpage(
                          //     selectedPlant: '${widget.selectedPlant}',
                          //   ),
                          // ),
                          SAPCardButton.navigate(
                              icon: "twosilos",
                              name: "Bin Stock Report",
                              height: 120,
                              width: 120,
                              navigateTo: Binstockreport(
                                selectedPlant: widget.selectedPlant,
                              )),
                          // SAPCardButton.navigate(
                          //   icon: "dayEntry",
                          //   name: "Day Report",
                          //   height: 120,
                          //   width: 120,
                          //   navigateTo: Silostockpage(),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

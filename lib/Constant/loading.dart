// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:theme_provider/theme_provider.dart';

class SAPLoadingIndicator extends StatelessWidget {
  double height = 60;
  double width = 60;
  SAPLoadingIndicator({super.key});
  SAPLoadingIndicator.button({super.key, this.height = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SizedBox(
            height: height,
            width: width,
            child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [
                  ThemeProvider.themeOf(context)
                      .data
                      .extension<SAPTheme>()!
                      .loadingIndicatorColor
                      .withOpacity(0.2),
                  ThemeProvider.themeOf(context)
                      .data
                      .extension<SAPTheme>()!
                      .loadingIndicatorColor
                      .withOpacity(0.5),
                  ThemeProvider.themeOf(context)
                      .data
                      .extension<SAPTheme>()!
                      .loadingIndicatorColor
                ],
                strokeWidth: 3,
                backgroundColor: Colors.transparent,
                pathBackgroundColor: Colors.black)),
      ),
    );
  }
}

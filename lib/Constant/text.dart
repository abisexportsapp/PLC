import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:theme_provider/theme_provider.dart';

class SAPText extends StatelessWidget {
  final double? size;
  final String data;
  final int? maxLines;
  final TextAlign? textAlign;
  final Color? color;
  final FontWeight? weight;

  const SAPText({
    super.key,
    required this.data,
    this.size,
    this.textAlign,
    this.color,
    this.weight,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      maxLines: maxLines,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        fontSize: size,
        color: color ??
            ThemeProvider.themeOf(context)
                .data
                .extension<SAPTheme>()!
                .globalTextColor,
        fontWeight: weight,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:plc_project/Constant/colors.dart';
import 'package:plc_project/Login.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  runApp(
    ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: [
        AppTheme(
            id: 'saplighttheme',
            data: sapLightThemeColors,
            description: 'SAP Light theme'),
        AppTheme(
            id: 'sapdarktheme',
            data: sapDarkThemeColors,
            description: 'SAP Dark theme'),
        AppTheme(
            id: 'sapibtheme',
            data: sapIbThemeColors,
            description: 'SAP IB Group theme'),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeProvider.themeOf(context).data,
      home: const LoginScreen(),
    );
  }
}

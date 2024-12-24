// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:plc_project/Homepage.dart';

// This class is for navigating between Pages .

class SAPPageNavigation {
  SAPPageNavigation.next(
      {required Widget page, required BuildContext context}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }

  SAPPageNavigation.back({required BuildContext context}) {
    Navigator.pop(context);
  }
  SAPPageNavigation.toHomePage({required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomepageScreen(
            employeeName: '',
            roleText: '',
            employeeID: '',
            department: '',
          ),
        ),
        (route) => false);
  }
}

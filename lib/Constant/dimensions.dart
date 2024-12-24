// ignore_for_file: file_names

//This file contains all the Dimensions like border radius , padding , margin  which is required for application UI Part .

import 'package:flutter/material.dart';

class SAPDimensions {
  static final BorderRadius checkBoxBorderRadius =
      BorderRadius.circular(5); // for Checkbox border radius
  static final BorderRadius componentBorderRadius =
      BorderRadius.circular(10); // Border Radius for all the UI Components .
  static final BorderRadius alertBoxBorderRadius = BorderRadius.circular(15);
  static const EdgeInsets componentHorizontalPadding = EdgeInsets.symmetric(
      horizontal: 15); // Horizontal Padding for all the UI Components .
  static const EdgeInsets componentVerticalPadding = EdgeInsets.symmetric(
      vertical: 15); // Vertical padding for all the UI Components .
  static const EdgeInsets componentTopPadding =
      EdgeInsets.only(top: 15); // Top padding for all the UI Components .
  static const EdgeInsets componentLeftPadding =
      EdgeInsets.only(left: 15); // left padding for all the UI Components .
  static const EdgeInsets componentRightPadding =
      EdgeInsets.only(right: 15); // Right padding for all the UI Components .
  static const EdgeInsets componentBottomPadding =
      EdgeInsets.only(bottom: 15); // Bottom padding for all the UI Components .
  static const EdgeInsets componentAllPadding =
      EdgeInsets.all(15); // All Side padding for all the UI Components .
  static const EdgeInsets componentZeroPadding =
      EdgeInsets.all(0); // All Side zero padding for all the UI Components .
  static const EdgeInsets contentPadding = EdgeInsets.only(
      top: 5, left: 15, right: 15); // Content padding for all Text fields .
  static const double textFieldHeaderSize = 14; // for textfield header size
  static const double textFieldinputSize = 13; // for textfield input size
  static const double iconSize = 22; // for icon Size
}

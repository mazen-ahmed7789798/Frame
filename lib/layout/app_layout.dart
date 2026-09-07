import "package:flutter/material.dart";

class AppLayout {
  static const double compactWidth = 700;
  static const double contentMaxWidth = 1100;

  static bool isCompact(BuildContext context) {
    return MediaQuery.sizeOf(context).width < compactWidth;
  }

  static double pagePadding(BuildContext context) {
    return isCompact(context) ? 16 : 24;
  }
}

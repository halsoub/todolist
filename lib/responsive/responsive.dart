import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  Responsive({required this.mobile, required this.tablet, required this.desktop, super.key});

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 600;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width < 950;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // double width = 0;

    MediaQueryData mediaQueryData = MediaQueryData();
    Orientation orientation = mediaQueryData.orientation;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (orientation == Orientation.landscape) {
          width = mediaQueryData.size.height;
        } else {
          width = mediaQueryData.size.width;
        }
        if (width >= 950) {
          return desktop;
        }
        if (width >= 600) {
          return tablet;
        }
        return mobile;
      },
    );
  }
}

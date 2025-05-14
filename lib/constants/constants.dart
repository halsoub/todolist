import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/theme.dart';

Color blue = Color.fromRGBO(26, 115, 233, 1);
Color black = Color.fromRGBO(58, 58, 58, 1);
Color gray = Color.fromRGBO(98, 98, 98, 1);
Color background = Color.fromRGBO(252, 247, 247, 1);
Color lightGray = Color.fromRGBO(130, 130, 130, 1);
SizedBox spacex = SizedBox(height: 16);
double fontxl = 30;
double fontlg = 25;
double fontmd = 18;
double fontsm = 15;
double fontxs = 12;
double getHieght(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getWidth(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  return width;
}

elevatedButtonStyler(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);
}

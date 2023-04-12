import 'package:flutter/material.dart';
import 'package:huo_la_la/utils/theme.dart';

class CargoTitle {
  final double fontSize = 10;
  final double height = 17;
  final double width = 17;
  final Color? backgroundColor;
  final String text;
  const CargoTitle(this.text, {this.backgroundColor = HomePageTheme.headerBackgroundColor});

  Widget build(BuildContext context, int index) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(52))),
      child: Align(
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: fontSize)),
      ),
    );
  }
}

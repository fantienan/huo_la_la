import 'package:flutter/material.dart';
import 'package:huo_la_la/pages/home/const.dart';
import 'package:huo_la_la/utils/theme.dart';

const double _fontSize = 10;
const double _defaultWidth = 42;
const double _defaultTextContainerHeight = 18;
const double _defaultTextContainerWidth = 18;

class CargoTitle extends StatelessWidget {
  const CargoTitle(
    this.text, {
    super.key,
    this.backgroundColor = CargoTheme.defaultTitleBackgroundColor,
    this.onSwapTap,
    this.index = 0,
    this.status = CargoItemStatus.normal,
  });

  static const double fontSize = _fontSize;
  static const double height = cargoItemHeight;
  static const double width = _defaultWidth;
  static const double textContaienrHeight = _defaultTextContainerHeight;
  static const double textContaienrWidth = _defaultTextContainerWidth;
  final Color? backgroundColor;
  final String text;
  final CargoTitleSwapCallback? onSwapTap;
  final int index;
  final CargoItemStatus status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Container(
            width: textContaienrWidth,
            height: textContaienrHeight,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(textContaienrHeight / 2)),
            ),
            child: GestureDetector(
              onTap: () => onSwapTap is Function ? onSwapTap!(index) : null,
              child: Align(
                alignment: Alignment.center,
                child: Text(text, style: const TextStyle(color: CargoTheme.titleTextColor, fontSize: fontSize)),
              ),
            ),
          ),
        ));
  }
}

class CargoTitleSettings {
  CargoTitleSettings(
    this.text, {
    this.backgroundColor = Colors.red,
    // this.backgroundColor = CargoTheme.defaultTitleBackgroundColor,
    this.status = CargoItemStatus.normal,
  });

  final Color? backgroundColor;
  final String text;
  CargoItemStatus status;
}

typedef CargoTitleSwapCallback = void Function(int index);

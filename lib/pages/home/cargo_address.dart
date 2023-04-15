import 'package:flutter/material.dart';
import 'package:huo_la_la/pages/home/const.dart';
import 'package:huo_la_la/utils/theme.dart';

const double _borderRadius = 11;
const double _paddingLeft = 10;
const double _fontSize = 18;
const double _buttonIconSize = 16;
const double _defaultWidth = 100;

class CargoAddress extends StatelessWidget {
  CargoAddress({
    super.key,
    this.placeholder = '输入卸货地',
    this.placeholderColor = CargoTheme.defaultPlaceholderColor,
    this.handleType,
    this.height = defaultHeight,
    this.width = defaultWidth,
    this.onHandleTap,
    this.index = 0,
    this.status = CargoAddressStatus.normal,
  });

  static const double borderRadius = _borderRadius;
  static const double paddingLeft = _paddingLeft;
  static const double fontSize = _fontSize;
  static const double buttonIconSize = _buttonIconSize;
  static const double defaultHeight = cargoItemHeight;
  static const double defaultWidth = _defaultWidth;
  final double height;
  final double width;
  final String placeholder;
  final Color placeholderColor;
  final CargoAddressHandle? handleType;
  final CargoAddressHandleCallback? onHandleTap;
  final int index;
  CargoAddressStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.only(left: paddingLeft),
      decoration: const BoxDecoration(
        color: CargoTheme.inputBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: Row(children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            // placeholder,
            index.toString(),
            style: TextStyle(color: placeholderColor, fontSize: fontSize, fontWeight: FontWeight.w500),
          ),
        )),
        if (handleType != null)
          SizedBox(
            width: 60,
            child: GestureDetector(
              onTap: () => onHandleTap is Function ? onHandleTap!(handleType!, index) : null,
              // onTap: f,
              child: handleType == CargoAddressHandle.add
                  ? Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
                      Icon(Icons.add_circle, size: buttonIconSize, color: CargoTheme.buttonBackgroundColor),
                      Text("加途径点", style: TextStyle(color: CargoTheme.buttonTextColor, fontSize: 10))
                    ])
                  : const Icon(Icons.do_not_disturb_on, size: buttonIconSize, color: CargoTheme.buttonBackgroundColor),
            ),
          )
      ]),
    );
  }
}

class CargoAddressSettings {
  CargoAddressSettings({
    this.placeholder = '输入卸货地',
    this.placeholderColor = CargoTheme.defaultPlaceholderColor,
    this.handleType,
    this.height = cargoItemHeight,
    this.width = _defaultWidth,
    this.status = CargoAddressStatus.normal,
  });

  final double height;
  final double width;
  final String placeholder;
  final Color placeholderColor;
  final CargoAddressHandle? handleType;
  CargoAddressStatus status;
}

enum CargoAddressHandle { add, minus }

enum CargoAddressStatus { normal, theNew, removed }

typedef CargoAddressHandleCallback = void Function(CargoAddressHandle handleType, int index);

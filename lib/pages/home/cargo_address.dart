import 'package:flutter/material.dart';

class CargoAddress {
  static const double borderRadius = 11;
  static const double paddingLeft = 10;
  static const double marginLeft = 10;
  static const double fontSize = 18;
  final double height;
  final String placeholder;
  final Color placeholderColor;
  final CargoAddressHandle? handleType;

  const CargoAddress({
    this.placeholder = '输入卸货地',
    this.placeholderColor = const Color(0xFFB5B6B8),
    this.handleType,
    this.height = 47,
  });

  Widget build(int index) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(left: marginLeft),
      padding: const EdgeInsets.only(left: paddingLeft),
      decoration: const BoxDecoration(
        color: Color(0xFFF4F5F7),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: Row(children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            placeholder,
            style: TextStyle(color: placeholderColor, fontSize: fontSize, fontWeight: FontWeight.w500),
          ),
        )),
        if (handleType != null)
          handleType == CargoAddressHandle.add
              ? Column(children: const [Icon(Icons.add_circle), Text("加途径点")])
              : const Icon(Icons.do_not_disturb_on)
      ]),
    );
  }
}

enum CargoAddressHandle { add, minus }

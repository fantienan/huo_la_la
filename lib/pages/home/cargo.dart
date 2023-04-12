import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:huo_la_la/components/fiche.dart';
import 'package:huo_la_la/pages/home/cargo_address.dart';
import 'package:huo_la_la/pages/home/cargo_title.dart';

class Cargo extends StatefulWidget {
  const Cargo({super.key});

  @override
  State<Cargo> createState() => _CargoState();
}

class _CargoState extends State<Cargo> {
  static const double serviceDescriptionMarginTop = 20;
  static const double serviceDescriptionPadding = 20;
  static const double serviceDescriptionTitleFontSize = 16;
  static const double serviceDescriptionTitlePaddingBottom = 8;
  static const double cargoHeight = 47;
  static const double cargoSpace = 9;
  static const double cargoMargin = 12;
  static final onePx = 1 / MediaQueryData.fromWindow(window).devicePixelRatio;

  final List<CargoTitle> cargoTitleList = [
    const CargoTitle('装', backgroundColor: Colors.black),
    const CargoTitle('经'),
    const CargoTitle('经'),
    const CargoTitle('卸'),
  ];

  final List<CargoAddress> cargoAddressList = [
    const CargoAddress(placeholder: '输入装货地估价', placeholderColor: Colors.black),
    const CargoAddress(placeholder: '输入途径点', handleType: CargoAddressHandle.minus),
    const CargoAddress(placeholder: '输入途径点', handleType: CargoAddressHandle.minus),
    const CargoAddress(handleType: CargoAddressHandle.add),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Fiche(child: Column(children: [_buildCargo(context), _buildServiceDescription()]));
  }

  Widget _buildCargo(BuildContext context) {
    return Stack(children: [
      ...List.generate(cargoAddressList.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          margin: EdgeInsets.only(top: index * (cargoHeight + cargoSpace), left: cargoMargin, right: cargoMargin),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [cargoTitleList[index].build(context, index), Expanded(child: cargoAddressList[index].build(index))],
          ),
        );
      }),
      ...List.generate(cargoAddressList.length - 1, (index) {
        return Positioned(
          top: index * (cargoHeight + 9) + cargoHeight - 6,
          left: cargoMargin - 1.5,
          width: 20,
          height: 20,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: onePx, color: const Color(0xFFE8E8E8)),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: const Icon(Icons.swap_vert, size: 16),
          ),
        );
      })
    ]);
  }

  Widget _buildServiceDescription() {
    return Container(
      margin: const EdgeInsets.only(top: serviceDescriptionMarginTop),
      padding: const EdgeInsets.symmetric(vertical: serviceDescriptionPadding),
      color: const Color(0xFFFFFCE9),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Padding(
          padding: EdgeInsets.only(bottom: serviceDescriptionTitlePaddingBottom),
          child: Text(
            "最快1秒接单 1分钟到达",
            style: TextStyle(fontSize: serviceDescriptionTitleFontSize, fontWeight: FontWeight.w600),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: const [Text("7x24小时"), Text("搬运、回单"), Text("免费开票")]),
      ]),
    );
  }
}

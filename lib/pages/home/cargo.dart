import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:huo_la_la/components/fiche.dart';
import 'package:huo_la_la/pages/home/cargo_address.dart';
import 'package:huo_la_la/pages/home/cargo_title.dart';
import 'package:huo_la_la/pages/home/const.dart';
import 'package:huo_la_la/utils/util.dart';

import '../../utils/theme.dart';

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
  static const double height = cargoItemHeight + cargoItemSpace;
  static final onePx = 1 / MediaQueryData.fromWindow(window).devicePixelRatio;

  final List<CargoTitleSettings> cargoTitleSettings = [
    CargoTitleSettings('装', backgroundColor: CargoTheme.titleBackgroundColor1),
    CargoTitleSettings('经'),
    CargoTitleSettings('卸', backgroundColor: CargoTheme.titleBackgroundColor2),
  ];

  final List<CargoAddressSettings> cargoAddressSettings = [
    CargoAddressSettings(placeholder: '输入装货地估价', placeholderColor: Colors.black),
    CargoAddressSettings(placeholder: '输入途径点', handleType: CargoAddressHandle.minus),
    CargoAddressSettings(handleType: CargoAddressHandle.add),
  ];

  int get cargoLength => cargoAddressSettings.length;

  static final List<List<double>> a = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Fiche(child: Column(children: [_buildCargo(), _buildServiceDescription()]));
  }

  @override
  void didUpdateWidget(covariant Cargo oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget _buildCargo() {
    final List<Widget> titleWidgets = [];
    final List<Widget> addressWidgets = [];
    final List<Widget> btnWidgets = [];
    final isAddHandle = cargoAddressSettings.last.status == CargoItemStatus.theNew;
    var prevItemIsRemoved = false;
    a.add([]);
    for (var index = 0; index < cargoTitleSettings.length; index += 1) {
      final cargoAddressSetting = cargoAddressSettings[index];
      final cargoTitleSetting = cargoTitleSettings[index];
      final isLast = index == cargoLength - 1;
      final flag = cargoLength > 2 && isLast && !isAddHandle;
      final isRemovedItem = cargoAddressSetting.status == CargoItemStatus.removed;
      Duration duration = isAddHandle && isLast || prevItemIsRemoved ? cargoItemAnimationDuration : Duration.zero;
      double top = flag ? (index - 1) * height : index * height;
      double opacity = 1;
      if (isRemovedItem || (index == cargoLength - 2 && !isAddHandle)) {
        opacity = 0;
      }
      if (prevItemIsRemoved) {
        top -= height;
      }

      if (isRemovedItem) {
        prevItemIsRemoved = true;
      }
      print('a.a.a.a---$index---$duration');
      a.last.add(top);
      final cargoTitle = CargoTitle(
        cargoTitleSetting.text,
        index: index,
        backgroundColor: cargoTitleSetting.backgroundColor,
        onSwapTap: onCargoTitleSwapTap,
      );
      final cargoAddress = CargoAddress(
        index: index,
        height: cargoAddressSetting.height,
        placeholder: cargoAddressSetting.placeholder,
        placeholderColor: cargoAddressSetting.placeholderColor,
        handleType: cargoAddressSetting.handleType,
        onHandleTap: onCargoAddressHandleTap,
      );
      titleWidgets.add(
        AnimatedPositioned(
          duration: duration,
          top: top,
          child: AnimatedOpacity(opacity: opacity, duration: cargoItemAnimationDuration, child: cargoTitle),
        ),
      );
      addressWidgets.add(
        AnimatedPositionedDirectional(
            duration: duration,
            top: top,
            end: cargoItemSpace,
            start: CargoTitle.width,
            child: AnimatedOpacity(
              opacity: opacity,
              duration: cargoItemAnimationDuration,
              child: cargoAddress,
              onEnd: () => onAnimatedOpacityEnd(index, cargoAddressSetting),
            ),
            onEnd: () => onAnimatedPositionedEnd(index, cargoAddressSetting)),
      );
      btnWidgets.add(
        Positioned(
          top: top - height / 2,
          child: SizedBox(
            width: CargoTitle.width,
            height: cargoItemHeight,
            child: Center(
                child: Opacity(
              opacity: opacity,
              child: Container(
                width: CargoTitle.textContaienrWidth + 2,
                height: CargoTitle.textContaienrHeight + 2,
                decoration: BoxDecoration(
                  border: Border.all(width: onePx, color: CargoTheme.titleButtonBorderColor),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: const Icon(Icons.swap_vert, size: 16),
              ),
            )),
          ),
        ),
      );
    }

    print("a.a.a.a---$a,${cargoAddressSettings.length}");
    var h = cargoLength * height - cargoItemSpace;
    return AnimatedContainer(
      duration: cargoItemAnimationDuration,
      height: !isAddHandle ? h - height : h,
      child: Stack(children: [...titleWidgets, ...addressWidgets, ...btnWidgets].toList()),
    );
  }

  Widget _buildServiceDescription() {
    return Container(
      margin: const EdgeInsets.only(top: serviceDescriptionMarginTop),
      padding: const EdgeInsets.symmetric(vertical: serviceDescriptionPadding),
      decoration: const BoxDecoration(
        color: CargoTheme.serviceDescriptionbackgroundColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      ),
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

  void onCargoAddressHandleTap(CargoAddressHandle handleType, int index) {
    try {
      setState(() {
        if (handleType == CargoAddressHandle.add) {
          cargoAddressSettings[index].status = CargoItemStatus.theNew;
          cargoTitleSettings[index].status = CargoItemStatus.theNew;
        } else {
          cargoAddressSettings[index].status = CargoItemStatus.removed;
          cargoTitleSettings[index].status = CargoItemStatus.removed;
        }
      });
    } catch (e) {
      printDebug(e);
    }
  }

  void onCargoTitleSwapTap(int index) {}
  void onAnimatedPositionedEnd(int index, CargoAddressSettings cargoAddressSetting) {
    if (cargoAddressSetting.status == CargoItemStatus.theNew) {
      if (index == cargoLength - 1) {
        setState(() {
          cargoAddressSettings[index].status = CargoItemStatus.normal;
          cargoAddressSettings.insert(
            index,
            CargoAddressSettings(placeholder: '输入途径点', handleType: CargoAddressHandle.minus),
          );
          cargoTitleSettings.insert(index, CargoTitleSettings('经'));
        });
      }
    }
  }

  void onAnimatedOpacityEnd(int index, CargoAddressSettings cargoAddressSetting) {
    if (cargoAddressSetting.status == CargoItemStatus.removed) {
      setState(() {
        cargoTitleSettings.removeAt(index);
        cargoAddressSettings.removeAt(index);
      });
    }
  }
}

enum CargoItemTypes { title, address }

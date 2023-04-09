import 'package:flutter/material.dart';
import 'package:huo_la_la/utils/theme.dart';

class CargoAddress extends StatefulWidget {
  const CargoAddress({super.key});

  @override
  State<CargoAddress> createState() => _CargoAddressState();
}

class _CargoAddressState extends State<CargoAddress> {
  static const double marginHorizontal = 12;
  static const double padding = 12;
  static const double borderRadius = 12;
  static const double addressBorderRadius = 11;
  static const double addressTextHeight = 47;
  static const double cargoTextHeight = 17;
  static const double cargoTextWidth = 17;
  static const double cargoTextFontSize = 10;
  static const double inputCargoAddressPaddingLeft = 10;
  static const double inputCargoAddressFontSize = 18;
  static const double inputCargoAddressSpace = 9;
  static const double serviceDescriptionMarginTop = 20;
  static const double serviceDescriptionPadding = 20;
  static const double serviceDescriptionTitleFontSize = 16;
  static const double serviceDescriptionTitlePaddingBottom = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: marginHorizontal),
      padding: const EdgeInsets.only(top: padding, left: padding, right: padding),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: [BoxShadow(blurRadius: 10, color: Color(0xFFC5C6C7))]),
      child: Column(children: [
        _cargoAddress('装', placeholder: "输入装货地估"),
        const SizedBox(height: inputCargoAddressSpace),
        _cargoAddress(
          '卸',
          showExchangeIcon: true,
          showAddAddress: true,
          showMinusAddress: true,
          placeholder: "请输入卸货地",
          placeholderColor: const Color(0xFFB7B8BA),
          bgColor: HomePageTheme.headerBackgroundColor,
        ),
        Container(
          margin: const EdgeInsets.only(top: serviceDescriptionMarginTop),
          padding: const EdgeInsets.symmetric(vertical: serviceDescriptionPadding),
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
        )
      ]),
    );
  }

  Widget _cargoAddress(
    String text, {
    String placeholder = '',
    Color? color = Colors.white,
    Color? bgColor = Colors.black,
    Color? placeholderColor = Colors.black,
    bool? showExchangeIcon,
    bool? showAddAddress,
    bool? showMinusAddress,
  }) {
    Widget textWidget = Align(
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(color: color, fontSize: cargoTextFontSize)),
    );
    return Row(
      children: [
        Container(
          width: cargoTextWidth,
          height: cargoTextHeight,
          decoration: BoxDecoration(color: bgColor, borderRadius: const BorderRadius.all(Radius.circular(52))),
          child: showExchangeIcon != null
              ? Stack(
                  children: [Positioned(child: Icon(Icons.access_alarm), top: -10), textWidget],
                )
              : textWidget,
        ),
        Expanded(
          child: Container(
            height: addressTextHeight,
            width: double.infinity,
            margin: const EdgeInsets.only(left: inputCargoAddressPaddingLeft),
            padding: const EdgeInsets.only(left: inputCargoAddressPaddingLeft),
            decoration: const BoxDecoration(
              color: Color(0xFFF4F5F7),
              borderRadius: BorderRadius.all(Radius.circular(addressBorderRadius)),
            ),
            child: Row(children: [
              Text(
                placeholder,
                style: TextStyle(color: placeholderColor, fontSize: inputCargoAddressFontSize, fontWeight: FontWeight.w500),
              ),
              if (showAddAddress != null) Text("+"),
              if (showMinusAddress != null) Text("-")
            ]),
          ),
        )
      ],
    );
  }
}

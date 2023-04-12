import 'package:flutter/material.dart';

class Fiche extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final Widget child;
  const Fiche({
    super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: 12),
    this.padding = const EdgeInsets.only(top: 12),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.child = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: const [BoxShadow(blurRadius: 10, color: Color(0xFFC5C6C7))],
      ),
      child: child,
    );
  }
}

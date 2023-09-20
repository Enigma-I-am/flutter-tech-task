import 'package:flutter/material.dart';

class CustomBorder extends StatelessWidget {
  const CustomBorder({
    super.key,
    required this.child,
    // this.onTap,
    this.borderColor = const Color(0xFFEFE9E7),
    this.backgroundColor,
    this.padding = const EdgeInsets.all(16.0),
    this.radius = 8,
  });
  final Widget child;
  // final void Function()? onTap;
  final Color borderColor;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

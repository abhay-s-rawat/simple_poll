import 'package:flutter/material.dart';

class CustomLinearProgressBar extends StatelessWidget {
  final double value;
  final Color? color;
  final double height;
  const CustomLinearProgressBar({
    Key? key,
    this.value = 0,
    this.color,
    this.height = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: color ?? Colors.grey[100],
            ),
            height: height,
            width: constraint.maxWidth * value,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.white,
            ),
            height: 35,
            width: constraint.maxWidth * (1 - value),
          ),
        ],
      );
    });
  }
}

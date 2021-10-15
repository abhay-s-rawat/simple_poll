/// This file contains a custom linear progress indicator.
import 'package:flutter/material.dart';

class CustomLinearProgressBar extends StatelessWidget {
  /// This class will return a widget that will show the percentage of polls of each options in bar representation.
  final double value;
  final Color? progressColor;
  final Color? remainingColor;
  final double height;
  const CustomLinearProgressBar({
    Key? key,
    this.value = 0,
    this.progressColor,
    this.height = 35,
    this.remainingColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(3),
                bottomLeft: Radius.circular(3),
              ),

              /// If [color] of bar is null default color will be applied.
              color: this.progressColor ?? Colors.grey[100],
            ),
            height: height,

            /// constraint.maxWidth * value will return the width that shows the bar.
            /// For Example : on a 400px available space and value = 0.25, bar will take 25% of the 400px available.
            width: constraint.maxWidth * value,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(3),
                  bottomRight: Radius.circular(3)),
              color: this.remainingColor ?? Colors.white,
            ),
            height: 35,

            /// constraint.maxWidth * (1 - value) will fill the remanining space with white background container.
            /// For Example : on a 400px available space and value = 0.25, bar will take 75% of the 400px available.
            width: constraint.maxWidth * (1 - value),
          ),
        ],
      );
    });
  }
}

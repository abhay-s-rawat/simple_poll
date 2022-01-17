/// This file contains the results widget.
import 'package:flutter/material.dart';
import '../models/poll_models.dart';
import 'progress_widget.dart';

class PollResultsWidget extends StatelessWidget {
  /// This widget will show the results of poll.
  final double percentage;
  final PollOptions optionModel;
  final TextStyle? optionsStyle;
  final Color? progressColor;
  final Color? remainingColor;

  const PollResultsWidget({
    Key? key,
    required this.percentage,
    required this.optionModel,
    this.optionsStyle,
    this.progressColor,
    this.remainingColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      dense: true,
      title: Stack(
        alignment: Alignment.centerLeft,
        children: [

          /// CustomLinearProgressBar is a widget that works like a progress bar but will be static.
          CustomLinearProgressBar(
            value: percentage,
            progressColor: this.progressColor,
            remainingColor: this.remainingColor,
          ),

          /// This will create the label of the option in results screen.
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    optionModel.label,
                    overflow: TextOverflow.ellipsis,
                    style: optionsStyle ??
                        TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),

              /// If [optionModel.isSelected] is true a circle with tick will appear after that label,which indicates the selected of that particular option.
              if (optionModel.isSelected == true)
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 18,
                  ),
                ),
            ],
          ),
        ],
      ),

      /// Trailing portion will show the percentage of polls for each option.
      trailing: Text(
        double.parse((percentage * 100).toStringAsFixed(1)).toString() + '%',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

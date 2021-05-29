/// This file contains the actual option widget used.
import 'package:flutter/material.dart';
import '../models/poll_models.dart';

class PollButtonsWidget extends StatelessWidget {
  /// This class does not have state that's why created as stateless.
  final PollOptions optionModel;
  final TextStyle? optionsStyle;
  final Function onPressed;
  const PollButtonsWidget({
    Key? key,
    required this.optionModel,
    required this.onPressed,
    this.optionsStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        /// Calls the passed callback to capture response.
        onPressed();
      },
      child: Text(
        optionModel.label,
        overflow: TextOverflow.ellipsis,
      ),
      style: OutlinedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        shape: StadiumBorder(),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.5,
        ),

        /// Custom theme will be applied here.
        /// First it checks the passed parameter , if [optionsStyle] is null the default theme will be applied.
        textStyle: optionsStyle ??
            TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }
}

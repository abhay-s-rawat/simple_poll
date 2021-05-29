import 'dart:async';
import 'package:flutter/material.dart';
import 'poll_buttons.dart';
import '../models/poll_models.dart';
import 'poll_results.dart';
import 'poll_status.dart';

/// This is the main poll widget file
class SimplePollsWidget extends StatefulWidget {
  final PollFrameModel model;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Decoration? decoration;
  final Function? onSelection;
  final String languageCode;
  final TextStyle? optionsStyle;
  SimplePollsWidget({
    required this.model,
    this.margin,
    this.padding,
    this.decoration,
    this.onSelection,
    this.languageCode = 'en',
    this.optionsStyle,
  });

  @override
  _SimplePollsWidgetState createState() => _SimplePollsWidgetState();
}

class _SimplePollsWidgetState extends State<SimplePollsWidget> {
  Timer? refreshTimer;
  @override
  void initState() {
    super.initState();

    /// This will refresh the widget when the poll time expires, this timer will get cancel on dispose.
    if (widget.model.endTime!.toUtc().isAfter(DateTime.now().toUtc())) {
      refreshTimer =
          Timer(widget.model.endTime!.difference(DateTime.now().toUtc()), () {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    /// Check if the timer function is not null and cancel on dispose.
    if (refreshTimer != null) {
      refreshTimer!.cancel();
    }
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.symmetric(horizontal: 8),
      padding: widget.padding ?? EdgeInsets.fromLTRB(15, 15, 15, 5),
      decoration: widget.decoration ??
          BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
            color: Colors.white,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.model.title,
          SizedBox(height: 10),

          /// This list will generate all the necessary poll options.
          ...List.generate(
            widget.model.options.length,
            (index) {
              double percentage = widget.model.totalPolls == 0
                  ? 0
                  : widget.model.options[index].pollsCount /
                      widget.model.totalPolls;

              /// Check if the person has voted or poll has expired, if true the results screen will show up.
              if ((widget.model.hasVoted == true) ||
                  widget.model.endTime!
                      .toUtc()
                      .isBefore(DateTime.now().toUtc())) {
                return PollResultsWidget(
                  percentage: percentage,
                  optionModel: widget.model.options[index],
                  optionsStyle: widget.optionsStyle,
                );
              } else {
                /// If check fails the buttons will appear.
                return PollButtonsWidget(
                    optionModel: widget.model.options[index],
                    optionsStyle: widget.optionsStyle,
                    onPressed: () {
                      /// Check if poll is still active, if active update the widget with user's response.
                      if (widget.model.endTime!
                          .toUtc()
                          .isAfter(DateTime.now().toUtc())) {
                        setState(() {
                          widget.model.hasVoted = true;
                          widget.model.options[index].isSelected = true;
                          widget.model.totalPolls += 1;
                          widget.model.options[index].pollsCount += 1;
                          if (widget.onSelection != null) {
                            widget.onSelection!(widget.model);
                          }
                        });
                      } else {
                        /// If poll expired show a snackbar and update the widget.
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Polling time expired.'),
                          backgroundColor: Theme.of(context).primaryColor,
                        ));
                        setState(() {});
                      }
                    });
              }
            },
          ),
          SizedBox(height: 5),

          /// Following widget will show the status of total polls and poll timer, it has a undo button which will show up if poll is editable.
          PollStatusWidget(
            model: widget.model,
            languageCode: widget.languageCode,
            onUndo: () {
              setState(() {
                widget.model.hasVoted = false;
                widget.model.totalPolls = widget.model.totalPolls - 1;
                for (var item in widget.model.options) {
                  if (item.isSelected == true) {
                    item.isSelected = false;
                    item.pollsCount -= 1;
                  }
                }
                if (widget.onSelection != null) {
                  widget.onSelection!(widget.model);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

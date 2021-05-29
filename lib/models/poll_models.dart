import 'package:flutter/material.dart';

/// PollFrameModel model is the main data model to be passed to polls widget.
class PollFrameModel {
  int totalPolls;
  final Widget title;
  final List<PollOptions> options;
  final DateTime? endTime;
  bool hasVoted;
  final bool editablePoll;

  PollFrameModel({
    required this.totalPolls,
    required this.options,
    this.hasVoted = false,
    required this.title,
    this.endTime,
    this.editablePoll = false,
  });
}

/// PollOptions model will have properties to configure options of the poll.
class PollOptions {
  final String label;
  final dynamic id;
  int pollsCount;
  bool isSelected;

  PollOptions({
    required this.label,
    required this.pollsCount,
    required this.id,
    this.isSelected = false,
  });
}

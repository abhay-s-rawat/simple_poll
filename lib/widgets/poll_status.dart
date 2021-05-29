import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/poll_models.dart';
import '../translations/translations.dart';

/// This widget will show status of the polls. eg: showing total polls and time remaining.
class PollStatusWidget extends StatelessWidget {
  final PollFrameModel model;
  final String languageCode;
  final Function onUndo;
  const PollStatusWidget({
    Key? key,
    required this.model,
    required this.languageCode,
    required this.onUndo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// This portion will register these languages for timeago/timefromnow translation.
    timeago.setLocaleMessages('it', timeago.ItMessages());
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    timeago.setLocaleMessages('es', timeago.EsMessages());
    timeago.setLocaleMessages('gr', timeago.GrMessages());
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            model.totalPolls.toString() +
                ' ${polls_translation[languageCode]!}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
        Text(
          ' • ',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            model.endTime!.isBefore(DateTime.now().toUtc())
                ? polling_ended_translation[languageCode]!
                : '${ends_translation[languageCode]!}: ' +
                    timeago.format(
                      model.endTime!,
                      allowFromNow: true,
                      locale: languageCode,
                    ),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
        if ((model.editablePoll == true) && (model.hasVoted == true)) ...[
          Text(
            ' • ',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Flexible(
            flex: 1,
            child: GestureDetector(
              child: Text(
                undo_poll_translation[languageCode]!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 13,
                ),
              ),
              onTap: () {
                onUndo();
              },
            ),
          ),
        ]
      ],
    );
  }
}

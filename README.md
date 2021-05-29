# simple_polls

A simple polls widget is simple widget with language localizations.

## Example
for full example please view example/main.dart
```dart
SimplePollsWidget(
          model: PollFrameModel(
            title: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'This is the title of poll. This is the title of poll. This is the title of poll.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            totalPolls: 100,
            endTime: DateTime.now().toUtc().add(Duration(days: 10)),
            hasVoted: false,
            editablePoll: true,
            options: <PollOptions>[
              PollOptions(
                label: "Option 1",
                pollsCount: 40,
                isSelected: false,
                id: 1,
              ),
              PollOptions(
                label: "Option 2",
                pollsCount: 25,
                isSelected: false,
                id: 2,
              ),
              PollOptions(
                label: "Option 3",
                pollsCount: 35,
                isSelected: false,
                id: 3,
              ),
            ],
          ),
        )
```
## Screenshots
![en_options](images/en_options.jpg){width=100} ![en_results](images/en_results.jpg) ![it_options](images/it_options.jpg) ![it_results](images/it_results.jpg)

>Allowed language codes are it,fr,es,gr,en where en is default.

>This widget does not translate title and options, they should be translated by user.

> Liked the work ? [support me](https://www.buymeacoffee.com/abhayrawat)

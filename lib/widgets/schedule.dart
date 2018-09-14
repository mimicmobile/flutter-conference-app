import 'package:androidto/data/conference_data.dart';
import 'package:androidto/data/list_items.dart';
import 'package:flutter/material.dart';

class ScheduleWidget extends StatefulWidget {
  final ConferenceData conferenceData;
  const ScheduleWidget({Key key, @required this.conferenceData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScheduleWidgetState();
}

class ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: !widget.conferenceData.loaded ?
          Center(child: CircularProgressIndicator()) :
          ListView.builder(
            itemCount: widget.conferenceData.scheduleList.length,
            itemBuilder: (context, index) {
              final item = widget.conferenceData.scheduleList[index];

              if (item is TimeItem) {
                return ListTile(
                  title: Text(
                    item.time,
                    style: Theme.of(context).textTheme.headline,
                  )
                );
              } else if (item is TalkItem) {
                return ListTile(
                  title: Text(item.talk.title),
                  subtitle: Text(item.talk.speaker.name),
                );
              }
            },
          ),
    );
  }
}
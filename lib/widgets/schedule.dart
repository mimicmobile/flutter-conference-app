import 'package:androidto/data/list_items.dart';
import 'package:flutter/material.dart';

class ScheduleWidget extends StatefulWidget {
  final List<ListItem> scheduleList;
  final bool loaded;

  const ScheduleWidget({
    Key key,
    @required this.scheduleList,
    @required this.loaded}) :
        super(key: key);

  @override
  State<StatefulWidget> createState() => ScheduleWidgetState();
}

class ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: !widget.loaded ?
          Center(child: CircularProgressIndicator()) :
          ListView.builder(
            itemCount: widget.scheduleList.length,
            itemBuilder: (context, index) {
              final item = widget.scheduleList[index];

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
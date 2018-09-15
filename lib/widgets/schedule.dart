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
              return widget.scheduleList[index].getWidget(context);
            }
          ),
    );
  }
}
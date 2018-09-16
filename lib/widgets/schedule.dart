import 'package:flutter_conference_app/interfaces/views.dart';
import 'package:flutter_conference_app/models/list_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conference_app/presenters/schedule_presenter.dart';

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

class ScheduleWidgetState extends State<ScheduleWidget> implements IScheduleView {
  SchedulePresenter _presenter;

  @override
  void initState() {
    _presenter = SchedulePresenter(this);
    super.initState();
  }



  @override
  Widget build(BuildContext buildContext) {
    return Container(
      child: !widget.loaded ?
          Center(child: CircularProgressIndicator()) :
          ListView.builder(
            itemCount: widget.scheduleList.length,
            itemBuilder: (context, index) {
              return widget.scheduleList[index].getWidget(context,
                  onTapCallback: _presenter.scheduleTap);
            }
          ),
    );
  }
}

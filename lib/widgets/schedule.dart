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
        color: Color(0xFF330F3C),
        child: Stack(
          children: <Widget>[
            Image.asset(
              'images/speaker-bg.png',
            ),
            !widget.loaded ?  Padding(
                  padding: EdgeInsets.only(top: 100.0, right: 20.0, left: 20.0, bottom: 40.0),
                  child:  Center(
                      child: CircularProgressIndicator()
                  )
                ) :
                ListView.builder(
                  itemCount: widget.scheduleList.length,
                  itemBuilder: (context, index) {
                    return widget.scheduleList[index].getWidget(context,
                        onTapCallback: _presenter.scheduleTap);
                  }
              ),
            Container(
              height: 90.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment(0.0, 0.5),
                  colors: [const Color(0x77000000), const Color(0x00000000)],
                ),
              ),
            ),
          ]
        )
    );
  }
}

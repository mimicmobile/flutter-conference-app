import 'package:androidto/data/models.dart';
import 'package:flutter/material.dart';

class ScheduleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScheduleWidget();
}

class _ScheduleWidget extends State<ScheduleWidget> {
  @override
  void initState() {
    super.initState();

    ConferenceData.get().init();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
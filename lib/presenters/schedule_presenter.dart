import 'package:flutter/material.dart';
import 'package:flutter_conference_app/interfaces/presenters.dart';
import 'package:flutter_conference_app/interfaces/views.dart';
import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter_conference_app/widgets/talk.dart';

class SchedulePresenter implements ISchedulePresenter {
  IScheduleView _view;

  SchedulePresenter(this._view);

  @override
  scheduleTap(BuildContext context, AugmentedTalk talk) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => (TalkWidget(talk))));
  }


}
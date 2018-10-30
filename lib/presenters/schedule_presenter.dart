import 'package:flutter/material.dart';
import 'package:flutter_conference_app/interfaces/presenters.dart';
import 'package:flutter_conference_app/interfaces/views.dart';
import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter_conference_app/utils.dart';
import 'package:flutter_conference_app/widgets/talk.dart';

class SchedulePresenter implements ISchedulePresenter {
  final IScheduleView _view;

  SchedulePresenter(this._view);

  @override
  scheduleTap(BuildContext context, TalkBoss boss) {
    Navigator.of(context).push(FadeRoute(TalkWidget(boss)));
  }
}

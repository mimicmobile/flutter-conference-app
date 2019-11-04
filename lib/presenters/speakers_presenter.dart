import 'package:flutter/material.dart';
import 'package:flutter_conference_app/interfaces/presenters.dart';
import 'package:flutter_conference_app/interfaces/views.dart';
import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter_conference_app/utils.dart';
import 'package:flutter_conference_app/widgets/speaker.dart';

class SpeakersPresenter implements ISpeakersPresenter {
  final ISpeakersView _view;

  SpeakersPresenter(this._view);

  @override
  speakerTap(BuildContext context, Speaker speaker) {
    Navigator.of(context).push(FadeRoute(SpeakerWidget(speaker)));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_conference_app/interfaces/presenters.dart';
import 'package:flutter_conference_app/interfaces/views.dart';
import 'package:flutter_conference_app/models/list_items.dart';

class SpeakersPresenter implements ISpeakersPresenter {
  final ISpeakersView _view;

  SpeakersPresenter(this._view);

  @override
  speakerTap(BuildContext context, SpeakerItem speakerItem) {
  }

}
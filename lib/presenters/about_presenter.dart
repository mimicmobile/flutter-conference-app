import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_conference_app/interfaces/presenters.dart';
import 'package:flutter_conference_app/interfaces/views.dart';
import 'package:flutter_conference_app/models/data.dart';

class AboutPresenter implements IAboutPresenter {
  final IAboutView _view;

  static const String MAP_URL_BASE = "www.google.com";
  static const String MAP_URL_PATH = "/maps/search/";

  AboutPresenter(this._view);

  @override
  aboutTap(BuildContext context, AboutAction action, String target) async {
    switch (action) {
      case AboutAction.Map:
        target = Uri.https(
                MAP_URL_BASE, MAP_URL_PATH, {"api": "1", "query": "$target"})
            .toString();
        break;
      case AboutAction.Email:
      case AboutAction.Twitter:
      case AboutAction.Website:
    }
    if (await canLaunch(target)) {
      launch(target);
    }
  }
}

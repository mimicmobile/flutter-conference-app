import 'package:flutter_conference_app/models/conference_data.dart';
import 'package:flutter_conference_app/models/list_items.dart';
import 'package:flutter_conference_app/interfaces/models.dart';
import 'package:flutter_conference_app/interfaces/presenters.dart';
import 'package:flutter_conference_app/interfaces/views.dart';
import 'package:flutter/widgets.dart';

class HomePresenter implements IHomePresenter {
  final scheduleKey = PageStorageKey('scheduleKey');
  final speakersKey = PageStorageKey('speakersKey');
  final aboutKey = PageStorageKey('aboutKey');

  final PageStorageBucket bucket = PageStorageBucket();

  int currentIndex = 0;
  List<Widget> pages;

  bool loaded = false;
  List<ListItem> scheduleList;
  List<ListItem> speakerList;
  List<ListItem> aboutList;

  IHomeModel _model = ConferenceData();
  IHomeView _view;

  HomePresenter(this._view);

  @override
  void init() {
    _model.init(this);
  }

  @override
  Future checkCache() async {
    if (loaded) {
      await _model.checkAndLoadCache();
    }
  }

  @override
  void refreshState({bool showSnackBar = false}) {
    _view.refreshState(showSnackBar);
  }

  @override
  void showNetworkError() {
    if (!loaded) {
      _view.showNetworkError();
    }
  }

  @override
  void fetchData() {
    _model.checkAndLoadCache();
  }
}

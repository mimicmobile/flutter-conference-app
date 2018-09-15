import 'package:androidto/models/list_items.dart';
import 'package:androidto/interfaces/models.dart';
import 'package:androidto/interfaces/presenters.dart';
import 'package:androidto/interfaces/views.dart';
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

  IHomeModel _model;
  IHomeView _view;

  HomePresenter(this._model, this._view);

  @override
  void init() {
    _model.init(this);
  }

  @override
  void refreshState({bool showSnackBar = false}) {
    _view.refreshState(showSnackBar);
  }

}
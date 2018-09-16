import 'dart:async';

import 'package:flutter_conference_app/config.dart';
import 'package:flutter_conference_app/interfaces/views.dart';
import 'package:flutter_conference_app/presenters/home_presenter.dart';
import 'package:flutter_conference_app/widgets/about.dart';
import 'package:flutter_conference_app/widgets/schedule.dart';
import 'package:flutter_conference_app/widgets/speakers.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> implements IHomeView {
  HomePresenter _presenter;

  BuildContext _buildContext;

  @override
  void initState() {
    _presenter = HomePresenter(this);
    _presenter.init();

    super.initState();
  }

  @override
  void refreshState(bool shouldShow) {
    setState(() {});
    if (shouldShow) {
      showSnackBar('Schedule updated!');
    }
  }

  @override
  Widget build(BuildContext context) {
    _presenter.pages = [
      ScheduleWidget(
          key: _presenter.scheduleKey,
          scheduleList: _presenter.scheduleList,
          loaded: _presenter.loaded),
      SpeakersWidget(
          key: _presenter.speakersKey,
          speakerList: _presenter.speakerList,
          loaded: _presenter.loaded),
      AboutWidget(Colors.purple)
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(Config.title),
      ),
      body: Builder(
          builder: (BuildContext context) {
            _buildContext = context;
            return PageStorage(
              child: _presenter.pages[_presenter.currentIndex],
              bucket: _presenter.bucket,
            );
          }
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _presenter.currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text('Schedule'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Speakers'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.help_outline),
              title: Text('About')
          )
        ],
      ),
    );
  }

  @override
  void onTabTapped(int index) {
    setState(() {
      _presenter.currentIndex = index;
    });
  }

  @override
  void showSnackBar(String text) {
    Future.delayed(Duration.zero, () {
      Scaffold.of(_buildContext).showSnackBar(SnackBar(
          content: Text(text),
          backgroundColor: Colors.orangeAccent
      ));
    });
  }

}

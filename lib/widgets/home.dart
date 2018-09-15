import 'dart:async';

import 'package:androidto/models/conference_data.dart';
import 'package:androidto/interfaces/views.dart';
import 'package:androidto/presenters/home_presenter.dart';
import 'package:androidto/widgets/about.dart';
import 'package:androidto/widgets/schedule.dart';
import 'package:androidto/widgets/speakers.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> implements IHomeView {
  final ConferenceData _conferenceData = ConferenceData();
  HomePresenter _presenter;

  BuildContext _buildContext;

  @override
  void initState() {
    _presenter = new HomePresenter(_conferenceData, this);
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
        title: Text('AndroidTO 2018'),
      ),
      body: new Builder(
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
            icon: new Icon(Icons.schedule),
            title: new Text('Schedule'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text('Speakers'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.help),
              title: Text('About')
          )
        ],
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _presenter.currentIndex = index;
    });
  }

  @override
  void showSnackBar(String text) {
    new Future.delayed(Duration.zero, () {
      Scaffold.of(_buildContext).showSnackBar(new SnackBar(
          content: Text(text),
          backgroundColor: Colors.orangeAccent
      ));
    });
  }

}

import 'dart:async';

import 'package:androidto/data/conference_data.dart';
import 'package:androidto/widgets/about.dart';
import 'package:androidto/widgets/schedule.dart';
import 'package:androidto/widgets/speakers.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final ConferenceData conferenceData = ConferenceData.loading();

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final scheduleKey = PageStorageKey('scheduleKey');
  final speakersKey = PageStorageKey('speakersKey');
  final aboutKey = PageStorageKey('aboutKey');

  final PageStorageBucket bucket = PageStorageBucket();

  int currentIndex = 0;
  List<Widget> pages;

  BuildContext _buildContext;

  @override
  void initState() {
    widget.conferenceData.init(_refreshState);
    super.initState();
  }

  void _refreshState(bool showSnackBar) {
    setState(() {});
    if (showSnackBar) {
      _showSnackBar('Schedule updated!');
    }
  }

  void _showSnackBar(text) {
    new Future.delayed(Duration.zero, () {
      Scaffold.of(_buildContext).showSnackBar(new SnackBar(
        content: Text(text),
        backgroundColor: Colors.orangeAccent
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      ScheduleWidget(
          key: scheduleKey,
          scheduleList: widget.conferenceData.scheduleList,
          loaded: widget.conferenceData.loaded),
      SpeakersWidget(
        key: speakersKey,
        speakerList: widget.conferenceData.speakerList,
        loaded: widget.conferenceData.loaded),
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
              child: pages[currentIndex],
              bucket: bucket,
            );
          }
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: currentIndex,
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
      currentIndex = index;
    });
  }
}

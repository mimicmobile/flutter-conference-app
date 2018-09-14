import 'package:androidto/data/conference_data.dart';
import 'package:androidto/widgets/about.dart';
import 'package:androidto/widgets/schedule.dart';
import 'package:androidto/widgets/speakers.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  ConferenceData conferenceData = ConferenceData.loading();

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

  @override
  void initState() {
    widget.conferenceData.getScheduleList(_refresh)
        .then((scheduleList) {
          _refresh();
        });
    super.initState();
  }

  void _refresh() {
    print("refresh");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      ScheduleWidget(
          key: scheduleKey,
          conferenceData: widget.conferenceData),
      SpeakersWidget(Colors.blueGrey),
      AboutWidget(Colors.purpleAccent)
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('AndroidTO 2018'),
      ),
      body: PageStorage(
        child: pages[currentIndex],
        bucket: bucket,
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

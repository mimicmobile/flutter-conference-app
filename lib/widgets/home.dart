import 'dart:async';

import 'package:flutter_conference_app/interfaces/views.dart';
import 'package:flutter_conference_app/models/conference_data.dart';
import 'package:flutter_conference_app/presenters/home_presenter.dart';
import 'package:flutter_conference_app/widgets/about.dart';
import 'package:flutter_conference_app/widgets/reusable.dart';
import 'package:flutter_conference_app/widgets/schedule.dart';
import 'package:flutter_conference_app/widgets/speakers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home>
    with WidgetsBindingObserver
    implements IHomeView {
  HomePresenter _presenter;

  BuildContext _buildContext;

  @override
  void initState() {
    _presenter = HomePresenter(this);

    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
//    if (state.index == 0) {
//      _presenter.checkCache();
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConferenceData>(builder: (context, data, child) {
      _presenter.pages = [
        ScheduleWidget(
            key: _presenter.scheduleKey,
            scheduleList: data.scheduleList,
            loaded: data.loaded),
        SpeakersWidget(
            key: _presenter.speakersKey,
            speakerList: data.speakerList,
            loaded: data.loaded),
        AboutWidget(
            key: _presenter.aboutKey,
            aboutList: data.aboutList,
            loaded: data.aboutLoaded),
      ];
      return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Builder(builder: (BuildContext context) {
            _buildContext = context;
            _presenter.configureFirebase(context);

            return PageStorage(
              child: _presenter.pages[_presenter.currentIndex],
              bucket: _presenter.bucket,
            );
          }),
          bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                  canvasColor: Theme
                      .of(context)
                      .dialogBackgroundColor,
                  primaryColor: Colors.white,
                  textTheme: Theme
                      .of(context)
                      .textTheme
                      .copyWith(caption: TextStyle(color: Colors.grey[500]))),
              // sets the inactive color of the `BottomNavigationBar`
              child: BottomNavigationBar(
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
                      icon: Icon(Icons.help_outline), title: Text('About'))
                ],
              )),
        ),
      );
    });
  }

  Future<bool> _onWillPop() async {
    if (_presenter.currentIndex != 0) {
      onTabTapped(0);
      return false;
    }
    return true;
  }

  @override
  void onTabTapped(int index) {
    setState(() {
      _presenter.currentIndex = index;
    });
  }

  @override
  void showNetworkError() {
    Reusable.showSnackBar(_buildContext, "Network request error 😟",
        actionText: 'Retry',
//        actionCallback: _presenter.fetchData,
        duration: 1000 * 60 * 5);
  }
}

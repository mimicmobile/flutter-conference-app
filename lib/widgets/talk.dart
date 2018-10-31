import 'package:flutter/material.dart';
import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter_conference_app/widgets/reusable.dart';
import 'package:flutter_conference_app/utils.dart';
import 'package:flutter_conference_app/widgets/speaker.dart';
import 'package:flutter_villains/villain.dart';

class TalkWidget extends StatelessWidget {
  final TalkBoss boss;
  final bool popBack;

  TalkWidget(this.boss, {this.popBack = false});

  void _goToSpeaker(context) {
    if (popBack) {
      Navigator.pop(context);
    } else {
      Navigator.of(context).push(FadeRoute(SpeakerWidget(boss)));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _getChips() {
      var widgets = <Widget>[
        Chip(
            backgroundColor: Colors.red[300],
            label: Text("${boss.currentTalk.time}",
                style: TextStyle(fontSize: 16.0, color: Colors.white)))
      ];

      if (boss.currentTalk.track != null) {
        widgets.add(Chip(
            backgroundColor:
                Utils.convertIntColor(boss.currentTalk.track.color),
            label: Text(
              "${boss.currentTalk.track.name}",
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            )));
      }
      return widgets;
    }

    Widget _getSpeakerContainer() {
      return InkWell(
          onTap: () {
            _goToSpeaker(context);
          },
          child: Padding(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Hero(
                            tag: "avatar${boss.speaker.id}",
                            child: CircleAvatar(
                              maxRadius: 30.0,
                              // TODO: Conditional lookup to replace with Icons.person
                              // if no imageUrl exists
                              backgroundImage:
                                  Utils.imageP(boss.speaker.imagePath),
                            ))),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${boss.speaker.name}",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          "${boss.speaker.company}",
                          style: TextStyle(
                              fontSize: 14.0,
                              height: 1.4,
                              color: Theme.of(context).textTheme.caption.color),
                        ),
                      ],
                    )
                  ])));
    }

    List<Widget> _getCardWidgets(orientation) {
      var widgets = <Widget>[
        Container(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 30.0, bottom: 20.0),
            child: Text(
              "${boss.currentTalk.title}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32.0),
            )),
        Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _getChips()))
      ];
      if (boss.currentTalk.talkType != null) {
        widgets.add(Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: Text(
              "${boss.currentTalk.talkType.description}",
              style:
                  TextStyle(color: Theme.of(context).textTheme.caption.color),
            )));
      }

      if (boss.speaker != null) {
        widgets.add(Divider(height: 4.0));
        widgets.add(_getSpeakerContainer());
      }
      return widgets;
    }

    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
          body: Builder(
              builder: (context) => Container(
                  color: Theme.of(context).backgroundColor,
                  child: Stack(children: <Widget>[
                    Reusable.header,
                    Villain(
                        villainAnimation: VillainAnimation.fromBottom(
                            relativeOffset: 0.05,
                            to: Duration(milliseconds: 200)),
                        secondaryVillainAnimation: VillainAnimation.fade(),
                        animateExit: true,
                        child: Container(
                            child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.only(
                                    top: Utils.getTalkOrientationTopMargin(
                                        orientation),
                                    left: Utils.getOrientationSideMargin(
                                        orientation),
                                    right: Utils.getOrientationSideMargin(
                                        orientation),
                                    bottom: 26.0),
                                child: Column(children: <Widget>[
                                  Card(
                                      elevation: 12.0,
                                      margin: EdgeInsets.only(bottom: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: _getCardWidgets(orientation),
                                      )),
                                  Container(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      padding: EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 4.0,
                                          right: 6.0,
                                          left: 6.0),
                                      child: Text(
                                        'Overview',
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            color: Colors.white),
                                      )),
                                  Container(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      padding: EdgeInsets.only(
                                          top: 4.0,
                                          bottom: 14.0,
                                          right: 6.0,
                                          left: 6.0),
                                      child: Text(
                                        "${boss.currentTalk.description}",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            height: 1.2,
                                            color: Colors.grey[300]),
                                      ))
                                ])))),
                    Reusable.statusBarTopShadow,
                    Reusable.backArrow(context)
                  ]))));
    });
  }
}

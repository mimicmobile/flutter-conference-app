import 'package:flutter/material.dart';
import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter_conference_app/widgets/reusable.dart';
import 'package:flutter_conference_app/utils.dart';
import 'package:flutter_conference_app/widgets/speaker.dart';

class TalkWidget extends StatelessWidget {
  final TalkBoss boss;

  TalkWidget(this.boss);

  void _goToSpeaker(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => (SpeakerWidget(boss))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
          builder: (context) => Container(
                color: Theme.of(context).backgroundColor,
                child: Stack(
                    children: <Widget>[
                      Reusable.header,
                      Center(
                          child: SingleChildScrollView(
                              padding: EdgeInsets.only(top: 30.0, right: 26.0, left: 26.0, bottom: 26.0),
                              child: Column(
                                children: <Widget>[
                                  Card(
                                    elevation: 12.0,
                                    margin: EdgeInsets.only(bottom: 20.0),
                                    child: Padding(
                                        padding: EdgeInsets.all(18.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                padding: EdgeInsets.only(top: 10.0, bottom: 8.0),
                                                child: Text(
                                                  "${boss.currentTalk.title}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 32.0),
                                                )
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(bottom: 8.0),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      Chip(
                                                          backgroundColor: Colors.red[300],
                                                          label: Text(
                                                              "${boss.currentTalk.time}",
                                                              style: TextStyle(fontSize: 16.0, color: Colors.white)
                                                          )
                                                      ),
                                                      Chip(
                                                          backgroundColor: Utils.convertIntColor(boss.currentTalk.track.color),
                                                          label: Text(
                                                            "${boss.currentTalk.track.name}",
                                                            style: TextStyle(fontSize: 16.0, color: Colors.white),
                                                          )
                                                      )
                                                    ]
                                                )
                                            ),
                                            Text(
                                              "${boss.currentTalk.talkType.description}",
                                              style: TextStyle(color: Theme.of(context).textTheme.caption.color),
                                            ),
                                            Divider(
                                                indent: 10.0,
                                                height: 40.0
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(top: 4.0),
                                                child: InkWell(
                                                    onTap: () {
                                                      _goToSpeaker(context);
                                                    },
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
                                                                    backgroundImage: NetworkImage(boss.speaker.imageUrl),
                                                                  )
                                                              )
                                                          ),
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
                                                                    color: Theme.of(context).textTheme.caption.color
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ]
                                                    )
                                              )
                                            ),
                                          ],
                                        )
                                    )
                                ),
                                Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    padding: EdgeInsets.only(top: 10.0, bottom: 4.0, right: 6.0, left: 6.0),
                                    child: Text(
                                      'Overview',
                                      style: TextStyle(fontSize: 22.0, color: Colors.white),
                                    )
                                ),
                                Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    padding: EdgeInsets.only(top: 4.0, bottom: 14.0, right: 6.0, left: 6.0),
                                    child: Text(
                                      "${boss.currentTalk.description}",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(fontSize: 16.0, height: 1.2, color: Colors.grey[300]),
                                    )
                                ),
                              ]
                            )
                          )
                      ),
                      Reusable.statusBarTopShadow,
                      Reusable.backArrow(context)
                    ]
                )
            )
        )
    );
  }

}
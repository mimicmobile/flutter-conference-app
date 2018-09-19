import 'package:flutter/material.dart';
import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter_conference_app/widgets/reusable.dart';
import 'package:icons_helper/icons_helper.dart';

class SpeakerWidget extends StatelessWidget {
  final Speaker speaker;

  SpeakerWidget(this.speaker);

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
                              padding: EdgeInsets.only(top: 70.0, bottom: 40.0, right: 26.0, left: 26.0),
                              child: Column(
                                children: <Widget>[
                                  Stack(
                                      alignment: AlignmentDirectional.topCenter,
                                      children: <Widget>[
                                      Card(
                                        elevation: 12.0,
                                        margin: EdgeInsets.only(top: 82.0, bottom: 20.0),
                                        child: Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                    padding: EdgeInsets.only(top: 80.0, bottom: 6.0),
                                                    child: Text(
                                                      "${speaker.name}",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 32.0),
                                                    )
                                                ),
                                                Text(
                                                  "${speaker.company}",
                                                  style: TextStyle(color: Theme.of(context).textTheme.caption.color),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                                                    child: Divider(
                                                      indent: 10.0,
                                                    )
                                                ),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      Icon(
                                                        getIconGuessFavorFA(name: "twitter"),
                                                        color: Colors.blue[300],
                                                      ),
                                                      Icon(
                                                        getIconGuessFavorFA(name: "github"),
                                                        color: Colors.black,
                                                      ),
                                                      Icon(
                                                        getIconGuessFavorFA(name: "linkedin"),
                                                        color: Colors.green,
                                                      ),
                                                    ]
                                                )
                                              ],
                                            )
                                        )
                                    ),
                                    Hero(
                                        tag: "avatar${speaker.id}",
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(speaker.imageUrl),
                                          maxRadius: 80.0,
                                        )
                                    ),
                                  ]
                                ),
                                Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    padding: EdgeInsets.only(top: 10.0, bottom: 4.0, right: 6.0, left: 6.0),
                                    child: Text(
                                      'About',
                                      style: TextStyle(fontSize: 22.0, color: Colors.white),
                                    )
                                ),
                                Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    padding: EdgeInsets.only(top: 4.0, bottom: 14.0, right: 6.0, left: 6.0),
                                    child: Text(
                                      "${speaker.bio}",
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

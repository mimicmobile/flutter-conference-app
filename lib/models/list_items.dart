import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conference_app/utils.dart';

import 'package:icons_helper/icons_helper.dart';

abstract class ListItem {
  Object getWidget(context, {Function onTapCallback});
}

class HeaderItem implements ListItem {
  HeaderItem();

  @override
  Padding getWidget(context, {onTapCallback}) {
    return Padding(
      padding: EdgeInsets.only(top: 24.0, bottom: 24.0, right: 20.0, left: 20.0),
      child: Image.asset('images/ato-logo.png')
    );
  }
}

class TitleItem implements ListItem {
  final String title;
  TitleItem(this.title);

  @override
  Row getWidget(context, {onTapCallback}) {
    return Row(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(left: 26.0, bottom: 10.0),
          child: Text(
                "$title",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    height: 1.2
                )
            )
        )
      ]
    );
  }
}

class TalkItem implements ListItem {
  final List<dynamic> talk;
  TalkItem(this.talk);

  Container _createTalk(context, AugmentedTalk talky, Function onTapCallback) {
    return Container(
        child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () { onTapCallback(context, talky); },
            child: Column(
              children: <Widget>[
                  Text(
                    '${talky.title}',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 22.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child:
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: CircleAvatar(
                                maxRadius: 30.0,
                                // TODO: Conditional lookup to replace with Icons.person
                                // if no imageUrl exists
                                backgroundImage: NetworkImage(talky.speaker.imageUrl),
                              )
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${talky.speaker.name}',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Text(
                                '${talky.speaker.company}',
                                style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.caption.color),
                              )
                            ],
                          ),
                          Spacer(),
                          CircleAvatar(
                            backgroundColor: Theme.of(context).accentColor,
                            child: Icon(
                              getMaterialIcon(name: talky.talkType.materialIcon),
                              color: Colors.white,
                            )
                          )
                        ],
                      )
                  ),
                  talk.length > 1 ?
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child:
                        Chip(
                            backgroundColor: Utils.convertIntColor(talky.track.color),
                            label: Text(
                              "${talky.track.name}",
                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                            )
                        )
                    ) : Container(),
                  talk.length > 1 && talk.last != talky ?
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 15.0),
                      child: Divider(indent: 10.0)
                    ): Container(),
                  ]
                )
              )
            );
  }

  @override
  Card getWidget(context, {Function onTapCallback}) {
    return Card(
        elevation: 12.0,
        margin: EdgeInsets.only(left: 26.0, right: 26.0, top: 4.0, bottom: 26.0),
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
                talk.map((t) => _createTalk(context, t, onTapCallback)).toList()
        )
      )
    );
  }
}

class SpeakerItem implements ListItem {
  final Speaker speaker;
  SpeakerItem(this.speaker);

  @override
  Widget getWidget(context, {onTapCallback}) {
    return GestureDetector(
        onTap: () { onTapCallback(context, speaker); },
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: <Widget>[
            Card(
              elevation: 12.0,
              margin: EdgeInsets.only(left: 66.0, right: 26.0, bottom: 26.0),
              child: Padding(
                padding: EdgeInsets.only(left: 70.0, top: 26.0, right: 26.0, bottom: 26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      '${speaker.name}',
                      style: TextStyle(fontSize: 22.0),
                    ),
                    Text(
                      '${speaker.company}',
                      style: TextStyle(fontSize: 16.0, color: Theme.of(context).textTheme.caption.color),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Divider(
                          indent: 10.0,
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                ),
              )
            ),
            Padding(
                padding: EdgeInsets.only(left: 22.0, bottom: 26.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(this.speaker.imageUrl),
                  maxRadius: 46.0,
                )
            )
          ]
        )
    );
  }
}

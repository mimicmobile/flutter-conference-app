import 'package:flutter_conference_app/config.dart';
import 'package:flutter_conference_app/models/conference_data.dart';
import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conference_app/utils.dart';
import 'package:flutter_conference_app/widgets/reusable.dart';

import 'package:icons_helper/icons_helper.dart';
import 'package:provider/provider.dart';

abstract class ListItem {
  Object getWidget(context, Orientation orientation, {Function onTapCallback});
}

class HeaderItem implements ListItem {
  HeaderItem();

  @override
  Widget getWidget(context, orientation, {onTapCallback}) {
    return Consumer<ConferenceData>(builder: (context, data, child) {
      return Padding(
          padding: EdgeInsets.only(
              top: 24.0,
              bottom: 24.0,
              right: Utils.getHeaderOrientationSideMargin(orientation),
              left: Utils.getHeaderOrientationSideMargin(orientation)),
          child: Utils.image(Config.logo));
    });
  }
}

class TitleItem implements ListItem {
  final String title;

  TitleItem(this.title);

  @override
  Row getWidget(context, orientation, {onTapCallback}) {
    return Row(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(
              left: Utils.getOrientationSideMargin(orientation), bottom: 10.0),
          child: Text("$title",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  letterSpacing: 1.2,
                  height: 1.2)))
    ]);
  }
}

class TalkItem implements ListItem {
  final List<AugmentedTalk> talks;

  TalkItem(this.talks);

  List<Widget> _getNonSpeakerRow(context, AugmentedTalk talk) {
    var widgets = <Widget>[
      Expanded(
        child: Text(
          '${talk.title}',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 22.0),
        ),
      )
    ];
    if (talk.talkType != null)
      widgets.add(InkWell(
          onTap: () {
            Reusable.showSnackBar(context, talk.talkType.description);
          },
          child: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                getMaterialIcon(name: talk.talkType.materialIcon),
                color: Colors.white,
              ))));
    return widgets;
  }

  Widget _createTalk(context, AugmentedTalk talk, Function onTapCallback) {
    if (talk.hasSpeakers()) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
                onTap: () {
                  onTapCallback(context, talk);
                },
                child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${talk.title}',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 22.0),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: talk.hasOneSpeaker()
                                  ? _createSingleSpeaker(talk, context)
                                  : _createDoubleSpeaker(talk, context))
                        ]))),
            talks.length > 1 && talks.last != talk
                ? Divider(height: 4.0)
                : Container(),
          ]);
    } else {
      return Container(
          child: InkWell(
              onTap: () {
                if (talk.description.isNotEmpty) {
                  onTapCallback(context, talk);
                }
              },
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(children: _getNonSpeakerRow(context, talk)))));
    }
  }

  Row _createSingleSpeaker(AugmentedTalk talk, context) {
    return Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Stack(
              children: <Widget>[
                Hero(
                    tag: "avatar${talk.speakers[0].id}",
                    child:
                        Reusable.circleAvatar(talk.speakers[0].imagePath, 30.0))
              ],
            )),
        Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${talk.speakers[0].name}',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  '${talk.speakers[0].company}',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).textTheme.caption.color),
                ),
                talks.length > 1
                    ? Container(
                        margin: EdgeInsets.only(top: 2.0),
                        child: Text(
                          '${talk.track.name}',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Utils.convertIntColor(talk.track.color)),
                        ))
                    : Container()
              ],
            )),
        Spacer(),
        InkWell(
            onTap: () {
              Reusable.showSnackBar(context, talk.talkType.description);
            },
            child: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                child: Icon(
                  getMaterialIcon(name: talk.talkType.materialIcon),
                  color: Colors.white,
                )))
      ],
    );
  }

  Row _createDoubleSpeaker(AugmentedTalk talk, context) {
    return Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Stack(
              children: <Widget>[
                Hero(
                    tag: "avatar${talk.speakers[0].id}",
                    child: Reusable.circleAvatar(
                        talk.speakers[0].imagePath, 30.0)),
                Container(
                  margin: EdgeInsets.only(left: 34),
                  child: Hero(
                      tag: "avatar${talk.speakers[1].id}",
                      child: Reusable.circleAvatar(
                          talk.speakers[1].imagePath, 30.0)),
                )
              ],
            )),
        Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${talk.speakers[0].name}',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  '${talk.speakers[0].company}',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Theme.of(context).textTheme.caption.color),
                ),
                Container(height: 5),
                Text(
                  '${talk.speakers[1].name}',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  '${talk.speakers[1].company}',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Theme.of(context).textTheme.caption.color),
                ),
                talks.length > 1
                    ? Container(
                        margin: EdgeInsets.only(top: 2.0),
                        child: Text(
                          '${talk.track.name}',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Utils.convertIntColor(talk.track.color)),
                        ))
                    : Container()
              ],
            )),
        Spacer(),
        InkWell(
            onTap: () {
              Reusable.showSnackBar(context, talk.talkType.description);
            },
            child: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                child: Icon(
                  getMaterialIcon(name: talk.talkType.materialIcon),
                  color: Colors.white,
                )))
      ],
    );
  }

  @override
  Card getWidget(context, orientation, {Function onTapCallback}) {
    return Card(
        elevation: 12.0,
        margin: EdgeInsets.only(
            left: Utils.getOrientationSideMargin(orientation),
            right: Utils.getOrientationSideMargin(orientation),
            top: 4.0,
            bottom: 26.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: talks
                .map((t) => _createTalk(context, t, onTapCallback))
                .toList()));
  }
}

class SpeakerItem implements ListItem {
  final Speaker speaker;

  SpeakerItem(this.speaker);

  @override
  Widget getWidget(context, orientation, {onTapCallback}) {
    return GestureDetector(
        onTap: () {
          onTapCallback(context, speaker);
        },
        child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: <Widget>[
              Card(
                  elevation: 12.0,
                  margin: EdgeInsets.only(
                      left: 46.0 + Utils.getOrientationSideMargin(orientation),
                      right: Utils.getOrientationSideMargin(orientation),
                      bottom: 26.0),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 70.0, top: 20.0, right: 20.0, bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Hero(
                            tag: "name${speaker.id}",
                            child: Text(
                              '${speaker.name}',
                              style: TextStyle(fontSize: 22.0),
                            )),
                        Text(
                          '${speaker.company}',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).textTheme.caption.color),
                        ),
                        Divider(
                          height: 40.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: Reusable.getLinkIcons(speaker))
                      ],
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      left: Utils.getOrientationSideMargin(orientation),
                      bottom: 26.0),
                  child: Hero(
                      tag: "avatar${speaker.id}",
                      child: Reusable.circleAvatar(speaker.imagePath, 46.0)))
            ]));
  }
}

class ConferenceItem implements ListItem {
  final String description;
  final String twitter;
  final String website;
  final String contactEmail;

  ConferenceItem(
      this.description, this.twitter, this.website, this.contactEmail);

  List<Widget> _getAboutLinkIcons() {
    var linkIcons = <Widget>[];

    if (this.twitter != "") {
      linkIcons
          .add(Reusable.getLinkIcon("twitter", Colors.blue[300], this.twitter));
    }
    if (this.website != "") {
      linkIcons
          .add(Reusable.getLinkIcon("link", Colors.red[300], this.website));
    }
    if (this.contactEmail != "") {
      linkIcons.add(
          Reusable.getLinkIcon("email", Colors.orange[300], this.contactEmail));
    }

    return linkIcons;
  }

  @override
  Widget getWidget(context, orientation, {Function onTapCallback}) {
    return Card(
        elevation: 12.0,
        margin: EdgeInsets.only(
            left: Utils.getOrientationSideMargin(orientation),
            right: Utils.getOrientationSideMargin(orientation),
            top: 4.0,
            bottom: 26.0),
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('$description', style: TextStyle(fontSize: 15.0)),
                  Divider(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getAboutLinkIcons(),
                  )
                ])));
  }
}

class VenueItem implements ListItem {
  final String name;
  final String imagePath;
  final String address;

  VenueItem(this.name, this.address, this.imagePath);

  @override
  Widget getWidget(context, orientation, {Function onTapCallback}) {
    return GestureDetector(
        onTap: () {
          onTapCallback(context, AboutAction.Map, address);
        },
        child: Card(
            elevation: 12.0,
            margin: EdgeInsets.only(
                left: Utils.getOrientationSideMargin(orientation),
                right: Utils.getOrientationSideMargin(orientation),
                top: 4.0,
                bottom: 26.0),
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(name, style: TextStyle(fontSize: 16.0)),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Flex(
                            direction: Axis.vertical,
                            children: <Widget>[
                              Utils.image(imagePath, height: 224.0)
                            ],
                          )),
                      Text(address, style: TextStyle(fontSize: 14.0)),
                    ]))));
  }
}

class AboutListItem implements ListItem {
  final List<AboutLink> links;

  AboutListItem(this.links);

  Container _createLink(context, AboutLink sponsor, Function onTapCallback) {
    return Container(
        child: InkWell(
            onTap: () {
              onTapCallback(context, AboutAction.Website, sponsor.website);
            },
            child: ClipRRect(
                borderRadius: new BorderRadius.circular(4.0),
                child: Utils.image(
                  sponsor.imagePath,
                  height: 100.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                ))));
  }

  @override
  Widget getWidget(context, orientation, {Function onTapCallback}) {
    return Container(
        margin: EdgeInsets.only(
            left: Utils.getOrientationSideMargin(orientation),
            right: Utils.getOrientationSideMargin(orientation),
            top: 8.0,
            bottom: 26.0),
        child: Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            alignment: WrapAlignment.spaceBetween,
            children: links
                .map((s) => _createLink(context, s, onTapCallback))
                .toList()));
  }
}

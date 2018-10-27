import 'package:flutter_conference_app/config.dart';
import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conference_app/utils.dart';
import 'package:flutter_conference_app/widgets/reusable.dart';

import 'package:icons_helper/icons_helper.dart';

abstract class ListItem {
  Object getWidget(context, {Function onTapCallback});
}

class HeaderItem implements ListItem {
  HeaderItem();

  @override
  Padding getWidget(context, {onTapCallback}) {
    return Padding(
        padding:
            EdgeInsets.only(top: 24.0, bottom: 24.0, right: 20.0, left: 20.0),
        child: Image.asset(Config.logo));
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
  final List<TalkBoss> talks;

  TalkItem(this.talks);

  List<Widget> _getNonSpeakerRow(context, boss) {
    var widgets = <Widget>[
      Expanded(
        child: Text(
          '${boss.currentTalk.title}',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 22.0),
        ),
      )
    ];
    if (boss.currentTalk.talkType != null)
      widgets.add(InkWell(
          onTap: () {
            Reusable.showSnackBar(
                context, boss.currentTalk.talkType.description);
          },
          child: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                getMaterialIcon(name: boss.currentTalk.talkType.materialIcon),
                color: Colors.white,
              ))));
    return widgets;
  }

  Container _createTalk(context, TalkBoss boss, Function onTapCallback) {
    if (boss.speaker != null) {
      return Container(
          child: InkWell(
              onTap: () {
                onTapCallback(context, boss);
              },
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${boss.currentTalk.title}',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 22.0),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Row(
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
                                          NetworkImage(boss.speaker.imageUrl),
                                    ))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${boss.speaker.name}',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text(
                                  '${boss.speaker.company}',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .color),
                                ),
                                talks.length > 1
                                    ? Container(
                                        margin: EdgeInsets.only(top: 2.0),
                                        child: Text(
                                          '${boss.currentTalk.track.name}',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Utils.convertIntColor(boss
                                                  .currentTalk.track.color)),
                                        ))
                                    : Container()
                              ],
                            ),
                            Spacer(),
                            InkWell(
                                onTap: () {
                                  Reusable.showSnackBar(context,
                                      boss.currentTalk.talkType.description);
                                },
                                child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                    child: Icon(
                                      getMaterialIcon(
                                          name: boss.currentTalk.talkType
                                              .materialIcon),
                                      color: Colors.white,
                                    )))
                          ],
                        )),
                    talks.length > 1 && talks.last != boss
                        ? Divider(height: 40.0)
                        : Container(),
                  ])));
    } else {
      return Container(
          child: InkWell(
              onTap: () {
                if (boss.currentTalk.description != null) {
                  onTapCallback(context, boss);
                }
              },
              child: Row(children: _getNonSpeakerRow(context, boss))));
    }
  }

  @override
  Card getWidget(context, {Function onTapCallback}) {
    return Card(
        elevation: 12.0,
        margin:
            EdgeInsets.only(left: 26.0, right: 26.0, top: 4.0, bottom: 26.0),
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: talks
                    .map((t) => _createTalk(context, t, onTapCallback))
                    .toList())));
  }
}

class SpeakerItem implements ListItem {
  final TalkBoss boss;

  SpeakerItem(this.boss);

  @override
  Widget getWidget(context, {onTapCallback}) {
    return GestureDetector(
        onTap: () {
          onTapCallback(context, boss);
        },
        child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: <Widget>[
              Card(
                  elevation: 12.0,
                  margin:
                      EdgeInsets.only(left: 66.0, right: 26.0, bottom: 26.0),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 70.0, top: 20.0, right: 20.0, bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Hero(
                            tag: "name${boss.speaker.id}",
                            child: Text(
                              '${boss.speaker.name}',
                              style: TextStyle(fontSize: 22.0),
                            )),
                        Text(
                          '${boss.speaker.company}',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).textTheme.caption.color),
                        ),
                        Divider(
                          height: 40.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: Reusable.getLinkIcons(boss.speaker))
                      ],
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 22.0, bottom: 26.0),
                  child: Hero(
                      tag: "avatar${boss.speaker.id}",
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(boss.speaker.imageUrl),
                        maxRadius: 46.0,
                      )))
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
          .add(Reusable.getLinkIcon("chrome", Colors.red[300], this.website));
    }
    if (this.contactEmail != "") {
      linkIcons.add(
          Reusable.getLinkIcon("email", Colors.orange[300], this.contactEmail));
    }

    return linkIcons;
  }

  @override
  Widget getWidget(context, {Function onTapCallback}) {
    return Card(
        elevation: 12.0,
        margin:
            EdgeInsets.only(left: 26.0, right: 26.0, top: 4.0, bottom: 26.0),
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
  final String imageUrl;
  final String address;

  VenueItem(this.name, this.address, this.imageUrl);

  @override
  Widget getWidget(context, {Function onTapCallback}) {
    return GestureDetector(
        onTap: () {
          onTapCallback(context, AboutAction.Map, address);
        },
        child: Card(
            elevation: 12.0,
            margin: EdgeInsets.only(
                left: 26.0, right: 26.0, top: 4.0, bottom: 26.0),
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
                            children: <Widget>[Image.asset(Config.venueMap)],
                          )),
                      Text(address, style: TextStyle(fontSize: 14.0)),
                    ]))));
  }
}

class SponsorItem implements ListItem {
  final List<Sponsor> sponsors;

  SponsorItem(this.sponsors);

  Container _createSponsor(context, Sponsor sponsor, Function onTapCallback) {
    return Container(
        child: InkWell(
            onTap: () {
              onTapCallback(context, AboutAction.Website, sponsor.website);
            },
            child: ClipRRect(
                borderRadius: new BorderRadius.circular(4.0),
                child: Image.network(
                  sponsor.imageUrl,
                  height: 100.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                ))));
  }

  @override
  Widget getWidget(context, {Function onTapCallback}) {
    return Container(
        margin:
            EdgeInsets.only(left: 26.0, right: 26.0, top: 8.0, bottom: 26.0),
        child: Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            alignment: WrapAlignment.spaceBetween,
            children: sponsors
                .map((s) => _createSponsor(context, s, onTapCallback))
                .toList()));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_conference_app/config.dart';
import 'package:icons_helper/icons_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class Reusable {
  static get header {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Config.listBackground),
              alignment: AlignmentDirectional.topCenter,
              fit: BoxFit.fitWidth)),
    );
  }

  static get statusBarTopShadow {
    return Container(
      height: 90.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0.0, 0.5),
          colors: [const Color(0x77000000), const Color(0x00000000)],
        ),
      ),
    );
  }

  static loadingProgress(orientation) {
    return Padding(
        padding:
            EdgeInsets.only(top: 100.0, right: 20.0, left: 20.0, bottom: 40.0),
        child: Center(child: CircularProgressIndicator()));
  }

  static Widget backArrow(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
            padding: EdgeInsets.all(26.0),
            margin: EdgeInsets.only(top: 30.0),
            child: Icon(Icons.arrow_back, color: Colors.white)));
  }

  static Widget getLinkIcon(String iconName, Color color, String url) {
    return InkWell(
        onTap: () async {
          if (await canLaunch(url)) {
            launch(url);
          }
        },
        child: Icon(
          getIconGuessFavorFA(name: iconName),
          color: color,
        ));
  }

  static List<Widget> getLinkIcons(speaker) {
    var linkIcons = <Widget>[];

    if (speaker.twitter != "") {
      linkIcons.add(getLinkIcon("twitter", Colors.blue[300], speaker.twitter));
    }
    if (speaker.github != "") {
      linkIcons.add(getLinkIcon("github", Colors.black, speaker.github));
    }
    if (speaker.linkedIn != "") {
      linkIcons
          .add(getLinkIcon("linkedin", Colors.blue[700], speaker.linkedIn));
    }

    return linkIcons;
  }

  static showSnackBar(BuildContext context, String text,
      {duration: 1400, String actionText, Function actionCallback}) {
    Future.delayed(Duration.zero, () {
      var snackBarAction;
      if (actionText != null && actionCallback != null) {
        snackBarAction = SnackBarAction(
            label: actionText,
            onPressed: () {
              actionCallback();
            });
      }

      var snackBar = SnackBar(
          action: snackBarAction,
          duration: Duration(milliseconds: duration),
          content: Text(text),
          backgroundColor: Theme.of(context).dialogBackgroundColor);
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }
}

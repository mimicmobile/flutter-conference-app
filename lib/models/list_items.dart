import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter/material.dart';

import 'package:icons_helper/icons_helper.dart';

abstract class ListItem {
  ListTile getWidget(context, {Function onTapCallback});
}

class TimeItem implements ListItem {
  final String time;
  TimeItem(this.time);

  @override
  ListTile getWidget(context, {onTapCallback}) {
    return ListTile(
      title: Text(
        this.time,
        style: Theme.of(context).textTheme.headline
      )
    );
  }
}

class TalkItem implements ListItem {
  final AugmentedTalk talk;
  TalkItem(this.talk);

  @override
  ListTile getWidget(context, {Function onTapCallback}) {
    return ListTile(
      leading: Icon(getIconGuessFavorMaterial(name: this.talk.talkType.materialIcon)),
      title: Text(this.talk.title),
      subtitle: Text(this.talk.speaker.name),
      onTap: () { onTapCallback(context, this); }
    );
  }
}

class SpeakerItem implements ListItem {
  final Speaker speaker;
  SpeakerItem(this.speaker);

  @override
  ListTile getWidget(context, {onTapCallback}) {
    return ListTile(
      title: Text(
        this.speaker.name,
        style: Theme.of(context).textTheme.headline
      ),
      subtitle: Text(this.speaker.bio),
    );
  }
}

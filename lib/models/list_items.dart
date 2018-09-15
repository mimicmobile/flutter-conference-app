import 'package:androidto/models/data.dart';
import 'package:flutter/material.dart';

abstract class ListItem {
  ListTile getWidget(context);
}

class TimeItem implements ListItem {
  final String time;
  TimeItem(this.time);

  @override
  ListTile getWidget(context) {
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
  ListTile getWidget(context) {
    return ListTile(
      title: Text(this.talk.title),
      subtitle: Text(this.talk.speaker.name),
    );
  }
}

class SpeakerItem implements ListItem {
  final Speaker speaker;
  SpeakerItem(this.speaker);

  @override
  ListTile getWidget(context) {
    return ListTile(
      title: Text(
        this.speaker.name,
        style: Theme.of(context).textTheme.headline
      ),
      subtitle: Text(this.speaker.bio),
    );
  }
}

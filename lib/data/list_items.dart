import 'package:androidto/data/models.dart';

abstract class ListItem {
}

class TimeItem implements ListItem {
  final String time;
  TimeItem(this.time);
}

class TalkItem implements ListItem {
  final AugmentedTalk talk;
  TalkItem(this.talk);
}
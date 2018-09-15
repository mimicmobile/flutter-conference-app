import 'package:flutter_conference_app/models/list_items.dart';
import 'package:flutter/material.dart';

class SpeakersWidget extends StatelessWidget {
  final List<ListItem> speakerList;
  final bool loaded;

  SpeakersWidget({
    Key key,
    @required this.speakerList,
    @required this.loaded
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !loaded ?
      Center(child: CircularProgressIndicator()) :
      ListView.builder(
          itemCount: speakerList.length,
          itemBuilder: (context, index) {
            return speakerList[index].getWidget(context);
          }
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_conference_app/models/list_items.dart';

class TalkWidget extends StatelessWidget {
  final TalkItem item;

  TalkWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF330F3C),
      child: Stack(
        children: <Widget>[
          Image.asset(
            'images/speaker-bg.png',
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 70.0, right: 20.0, left: 20.0, bottom: 40.0),
              child: Card(
                margin: EdgeInsets.all(6.0),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 22.0),
                        child: Text(
                          this.item.talk.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 32.0),
                        )
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Chip(
                              backgroundColor: Colors.red[300],
                              label: Text(
                                this.item.talk.time,
                                style: TextStyle(fontSize: 16.0, color: Colors.white)
                              )
                            ),
                            Chip(
                              backgroundColor: Color(
                                  int.parse(
                                    // HAXX
                                      this.item.talk.track.color.replaceAll('#', ''),
                                      radix: 16))
                                  .withOpacity(1.0),
                              label: Text(
                                this.item.talk.track.name,
                                style: TextStyle(fontSize: 16.0, color: Colors.white),
                              )
                            )
                          ]
                        )
                      ),
                      Text('This talk can be enjoyed by everyone'),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Divider(
                          indent: 10.0,
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.0, bottom: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: CircleAvatar(
                                maxRadius: 30.0,
                                // TODO: Conditional lookup to replace with Icons.person
                                // if no imageUrl exists
                                backgroundImage: NetworkImage(this.item.talk.speaker.imageUrl),
                              )
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  this.item.talk.speaker.name,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text(
                                  this.item.talk.speaker.company,
                                  style: TextStyle(fontSize: 14.0, height: 1.4),
                                ),
                              ],
                            )
                          ]
                        )
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        padding: EdgeInsets.only(top: 10.0, bottom: 4.0),
                        child: Text(
                          'Overview',
                          style: TextStyle(fontSize: 20.0),
                        )
                      ),
                      Container(
                          alignment: AlignmentDirectional.centerStart,
                          padding: EdgeInsets.only(top: 4.0, bottom: 14.0),
                          child: Text(
                            this.item.talk.description,
                            style: TextStyle(fontSize: 15.0, height: 1.2),
                          )
                      ),
                    ],
                  )
                )
              )
            )
          )
        ]
      )
    );
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_conference_app/models/list_items.dart';

class TalkWidget extends StatelessWidget {
  final TalkItem item;

  TalkWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Color(0xFF330F3C),
      child: Stack(
        children: <Widget>[
          Image.asset(
            'images/speaker-bg.png',
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.0, right: 20.0, left: 20.0),
            child: Card(
              margin: EdgeInsets.all(20.0),
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        this.item.talk.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 32.0),
                      )
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Chip(
                          backgroundColor: Color(int.parse(this.item.talk.track.color.replaceAll('#', ''), radix: 16)).withOpacity(1.0),
                          label: Text(
                            this.item.talk.track.name,
                            style: TextStyle(fontSize: 16.0),
                          )
                        )
                    ),
                    Text('This talk can be enjoyed by everyone'),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Divider(
                        indent: 20.0,
                      )
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(right: 20.0, top: 16.0, bottom: 16.0),
                            child: CircleAvatar(
                              maxRadius: 30.0,
                              child: this.item.talk.speaker.imageUrl != null ?
                                  Image.network(this.item.talk.speaker.imageUrl) :
                                  Icon(Icons.person)
                            )
                        ),
                        Text(
                          this.item.talk.speaker.name,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Spacer(),
                        Text(
                          this.item.talk.time,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ]
                    ),
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        'Overview',
                        style: TextStyle(fontSize: 20.0),
                      )
                    ),
                    Container(
                        alignment: AlignmentDirectional.centerStart,
                        padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: Text(
                          this.item.talk.description,
                          style: TextStyle(fontSize: 15.0),
                        )
                    ),
                  ],
                )
              )
            )
          )
        ]
      )
    );
  }

}
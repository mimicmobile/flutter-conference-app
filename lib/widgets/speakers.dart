import 'package:flutter/material.dart';

class SpeakersWidget extends StatelessWidget {
  final Color color;

  SpeakersWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
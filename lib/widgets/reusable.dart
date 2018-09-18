import 'package:flutter/material.dart';
import 'package:flutter_conference_app/config.dart';

class Reusable {
  static get header {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Config.listBackground),
            alignment: AlignmentDirectional.topCenter,
            fit: BoxFit.fitWidth
        )
      ),
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

  static get loadingProgress {
    return Padding(
      padding: EdgeInsets.only(top: 100.0, right: 20.0, left: 20.0, bottom: 40.0),
      child:  Center(
          child: CircularProgressIndicator()
      )
    );
  }

  static InkWell backArrow(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.0),
      highlightColor: Theme.of(context).accentColor,
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 60.0, left: 26.0),
        child: Icon(Icons.arrow_back, color: Colors.white)
      )
    );
  }
}
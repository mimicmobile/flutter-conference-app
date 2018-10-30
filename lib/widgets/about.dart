import 'package:flutter/material.dart';
import 'package:flutter_conference_app/interfaces/presenters.dart';
import 'package:flutter_conference_app/interfaces/views.dart';
import 'package:flutter_conference_app/models/list_items.dart';
import 'package:flutter_conference_app/presenters/about_presenter.dart';
import 'package:flutter_conference_app/widgets/reusable.dart';

class AboutWidget extends StatefulWidget {
  final List<ListItem> aboutList;
  final bool loaded;

  const AboutWidget({Key key, @required this.aboutList, @required this.loaded})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => AboutWidgetState();
}

class AboutWidgetState extends State<AboutWidget> implements IAboutView {
  IAboutPresenter _presenter;

  @override
  void initState() {
    _presenter = AboutPresenter(this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Container(
          color: Theme.of(context).backgroundColor,
          child: Stack(children: <Widget>[
            Reusable.header,
            !widget.loaded
                ? Reusable.loadingProgress(orientation)
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: widget.aboutList.length,
                    itemBuilder: (context, index) {
                      return widget.aboutList[index].getWidget(
                          context, orientation,
                          onTapCallback: _presenter.aboutTap);
                    }),
            Reusable.statusBarTopShadow,
          ]));
    });
  }
}

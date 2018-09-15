import 'dart:async';

import 'package:flutter_conference_app/interfaces/presenters.dart';

abstract class IHomeModel {
  Future init(IHomePresenter presenter);
}

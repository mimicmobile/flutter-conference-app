import 'dart:async';

import 'package:androidto/interfaces/presenters.dart';

abstract class IHomeModel {
  Future init(IHomePresenter presenter);
}

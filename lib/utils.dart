import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Utils {
  static Color convertIntColor(String color) {
    return Color(int.parse(color.replaceAll('#', ''), radix: 16))
        .withOpacity(1.0);
  }

  static findItemsById(List l, id) {
    List list = List();

    for (final i in l) {
      if (i.id == id) list.add(i);
    }

    return list;
  }

  static findItemById(List l, id) {
    try {
      return findItemsById(l, id)[0];
    } catch (e) {
      return null;
    }
  }
}

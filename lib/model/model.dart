import 'dart:async';

import 'package:flutter/material.dart';

@immutable
class BaseClass {
  final int id;
  final int current;
  final int lastUpdate;

  BaseClass()
      : current = DateTime.now().microsecond,
        lastUpdate = DateTime.now().second,
        id = DateTime.now().millisecondsSinceEpoch;

  bool operator ==(covariant BaseClass t) => id == t.id;
}

@immutable
class Cheap extends BaseClass {}

@immutable
class Expenses extends BaseClass {}

@immutable
class changePder extends ChangeNotifier {
  late int id;
  late Cheap _cheap;
  late Expenses _expenses;
  late StreamSubscription cheapSubscrption;
  late StreamSubscription expensiveSubsciption;
  changePder() {
    id = DateTime.now().microsecondsSinceEpoch;
    _cheap = Cheap();
    _expenses = Expenses();
    start();
  }

  Cheap get cheap => _cheap;
  Expenses get expense => _expenses;

  start() {
    cheapSubscrption = Stream.periodic(Duration(seconds: 1)).listen((event) {
      _cheap = Cheap();
      notifyListeners();
    });

    expensiveSubsciption =
        Stream.periodic(Duration(seconds: 10)).listen((event) {
      _expenses = Expenses();
    });
  }

  stop() {
    cheapSubscrption.cancel();
    expensiveSubsciption.cancel();
  }
}

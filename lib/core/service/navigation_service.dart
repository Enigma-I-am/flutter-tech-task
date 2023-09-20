import 'package:flutter/material.dart';

final navigator = NavigationService();

class NavigationService {
  /// Navigator state key
  final key = GlobalKey<NavigatorState>();

  /// Navigator's current state
  NavigatorState? get state => key.currentState;

  /// Navigator's current context
  BuildContext get context => state!.context;
}

import 'package:flutter/material.dart';

class ProviderNotifier<T extends ChangeNotifier>
    extends InheritedNotifier<T> {
  final T model;
  const ProviderNotifier(
      {Key? key, required Widget child, required this.model})
      : super(key: key, child: child, notifier: model);

  static T? watch<T extends ChangeNotifier>(
      BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProviderNotifier<T>>()
        ?.model;
  }

  static T? read<T extends ChangeNotifier>(
      BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ProviderNotifier<T>>()
        ?.widget;
    return widget is ProviderNotifier<T> ? widget.model : null;
  }
}
import 'package:flutter/material.dart';

//Declaring Inherited Widget
class PathNamingWidget extends InheritedWidget {
  const PathNamingWidget({
    super.key,
    required super.child,
    required this.path,
    // required this.onColorChange,
  });

  final String path;
  // final void Function() onColorChange;

  static PathNamingWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PathNamingWidget>();

  @override
  bool updateShouldNotify(PathNamingWidget oldWidget) {
    return oldWidget.path != path;
  }
}

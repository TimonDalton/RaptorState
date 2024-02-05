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

//Reading InheritedWidget
class PathReadingWidget extends StatelessWidget {
  const PathReadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      child: Text(PathNamingWidget.of(context)!.path),
    );
  }
}

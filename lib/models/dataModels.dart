import 'dart:convert';
import './loadable.dart';
import 'package:giglee_frontend_state_management_iterations/global.dart';

class M1 {
  List<Loadable<M1_Child>> value;
  M1({required this.value});

  static M1 fromJSON(String s) {
    Map<String, int> json = jsonDecode(s);
    List<Loadable<M1_Child>> children = [];

    json.entries.forEach((el) {
      children.add(Loadable(
          UUID: el.key,
          value: M1_Child(value: el.value),
          serviceUpdateCallback: loadableService.childChangeCallback));
    });

    return M1(value: children);
  }
}

class M1_Child {
  int value;
  M1_Child({required this.value});

  static M1_Child fromJSON(String s) {
    final json = jsonDecode(s);
    return M1_Child(value: json['value']);
  }
}

class M2 {
  String value;
  M2({required this.value});

  static M2 fromJSON(String s) {
    final json = jsonDecode(s);
    return M2(value: json['value']);
  }
}

import 'dart:convert';
import 'package:giglee_frontend_state_management_iterations/global.dart';

class M0 {
  List<M0_Child> value;
  M0({required this.value});

  static M0 fromJson(String rawJson) {
    List<M0_Child> children = [];
    Map<String, dynamic> json = jsonDecode(rawJson);
    json.forEach((key, value) {
      children.add(M0_Child(value: value));
    });
    return M0(value: children);
  }
}

class M0_Child {
  List<M0_GrandChild> value;
  M0_Child({required this.value});

  static M0_Child fromJson(String rawJson) {
    List<M0_GrandChild> children = [];
    Map<String, dynamic> json = jsonDecode(rawJson);
    json.forEach((key, value) {
      children.add(M0_GrandChild(value: value));
    });
    return M0_Child(value: children);
  }
}

class M0_GrandChild {
  int value;
  M0_GrandChild({required this.value});

  static M0_GrandChild fromJson(String s) {
    final json = jsonDecode(s);
    return M0_GrandChild(value: json['value']);
  }
}

class M1 {
  List<M1_Child> value;
  M1({required this.value});

  static M1 fromJson(String rawJson) {
    List<M1_Child> children = [];
    Map<String, dynamic> json = jsonDecode(rawJson);
    json.forEach((key, value) {
      children.add(M1_Child(value: value));
    });
    return M1(value: children);
  }
}

class M1_Child {
  int value;
  M1_Child({required this.value});

  static M1_Child fromJson(String s) {
    final json = jsonDecode(s);
    return M1_Child(value: json['value']);
  }
}

class M2 {
  String value;
  M2({required this.value});

  static M2 fromJson(String s) {
    final json = jsonDecode(s);
    return M2(value: json['value']);
  }

  String toJson() {
    return jsonEncode(this);
  }
}

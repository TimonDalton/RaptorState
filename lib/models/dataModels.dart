import 'dart:convert';
import 'package:giglee_frontend_state_management_iterations/global.dart';

abstract class RequestableModel {
  // RequestableModel fromJson(Map<String, dynamic> json);
}

class M0 implements RequestableModel {
  List<M0_Child> value;
  M0({required this.value});

  static M0 fromJson(Map<String, dynamic> json) {
    List<M0_Child> children = [];
    json.forEach((key, value) {
      children.add(M0_Child(value: value));
    });
    return M0(value: children);
  }
}

class M0_Child implements RequestableModel {
  List<M0_GrandChild> value;
  M0_Child({required this.value});

  static M0_Child fromJson(Map<String, dynamic> json) {
    List<M0_GrandChild> children = [];
    json.forEach((key, value) {
      children.add(M0_GrandChild(value: value));
    });
    return M0_Child(value: children);
  }
}

class M0_GrandChild implements RequestableModel {
  int value;
  M0_GrandChild({required this.value});

  static M0_GrandChild fromJson(Map<String, dynamic> json) {
    return M0_GrandChild(value: json['value']);
  }
}

class M1 implements RequestableModel {
  List<M1_Child> value;
  M1({required this.value});

  static M1 fromJson(Map<String, dynamic> json) {
    List<M1_Child> children = [];
    json.forEach((key, value) {
      children.add(M1_Child(value: value));
    });
    return M1(value: children);
  }
}

class M1_Child implements RequestableModel {
  int value;
  M1_Child({required this.value});

  static M1_Child fromJson(Map<String, dynamic> json) {
    return M1_Child(value: json['value']);
  }
}

class M2 implements RequestableModel {
  String value;
  M2({required this.value});

  static M2 fromJson(Map<String, dynamic> json) {
    return M2(value: json['value']);
  }

  String toJson() {
    return jsonEncode(this);
  }
}

import './dataModels.dart';

dynamic Function(Map<String, dynamic>) typeMatchedFromJson(Type t) {
  switch (t) {
    case M2:
      return M2.fromJson;
    case M1:
      return M1.fromJson;
    case M1_Child:
      return M1_Child.fromJson;
    case M0:
      return M0.fromJson;
    case M0_Child:
      return M0_Child.fromJson;
    case M0_GrandChild:
      return M0_GrandChild.fromJson;
    default:
      throw Exception('Unknown type ${t.toString()}');
  }
}

Map<String, dynamic> Function(dynamic) typeMatchedToJson(Type t) {
  switch (t) {
    case M2:
      return M2.toJson as Map<String, dynamic> Function(dynamic);
    case M1:
      return M1.toJson as Map<String, dynamic> Function(dynamic);
    case M1_Child:
      return M1_Child.toJson as Map<String, dynamic> Function(dynamic);
    case M0:
      return M0.toJson as Map<String, dynamic> Function(dynamic);
    case M0_Child:
      return M0_Child.toJson as Map<String, dynamic> Function(dynamic);
    case M0_GrandChild:
      return M0_GrandChild.toJson as Map<String, dynamic> Function(dynamic);
    default:
      throw Exception('Unkown type ${t.toString()}');
  }
}

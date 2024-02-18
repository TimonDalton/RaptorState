import './dataModels.dart';
import './dataHelper.dart';

DataItem createTypedDataItem(String type, String internalIdPath) {
  switch (type) {
    case 'M2':
      return DataItem.create<M2>(internalIdPath);
    case 'M1':
      return DataItem.create<M1>(internalIdPath);
    case 'M1_Child':
      return DataItem.create<M1_Child>(internalIdPath);
    case 'M0':
      return DataItem.create<M0>(internalIdPath);
    case 'M0_Child':
      return DataItem.create<M0_Child>(internalIdPath);
    case 'M0_Grandchild':
      return DataItem.create<M0_GrandChild>(internalIdPath);
    default:
      throw Exception('Unkown type ${type.toString()}');
  }
}

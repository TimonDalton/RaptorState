import './dataModels.dart';
import './dataHelper.dart';

DataItem createTypedDataItem(
    String type, List<Updater> updaters, String internalIdPath) {
  switch (type) {
    case 'M2':
      return DataItem.create<M2>(updaters, internalIdPath, ValueStore<M2>());
    case 'M1':
      return DataItem.create<M1>(updaters, internalIdPath, ValueStore<M1>());
    case 'M1_Child':
      return DataItem.create<M1_Child>(
          updaters, internalIdPath, ValueStore<M1_Child>());
    case 'M0':
      return DataItem.create<M0>(updaters, internalIdPath, ValueStore<M0>());
    case 'M0_Child':
      return DataItem.create<M0_Child>(
          updaters, internalIdPath, ValueStore<M0_Child>());
    case 'M0_GrandChild':
      return DataItem.create<M0_GrandChild>(
          updaters, internalIdPath, ValueStore<M0_GrandChild>());
    default:
      throw Exception('Unkown type ${type.toString()}');
  }
}

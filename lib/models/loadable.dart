// LoadableServices
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:giglee_frontend_state_management_iterations/global.dart';

// enum LoadingState { loaded, loading, unfeteched }

class Loadable<T> {
  String UUID;
  DateTime? lastUpdated;
  Function? helper;
  T? value;
  String? apiURI;
  List<String> childrenUUIDs;
  void Function() serviceUpdateCallback;

  Loadable({
    required this.UUID,
    required this.serviceUpdateCallback,
    this.lastUpdated,
    this.value,
    // required
    this.apiURI,
    this.childrenUUIDs = const [],
  });

  setVal(T val) {
    value = val;
    // this.state = LoadingState.loaded;
  }

  Future<T> getVal() async {
    await Future.delayed(Duration(milliseconds: 500));
    return this.value!;
  }
}

class LoadableService extends ChangeNotifier {
  static Map<String, DateTime> UUID_lastChangedMap = {};
  static Map<String, Loadable> loadables = {};

  void childChangeCallback() {
    notifyListeners();
  }

  static Loadable createRegisteredLoadable<T>({
    // state = LoadingState.unfeteched,
    required parentUpdateCallback,
    lastUpdated,
    value,
    // required
    apiURI,
    childrenUUIDs = const [],
  }) {
    Loadable ret = Loadable(
        UUID: LocalIdManager.generateUUID(),
        serviceUpdateCallback: parentUpdateCallback,
        apiURI: apiURI,
        childrenUUIDs: childrenUUIDs,
        lastUpdated: lastUpdated,
        // state: state,
        value: value);
    loadables[ret.UUID] = ret;
    UUID_lastChangedMap[ret.UUID] = DateTime.now();
    return ret;
  }

  void setLoadable(Loadable loadable) {
    loadables[loadable.UUID] = loadable;
    notifyListeners();
  }

  Loadable getByURI<T>(String URI, [T? testVal]) {
    if (loadables[URI] != null) {
      return loadables[URI]!;
    } else {
      Loadable ret = Loadable<T>(
          apiURI: URI,
          value: testVal,
          UUID: '',
          serviceUpdateCallback: childChangeCallback);
      loadables.addAll({URI: ret});
      return ret;
    }
  }
}

class LocalIdManager {
  static int idCounter = 2000;

  static String generateUUID() {
    idCounter++;
    //TODO: HASHING
    return idCounter.toString();
  }
}

//on data update-> data loads, while class updates as
//Each type of data has its own handler to update/change. Events.add(new), Events.update(id,new), etc. Updating with the handler, data value is set to loading, after backend response, update is reflected locally, else it is reverted.
//Adding something to the backend is different from updating/deleting, where it can be done offline. Adds are sent to a buffer from where they are sent to the server once done.
//The local storage will cache all of the data for next time, and check what has not been updated since last time before updating what is neccassary.
